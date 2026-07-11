import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/app_providers.dart';
import 'post_opportunity_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(userProfileProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: profileAsync.when(
          data: (profile) {
            if (profile == null) {
              return const Center(child: Text('No profile data available.', style: TextStyle(color: Color(0xFF475569), fontSize: 16)));
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 18, offset: const Offset(0, 8))],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(radius: 28, backgroundColor: Color(0xFF4338CA), child: Icon(Icons.person, color: Colors.white, size: 30)),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(profile.displayName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF111827))),
                                const SizedBox(height: 6),
                                Text(profile.email, style: const TextStyle(color: Color(0xFF475569))),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          _ProfileBadge(label: profile.isStartup ? 'Startup account' : 'Student account'),
                          const SizedBox(width: 10),
                          if (profile.organizationName != null) _ProfileBadge(label: 'Organization'),
                        ],
                      ),
                      if (profile.organizationName != null) ...[
                        const SizedBox(height: 18),
                        Text('Organization', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF111827))),
                        const SizedBox(height: 6),
                        Text(profile.organizationName!, style: const TextStyle(color: Color(0xFF475569))),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                if (profile.isStartup)
                  ElevatedButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PostOpportunityScreen())),
                    style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(56), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                    child: const Text('Post new opportunity'),
                  ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error loading profile: $error', style: const TextStyle(color: Color(0xFFEF4444)))),
        ),
      ),
    );
  }
}

class _ProfileBadge extends StatelessWidget {
  final String label;

  const _ProfileBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(14)),
      child: Text(label, style: const TextStyle(color: Color(0xFF475569), fontSize: 13)),
    );
  }
}
