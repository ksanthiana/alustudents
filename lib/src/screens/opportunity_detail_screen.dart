import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/application.dart';
import '../models/opportunity.dart';
import '../state/app_providers.dart';

class OpportunityDetailScreen extends ConsumerWidget {
  static const routeName = '/opportunity-detail';

  final Opportunity opportunity;

  const OpportunityDetailScreen({super.key, required this.opportunity});

  Future<void> _submitApplication(BuildContext context, WidgetRef ref) async {
    final authState = ref.read(authStateProvider).asData?.value;
    final userProfile = ref.read(userProfileProvider).asData?.value;

    if (authState == null || userProfile == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please sign in to apply.')),
        );
      }
      return;
    }

    final application = Application(
      id: '',
      opportunityId: opportunity.id,
      opportunityTitle: opportunity.title,
      applicantId: authState.uid,
      status: 'applied',
      appliedAt: DateTime.now(),
    );

    await ref.read(firestoreRepositoryProvider).submitApplication(application);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Application submitted successfully.')),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final daysAgo = DateTime.now().difference(opportunity.postedAt).inDays;
    final authState = ref.watch(authStateProvider).asData?.value;
    final userProfile = ref.watch(userProfileProvider).asData?.value;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        title: const Text('Opportunity details'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    opportunity.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    opportunity.organization,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF475569),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _DetailBadge(
                        icon: Icons.location_on,
                        label: opportunity.location,
                      ),
                      const SizedBox(width: 10),
                      _DetailBadge(
                        icon: Icons.schedule,
                        label: opportunity.timeCommitment,
                      ),
                      const SizedBox(width: 10),
                      _DetailBadge(
                        icon: Icons.calendar_today,
                        label: '${daysAgo}d ago',
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: opportunity.tags
                        .map(
                          (tag) => Chip(
                            label: Text(tag),
                            backgroundColor: const Color(0xFFF8FAFC),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    opportunity.description,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.6,
                      color: Color(0xFF475569),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      final isSignedIn =
                          authState != null && userProfile != null;
                      if (!isSignedIn) {
                        Navigator.pushNamed(context, '/sign-in');
                        return;
                      }
                      _submitApplication(context, ref);
                    },
                    child: Text(
                      authState == null || userProfile == null
                          ? 'Sign in to apply'
                          : 'Apply now',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailBadge extends StatelessWidget {
  final IconData icon;
  final String label;

  const _DetailBadge({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: const Color(0xFF475569)),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(color: Color(0xFF475569), fontSize: 13),
          ),
        ],
      ),
    );
  }
}
