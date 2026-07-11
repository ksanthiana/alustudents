import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/application.dart';
import '../state/app_providers.dart';

class ApplicationsScreen extends ConsumerWidget {
  const ApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final applicationsAsync = ref.watch(myApplicationsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        title: const Text('My applications'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: applicationsAsync.when(
          data: (applications) {
            if (applications.isEmpty) {
              return const Center(
                child: Text(
                  'You have not applied to any opportunities yet.',
                  style: TextStyle(color: Color(0xFF475569), fontSize: 16),
                ),
              );
            }
            return ListView.separated(
              itemCount: applications.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final application = applications[index];
                return ApplicationCard(application: application);
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Text(
              'Error loading applications: $error',
              style: const TextStyle(color: Color(0xFFEF4444)),
            ),
          ),
        ),
      ),
    );
  }
}

class ApplicationCard extends StatelessWidget {
  final Application application;

  const ApplicationCard({super.key, required this.application});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFEEF2FF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.work_outline, color: Color(0xFF4338CA)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Opportunity ${application.opportunityId}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Status: ${application.status}',
                  style: const TextStyle(color: Color(0xFF475569)),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Chip(
                label: Text(
                  application.status.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF334155),
                  ),
                ),
                backgroundColor: const Color(0xFFF8FAFC),
              ),
              const SizedBox(height: 8),
              Text(
                '${application.appliedAt.month}/${application.appliedAt.day}/${application.appliedAt.year}',
                style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
