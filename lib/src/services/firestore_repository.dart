import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/application.dart';
import '../models/opportunity.dart';
import '../models/user_profile.dart';

class FirestoreRepository {
  final FirebaseFirestore firestore;

  FirestoreRepository({required this.firestore});

  Stream<UserProfile?> userProfileStream(String userId) {
    return firestore.collection('users').doc(userId).snapshots().map((snapshot) {
      if (!snapshot.exists || snapshot.data() == null) {
        return null;
      }
      return UserProfile.fromMap(snapshot.id, snapshot.data()!);
    });
  }

  Stream<List<Opportunity>> opportunityStream({
    String? searchTerm,
    String? locationQuery,
    bool remoteOnly = false,
    String? category,
    String? type,
    String? duration,
  }) {
    final query = firestore.collection('opportunities').orderBy('postedAt', descending: true);
    return query.snapshots().map((snapshot) {
      final opportunities = snapshot.docs.map((doc) => Opportunity.fromMap(doc.id, doc.data()));
      return opportunities.where((opportunity) {
        final lowerSearch = searchTerm?.toLowerCase() ?? '';
        final lowerLocation = locationQuery?.toLowerCase() ?? '';
        final matchesSearch = lowerSearch.isEmpty ||
            opportunity.title.toLowerCase().contains(lowerSearch) ||
            opportunity.organization.toLowerCase().contains(lowerSearch) ||
            opportunity.description.toLowerCase().contains(lowerSearch);
        final matchesCategory = category == null || category.isEmpty || opportunity.tags.contains(category);
        final matchesType = type == null || type.isEmpty || opportunity.tags.contains(type);
        final lowerDuration = duration?.toLowerCase() ?? '';
        final matchesDuration = lowerDuration.isEmpty || lowerDuration == 'any duration' || opportunity.timeCommitment.toLowerCase().contains(lowerDuration);
        final matchesLocation = lowerLocation.isEmpty ||
            opportunity.location.toLowerCase().contains(lowerLocation) ||
            opportunity.tags.any((tag) => tag.toLowerCase().contains(lowerLocation));
        final matchesRemote = !remoteOnly ||
            opportunity.location.toLowerCase() == 'remote' ||
            opportunity.tags.any((tag) => tag.toLowerCase() == 'remote');
        return matchesSearch && matchesCategory && matchesType && matchesDuration && matchesLocation && matchesRemote;
      }).toList();
    });
  }

  Stream<List<Application>> applicationsForUser(String userId) {
    return firestore
        .collection('applications')
        .where('applicantId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
          final applications = snapshot.docs
              .map((doc) => Application.fromMap(doc.id, doc.data()))
              .toList();
          // Sort by appliedAt descending (most recent first)
          applications.sort((a, b) => b.appliedAt.compareTo(a.appliedAt));
          return applications;
        });
  }

  Future<void> saveUserProfile(UserProfile profile) {
    return firestore.collection('users').doc(profile.id).set(profile.toMap(), SetOptions(merge: true));
  }

  Future<void> postOpportunity(Opportunity opportunity) {
    final doc = firestore.collection('opportunities').doc();
    return doc.set(opportunity.toMap());
  }

  Future<void> submitApplication(Application application) {
    final doc = firestore.collection('applications').doc();
    return doc.set(application.toMap());
  }

  Future<void> deleteApplication(String applicationId) {
    return firestore.collection('applications').doc(applicationId).delete();
  }

  Future<bool> hasApplied(String userId, String opportunityId) async {
    final snapshot = await firestore
        .collection('applications')
        .where('applicantId', isEqualTo: userId)
        .where('opportunityId', isEqualTo: opportunityId)
        .limit(1)
        .get();
    return snapshot.docs.isNotEmpty;
  }
}
