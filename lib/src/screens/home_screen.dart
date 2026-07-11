import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/opportunity.dart';
import '../state/app_providers.dart';
import 'applications_screen.dart';
import 'opportunity_detail_screen.dart';
import 'post_opportunity_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final locationController = TextEditingController();

  @override
  void dispose() {
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final opportunitiesAsync = ref.watch(opportunityListProvider);
    final userProfileAsync = ref.watch(userProfileProvider);
    final category = ref.watch(selectedCategoryProvider);
    final remoteOnly = ref.watch(remoteOnlyProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 16,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('ALU Internship Connect', style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold, fontSize: 20)),
            SizedBox(height: 4),
            Text('Find verified internships and student opportunities.', style: TextStyle(color: Color(0xFF475569), fontSize: 14)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.list_alt, color: Color(0xFF475569)),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ApplicationsScreen())),
            tooltip: 'My applications',
          ),
          IconButton(
            icon: const Icon(Icons.person, color: Color(0xFF475569)),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen())),
            tooltip: 'Profile',
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Color(0xFF475569)),
            onPressed: () => ref.read(authServiceProvider).signOut(),
            tooltip: 'Sign out',
          ),
          const SizedBox(width: 8),
        ],
      ),
      floatingActionButton: userProfileAsync.when(
        data: (profile) {
          if (profile?.isStartup ?? false) {
            return FloatingActionButton.extended(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PostOpportunityScreen())),
              icon: const Icon(Icons.post_add),
              label: const Text('Post opportunity'),
            );
          }
          return null;
        },
        loading: () => const SizedBox.shrink(),
        error: (error, stack) => const SizedBox.shrink(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20, offset: const Offset(0, 8)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Explore opportunities', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF111827))),
                  const SizedBox(height: 8),
                  const Text('Search internships, fellowships and student roles from ALU startups.', style: TextStyle(fontSize: 14, color: Color(0xFF64748B), height: 1.5)),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search keywords',
                      filled: true,
                      fillColor: const Color(0xFFF8FAFC),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                    ),
                    onChanged: (value) => ref.read(searchQueryProvider.notifier).state = value,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: locationController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.location_on_outlined),
                            hintText: 'Location',
                            filled: true,
                            fillColor: const Color(0xFFF8FAFC),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Transform.scale(
                              scale: 0.9,
                              child: Switch(
                                value: remoteOnly,
                                onChanged: (value) => ref.read(remoteOnlyProvider.notifier).state = value,
                              ),
                            ),
                            const Text('Remote', style: TextStyle(fontSize: 13, color: Color(0xFF334155))),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _CategoryChip(label: 'Design', selected: category == 'Design', onSelected: (selected) => ref.read(selectedCategoryProvider.notifier).state = selected ? 'Design' : null),
                      _CategoryChip(label: 'Engineering', selected: category == 'Engineering', onSelected: (selected) => ref.read(selectedCategoryProvider.notifier).state = selected ? 'Engineering' : null),
                      _CategoryChip(label: 'Marketing', selected: category == 'Marketing', onSelected: (selected) => ref.read(selectedCategoryProvider.notifier).state = selected ? 'Marketing' : null),
                      _CategoryChip(label: 'Data', selected: category == 'Data', onSelected: (selected) => ref.read(selectedCategoryProvider.notifier).state = selected ? 'Data' : null),
                      _CategoryChip(label: 'Fellowships', selected: category == 'Fellowships', onSelected: (selected) => ref.read(selectedCategoryProvider.notifier).state = selected ? 'Fellowships' : null),
                    ],
                  ),
                  const SizedBox(height: 18),
                  ElevatedButton(
                    onPressed: () => FocusScope.of(context).unfocus(),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(52),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text('Search opportunities'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: opportunitiesAsync.when(
                data: (opportunities) {
                  if (opportunities.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.search_off, size: 56, color: Color(0xFF94A3B8)),
                          SizedBox(height: 16),
                          Text('No opportunities found', style: TextStyle(fontSize: 16, color: Color(0xFF475569))),
                          SizedBox(height: 6),
                          Text('Try broadening your keywords or choosing another category.', style: TextStyle(fontSize: 14, color: Color(0xFF64748B))),
                        ],
                      ),
                    );
                  }

                  return ListView.separated(
                    itemCount: opportunities.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final opportunity = opportunities[index];
                      return OpportunityCard(opportunity: opportunity);
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text('Error loading opportunities: $error', style: const TextStyle(color: Color(0xFFEF4444)))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;

  const _CategoryChip({required this.label, required this.selected, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label, style: TextStyle(color: selected ? Colors.white : const Color(0xFF334155))),
      selected: selected,
      onSelected: onSelected,
      selectedColor: const Color(0xFF4338CA),
      backgroundColor: const Color(0xFFF8FAFC),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    );
  }
}

class OpportunityCard extends ConsumerWidget {
  final Opportunity opportunity;

  const OpportunityCard({super.key, required this.opportunity});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postedDays = DateTime.now().difference(opportunity.postedAt).inDays;
    final authState = ref.watch(authStateProvider);

    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => OpportunityDetailScreen(opportunity: opportunity))),
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 18, offset: const Offset(0, 8)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(opportunity.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF111827))),
                      const SizedBox(height: 6),
                      Text(opportunity.organization, style: const TextStyle(fontSize: 14, color: Color(0xFF475569))),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF2FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(opportunity.timeCommitment, style: const TextStyle(color: Color(0xFF4338CA), fontSize: 12)),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: opportunity.tags.take(4).map((tag) => Chip(label: Text(tag), backgroundColor: const Color(0xFFF8FAFC), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)))).toList(),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 16, color: Color(0xFF64748B)),
                const SizedBox(width: 6),
                Expanded(child: Text(opportunity.location, style: const TextStyle(color: Color(0xFF64748B)))),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: Text('Posted ${postedDays}d ago', style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 40),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () {
                    if (authState.asData?.value == null) {
                      Navigator.pushNamed(context, '/sign-in');
                      return;
                    }
                    Navigator.push(context, MaterialPageRoute(builder: (_) => OpportunityDetailScreen(opportunity: opportunity)));
                  },
                  child: Text(authState.asData?.value == null ? 'Sign in' : 'Apply', style: const TextStyle(fontSize: 14)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
