import 'package:flutter/material.dart';

import 'sign_in_screen.dart';
import 'sign_up_screen.dart';

class OnboardingScreen extends StatelessWidget {
  static const routeName = '/onboarding';

  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF4F46E5), Color(0xFF0EA5E9)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 520),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.96),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 24,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEF2FF),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Icon(
                        Icons.school_rounded,
                        color: Color(0xFF5B5BD6),
                        size: 30,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Welcome to ALU Internship Connect',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E1B4B),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Discover verified internship opportunities from ALU student-led ventures and startups in one polished place.',
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.6,
                        color: Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _FeatureItem(
                      text: 'Verified ALU startup and student accounts only.',
                    ),
                    _FeatureItem(
                      text:
                          'Explore roles in engineering, design, marketing, and research.',
                    ),
                    _FeatureItem(
                      text:
                          'Track applications and manage your startup profile from one place.',
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pushNamed(
                          context,
                          SignUpScreen.routeName,
                        ),
                        child: const Text('Create your ALU account'),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => Navigator.pushNamed(
                          context,
                          SignInScreen.routeName,
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 14,
                          ),
                          side: const BorderSide(color: Color(0xFFCBD5E1)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text('I already have an account'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Text(
                        'Only ALU student emails ending in @alustudent.com can register. Use the correct email to stay approved.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF475569),
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String text;

  const _FeatureItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle_outline,
            color: Color(0xFF5B5BD6),
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF334155),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
