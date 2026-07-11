class UserProfile {
  final String id;
  final String displayName;
  final String email;
  final bool isStartup;
  final String? organizationName;

  UserProfile({
    required this.id,
    required this.displayName,
    required this.email,
    required this.isStartup,
    this.organizationName,
  });

  factory UserProfile.fromMap(String id, Map<String, dynamic> data) {
    return UserProfile(
      id: id,
      displayName: data['displayName'] as String? ?? '',
      email: data['email'] as String? ?? '',
      isStartup: data['isStartup'] as bool? ?? false,
      organizationName: data['organizationName'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'email': email,
      'isStartup': isStartup,
      'organizationName': organizationName,
    };
  }
}
