import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/application.dart';
import '../models/opportunity.dart';
import '../models/user_profile.dart';
import '../services/auth_service.dart';
import '../services/firestore_repository.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>(
  (ref) => FirebaseAuth.instance,
);
final firebaseFirestoreProvider = Provider<FirebaseFirestore>(
  (ref) => FirebaseFirestore.instance,
);

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(auth: ref.watch(firebaseAuthProvider));
});

final firestoreRepositoryProvider = Provider<FirestoreRepository>((ref) {
  return FirestoreRepository(firestore: ref.watch(firebaseFirestoreProvider));
});

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authServiceProvider).authStateChanges();
});

final userProfileProvider = StreamProvider<UserProfile?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.maybeWhen(
    data: (user) {
      if (user == null) {
        return const Stream.empty();
      }
      return ref.watch(firestoreRepositoryProvider).userProfileStream(user.uid);
    },
    orElse: () => const Stream.empty(),
  );
});

final searchQueryProvider = StateProvider<String>((ref) => '');
final locationQueryProvider = StateProvider<String>((ref) => '');
final remoteOnlyProvider = StateProvider<bool>((ref) => false);
final selectedCategoryProvider = StateProvider<String?>((ref) => null);
final selectedTypeProvider = StateProvider<String?>((ref) => null);
final selectedDurationProvider = StateProvider<String?>((ref) => null);

final opportunityListProvider = StreamProvider<List<Opportunity>>((ref) {
  final repository = ref.watch(firestoreRepositoryProvider);
  final search = ref.watch(searchQueryProvider);
  final location = ref.watch(locationQueryProvider);
  final remoteOnly = ref.watch(remoteOnlyProvider);
  final category = ref.watch(selectedCategoryProvider);
  final type = ref.watch(selectedTypeProvider);
  final duration = ref.watch(selectedDurationProvider);

  return repository.opportunityStream(
    searchTerm: search,
    locationQuery: location,
    remoteOnly: remoteOnly,
    category: category,
    type: type,
    duration: duration,
  );
});

final myApplicationsProvider = StreamProvider<List<Application>>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.maybeWhen(
    data: (user) {
      if (user == null) {
        return const Stream.empty();
      }
      return ref
          .watch(firestoreRepositoryProvider)
          .applicationsForUser(user.uid);
    },
    orElse: () => const Stream.empty(),
  );
});
