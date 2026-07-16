import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/application.dart';
import '../models/user_profile.dart';
import '../state/app_providers.dart';
import 'post_opportunity_screen.dart';

Map<String, int> buildProfileStats(List<Application> applications) {
  final stats = <String, int>{
    'applications': 0,
    'shortlisted': 0,
    'accepted': 0,
  };

  for (final application in applications) {
    final normalizedStatus = application.status.toLowerCase();
    stats['applications'] = stats['applications']! + 1;

    if (normalizedStatus == 'accepted') {
      stats['accepted'] = stats['accepted']! + 1;
    } else if (normalizedStatus == 'interview' || normalizedStatus == 'shortlisted') {
      stats['shortlisted'] = stats['shortlisted']! + 1;
    }
  }

  return stats;
}

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(userProfileProvider);
    final applicationsAsync = ref.watch(myApplicationsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF111827),
          ),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF111827)),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Color(0xFF111827)),
            onPressed: () => _showEditProfileDialog(context, ref),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Color(0xFF111827)),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: profileAsync.when(
            data: (profile) {
              if (profile == null) {
                return const Center(
                  child: Text(
                    'No profile data available.',
                    style: TextStyle(color: Color(0xFF475569), fontSize: 16),
                  ),
                );
              }

              final stats = applicationsAsync.maybeWhen(
                data: (applications) => buildProfileStats(applications),
                orElse: () => const <String, int>{
                  'applications': 0,
                  'shortlisted': 0,
                  'accepted': 0,
                },
              );

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: const Color(0xFFE5E5FF),
                          child: Text(
                            profile.displayName[0].toUpperCase(),
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF6366F1),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          profile.displayName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF111827),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          profile.email,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF94A3B8),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        // Stats row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildStat(stats['applications'].toString(), 'Applications'),
                            _buildStat(stats['shortlisted'].toString(), 'Shortlisted'),
                            _buildStat(stats['accepted'].toString(), 'Accepted'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Menu Items
                  const Text(
                    'Account',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildMenuItem(
                    context,
                    icon: Icons.person_outline,
                    title: 'My Profile',
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.school_outlined,
                    title: 'Skills & Interests',
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.bookmark_outline,
                    title: 'Saved Opportunities',
                    onTap: () {},
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildMenuItem(
                    context,
                    icon: Icons.notifications_outlined,
                    title: 'Notifications',
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.help_outline,
                    title: 'Help & Support',
                    onTap: () {},
                  ),
                  const SizedBox(height: 24),

                  // Sign out button
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextButton.icon(
                      onPressed: () => ref.read(authServiceProvider).signOut(),
                      icon: const Icon(
                        Icons.logout,
                        color: Color(0xFFEF4444),
                      ),
                      label: const Text(
                        'Logout',
                        style: TextStyle(
                          color: Color(0xFFEF4444),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Post opportunity button for startups
                  if (profile.isStartup)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PostOpportunityScreen(),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6366F1),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(Icons.add),
                        label: const Text(
                          'Post Opportunity',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: Text(
                'Error loading profile: $error',
                style: const TextStyle(color: Color(0xFFEF4444)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context, WidgetRef ref) {
    final profile = ref.read(userProfileProvider).asData?.value;
    if (profile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No profile loaded to edit.')),
      );
      return;
    }

    final nameController = TextEditingController(text: profile.displayName);
    final organizationController = TextEditingController(text: profile.organizationName);
    String? error;
    bool isSaving = false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Edit profile'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Display name'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: organizationController,
                    decoration: const InputDecoration(labelText: 'Organization'),
                  ),
                  if (error != null) ...[
                    const SizedBox(height: 10),
                    Text(error!, style: const TextStyle(color: Color(0xFFEF4444))),
                  ],
                ],
              ),
              actions: [
                TextButton(
                  onPressed: isSaving ? null : () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: isSaving
                      ? null
                      : () async {
                          final displayName = nameController.text.trim();
                          final organizationName = organizationController.text.trim();

                          if (displayName.isEmpty) {
                            setState(() {
                              error = 'Display name is required.';
                            });
                            return;
                          }

                          setState(() {
                            isSaving = true;
                            error = null;
                          });

                          final updatedProfile = UserProfile(
                            id: profile.id,
                            displayName: displayName,
                            email: profile.email,
                            isStartup: profile.isStartup,
                            organizationName: organizationName.isEmpty ? null : organizationName,
                          );

                          try {
                            await ref.read(firestoreRepositoryProvider).saveUserProfile(updatedProfile);
                            if (context.mounted) {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Profile updated successfully.')),
                              );
                            }
                          } catch (err) {
                            setState(() {
                              isSaving = false;
                              error = 'Could not save profile. Please try again.';
                            });
                          }
                        },
                  child: isSaving
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildStat(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF111827),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF94A3B8),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Icon(
          icon,
          color: const Color(0xFF6366F1),
          size: 24,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Color(0xFF111827),
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: Color(0xFFCBD5E1),
        ),
        onTap: onTap,
      ),
    );
  }
}
