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

  Stream<List<Opportunity>> opportunityStream({String? searchTerm, String? category}) {
    final query = firestore.collection('opportunities').orderBy('postedAt', descending: true);
    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Opportunity.fromMap(doc.id, doc.data())).where((opportunity) {
        final matchesSearch = searchTerm == null || searchTerm.isEmpty || opportunity.title.toLowerCase().contains(searchTerm.toLowerCase()) || opportunity.organization.toLowerCase().contains(searchTerm.toLowerCase());
        final matchesCategory = category == null || category.isEmpty || opportunity.tags.contains(category);
        return matchesSearch && matchesCategory;
      }).toList();
    });
  }

  Stream<List<Application>> applicationsForUser(String userId) {
    return firestore
        .collection('applications')
        .where('applicantId', isEqualTo: userId)
        .orderBy('appliedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Application.fromMap(doc.id, doc.data())).toList());
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
}
