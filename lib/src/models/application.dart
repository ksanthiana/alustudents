import 'package:cloud_firestore/cloud_firestore.dart';

class Application {
  final String id;
  final String opportunityId;
  final String opportunityTitle;
  final String applicantId;
  final String status;
  final DateTime appliedAt;

  Application({
    required this.id,
    required this.opportunityId,
    required this.opportunityTitle,
    required this.applicantId,
    required this.status,
    required this.appliedAt,
  });

  factory Application.fromMap(String id, Map<String, dynamic> data) {
    return Application(
      id: id,
      opportunityId: data['opportunityId'] as String? ?? '',
      opportunityTitle: data['opportunityTitle'] as String? ?? 'Opportunity',
      applicantId: data['applicantId'] as String? ?? '',
      status: data['status'] as String? ?? 'applied',
      appliedAt: (data['appliedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'opportunityId': opportunityId,
      'opportunityTitle': opportunityTitle,
      'applicantId': applicantId,
      'status': status,
      'appliedAt': appliedAt,
    };
  }
}
