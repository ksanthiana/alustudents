import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_alu_intern/src/models/application.dart';
import 'package:flutter_application_alu_intern/src/screens/profile_screen.dart';

void main() {
  group('buildProfileStats', () {
    test('counts applications, shortlisted, and accepted statuses from real data', () {
      final applications = [
        Application(
          id: '1',
          opportunityId: 'o1',
          opportunityTitle: 'Dev',
          applicantId: 'u1',
          status: 'applied',
          appliedAt: DateTime.now(),
        ),
        Application(
          id: '2',
          opportunityId: 'o2',
          opportunityTitle: 'Design',
          applicantId: 'u1',
          status: 'interview',
          appliedAt: DateTime.now(),
        ),
        Application(
          id: '3',
          opportunityId: 'o3',
          opportunityTitle: 'Product',
          applicantId: 'u1',
          status: 'accepted',
          appliedAt: DateTime.now(),
        ),
        Application(
          id: '4',
          opportunityId: 'o4',
          opportunityTitle: 'Research',
          applicantId: 'u1',
          status: 'accepted',
          appliedAt: DateTime.now(),
        ),
      ];

      final stats = buildProfileStats(applications);

      expect(stats['applications'], 4);
      expect(stats['shortlisted'], 1);
      expect(stats['accepted'], 2);
    });
  });
}
