import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'state/app_providers.dart';
import 'screens/home_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/sign_in_screen.dart';
import 'screens/sign_up_screen.dart';
import 'screens/post_opportunity_screen.dart';

class AluInternApp extends ConsumerWidget {
  const AluInternApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ALU Internship Connect',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: const Color(0xFFF6F7FB),
      ),
      routes: {
        OnboardingScreen.routeName: (_) => const OnboardingScreen(),
        SignInScreen.routeName: (_) => const SignInScreen(),
        SignUpScreen.routeName: (_) => const SignUpScreen(),
        HomeScreen.routeName: (_) => const HomeScreen(),
        PostOpportunityScreen.routeName: (_) => const PostOpportunityScreen(),
      },
      home: authState.when(
        data: (user) {
          if (user == null) {
            return const OnboardingScreen();
          }
          return const HomeScreen();
        },
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (error, stack) => const Scaffold(
          body: Center(child: Text('Failed to initialize app')),
        ),
      ),
    );
  }
}
