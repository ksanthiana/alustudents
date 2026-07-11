import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/opportunity.dart';
import '../state/app_providers.dart';

class PostOpportunityScreen extends ConsumerStatefulWidget {
  static const routeName = '/post-opportunity';

  const PostOpportunityScreen({super.key});

  @override
  ConsumerState<PostOpportunityScreen> createState() => _PostOpportunityScreenState();
}

class _PostOpportunityScreenState extends ConsumerState<PostOpportunityScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();
  final timeController = TextEditingController();
  final tagsController = TextEditingController();
  bool isLoading = false;
  String? errorMessage;

  Future<void> _submit() async {
    final userProfile = ref.read(userProfileProvider).asData?.value;
    if (userProfile == null || !userProfile.isStartup) {
      setState(() {
        errorMessage = 'Only registered startups can post opportunities.';
      });
      return;
    }

    if (titleController.text.isEmpty || descriptionController.text.isEmpty) {
      setState(() {
        errorMessage = 'Title and description are required.';
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final opportunity = Opportunity(
      id: '',
      title: titleController.text.trim(),
      organization: userProfile.organizationName ?? userProfile.displayName,
      description: descriptionController.text.trim(),
      tags: tagsController.text.split(',').map((tag) => tag.trim()).where((tag) => tag.isNotEmpty).toList(),
      location: locationController.text.trim(),
      timeCommitment: timeController.text.trim(),
      postedById: userProfile.id,
      postedAt: DateTime.now(),
    );

    await ref.read(firestoreRepositoryProvider).postOpportunity(opportunity);

    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Opportunity posted successfully.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        title: const Text('Post opportunity'),
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
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 18, offset: const Offset(0, 8))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Create opportunity', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF111827))),
                  const SizedBox(height: 10),
                  const Text('Share this role with ALU students and startups.', style: TextStyle(fontSize: 14, color: Color(0xFF64748B), height: 1.6)),
                  const SizedBox(height: 20),
                  _buildTextField(label: 'Role title', controller: titleController),
                  const SizedBox(height: 14),
                  _buildTextField(label: 'Description', controller: descriptionController, maxLines: 5),
                  const SizedBox(height: 14),
                  _buildTextField(label: 'Location', controller: locationController),
                  const SizedBox(height: 14),
                  _buildTextField(label: 'Time commitment', controller: timeController),
                  const SizedBox(height: 14),
                  _buildTextField(label: 'Tags (comma separated)', controller: tagsController),
                  const SizedBox(height: 20),
                  if (errorMessage != null) ...[
                    Text(errorMessage!, style: const TextStyle(color: Color(0xFFB91C1C))),
                    const SizedBox(height: 12),
                  ],
                  ElevatedButton(
                    onPressed: isLoading ? null : _submit,
                    style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(56), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                    child: isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text('Post opportunity', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, required TextEditingController controller, int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: const Color(0xFFF8FAFC),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      ),
    );
  }
}
