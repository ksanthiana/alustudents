import 'package:cloud_firestore/cloud_firestore.dart';

class Opportunity {
  final String id;
  final String title;
  final String organization;
  final String description;
  final List<String> tags;
  final String location;
  final String timeCommitment;
  final String postedById;
  final DateTime postedAt;

  Opportunity({
    required this.id,
    required this.title,
    required this.organization,
    required this.description,
    required this.tags,
    required this.location,
    required this.timeCommitment,
    required this.postedById,
    required this.postedAt,
  });

  factory Opportunity.fromMap(String id, Map<String, dynamic> data) {
    return Opportunity(
      id: id,
      title: data['title'] as String? ?? '',
      organization: data['organization'] as String? ?? '',
      description: data['description'] as String? ?? '',
      tags: List<String>.from(data['tags'] ?? []),
      location: data['location'] as String? ?? '',
      timeCommitment: data['timeCommitment'] as String? ?? '',
      postedById: data['postedById'] as String? ?? '',
      postedAt: (data['postedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'organization': organization,
      'description': description,
      'tags': tags,
      'location': location,
      'timeCommitment': timeCommitment,
      'postedById': postedById,
      'postedAt': postedAt,
    };
  }
}
