

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await seedOpportunities();
}

Future<void> seedOpportunities() async {
  final firestore = FirebaseFirestore.instance;
  final collection = firestore.collection('opportunities');

  final opportunities = [
    {
      'title': 'Frontend Developer Intern',
      'organization': 'Kigali HealthTech Startup',
      'description':
          'Work with our team to build responsive web interfaces using React and Tailwind CSS for a health records platform serving Rwandan clinics.',
      'tags': ['Engineering', 'Remote', 'Frontend'],
      'location': 'Remote',
      'timeCommitment': 'Part-time',
      'postedById': 'seed-script',
      'postedAt': Timestamp.now(),
    },
    {
      'title': 'Backend Engineering Intern (Node.js/Firebase)',
      'organization': 'EduConnect Rwanda',
      'description':
          'Support development of REST APIs and Firestore data models powering an e-learning platform for secondary schools.',
      'tags': ['Engineering', 'Kigali', 'Backend'],
      'location': 'Kigali',
      'timeCommitment': 'Full-time',
      'postedById': 'seed-script',
      'postedAt': Timestamp.now(),
    },
    {
      'title': 'Mobile App Developer Intern (Flutter)',
      'organization': 'AgriTrack',
      'description':
          'Help build and test features for a Flutter app that helps smallholder farmers track crop yields and market prices.',
      'tags': ['Engineering', 'Remote', 'Flutter'],
      'location': 'Remote',
      'timeCommitment': 'Part-time',
      'postedById': 'seed-script',
      'postedAt': Timestamp.now(),
    },
    {
      'title': 'QA/Testing Intern',
      'organization': 'PayRwanda Fintech',
      'description':
          'Write and execute test cases for a mobile payments app, report bugs, and help improve our automated testing pipeline.',
      'tags': ['Engineering', 'Kigali', 'QA'],
      'location': 'Kigali',
      'timeCommitment': 'Full-time',
      'postedById': 'seed-script',
      'postedAt': Timestamp.now(),
    },
    {
      'title': 'DevOps Intern',
      'organization': 'CloudNest Africa',
      'description':
          'Assist with CI/CD pipeline setup, containerization with Docker, and basic cloud infrastructure monitoring.',
      'tags': ['Engineering', 'Remote', 'DevOps'],
      'location': 'Remote',
      'timeCommitment': 'Part-time',
      'postedById': 'seed-script',
      'postedAt': Timestamp.now(),
    },
    {
      'title': 'UI/UX Design Intern',
      'organization': 'Zuba Creative Studio',
      'description':
          'Design wireframes and high-fidelity prototypes in Figma for client mobile and web projects across East Africa.',
      'tags': ['Design', 'Kigali', 'UI/UX'],
      'location': 'Kigali',
      'timeCommitment': 'Full-time',
      'postedById': 'seed-script',
      'postedAt': Timestamp.now(),
    },
    {
      'title': 'Product Design Intern',
      'organization': 'LinkUp ALU Alumni Platform',
      'description':
          'Collaborate with engineers and PMs to design user flows for an alumni networking and mentorship app.',
      'tags': ['Design', 'Remote', 'Product'],
      'location': 'Remote',
      'timeCommitment': 'Part-time',
      'postedById': 'seed-script',
      'postedAt': Timestamp.now(),
    },
    {
      'title': 'Graphic Design & Branding Intern',
      'organization': 'Kigali Fashion Collective',
      'description':
          'Create branding assets, social media graphics, and lookbooks for emerging Rwandan fashion designers.',
      'tags': ['Design', 'Kigali', 'Branding'],
      'location': 'Kigali',
      'timeCommitment': 'Part-time',
      'postedById': 'seed-script',
      'postedAt': Timestamp.now(),
    },
    {
      'title': 'Motion Graphics Intern',
      'organization': 'StreamAfrica Media',
      'description':
          'Produce short animated explainer videos and social content using After Effects for a growing media startup.',
      'tags': ['Design', 'Remote', 'Motion'],
      'location': 'Remote',
      'timeCommitment': 'Part-time',
      'postedById': 'seed-script',
      'postedAt': Timestamp.now(),
    },
    {
      'title': 'Social Media Marketing Intern',
      'organization': 'GreenHarvest Agritech',
      'description':
          'Plan and schedule content across Instagram, TikTok, and X to grow awareness of sustainable farming products.',
      'tags': ['Marketing', 'Remote', 'Social'],
      'location': 'Remote',
      'timeCommitment': 'Part-time',
      'postedById': 'seed-script',
      'postedAt': Timestamp.now(),
    },
    {
      'title': 'Growth Marketing Intern',
      'organization': 'Wano Delivery',
      'description':
          'Run referral campaigns and analyze user acquisition funnels for a last-mile delivery startup in Kigali.',
      'tags': ['Marketing', 'Kigali', 'Growth'],
      'location': 'Kigali',
      'timeCommitment': 'Full-time',
      'postedById': 'seed-script',
      'postedAt': Timestamp.now(),
    },
    {
      'title': 'Content Writer/Marketing Intern',
      'organization': 'ALU Student Ventures',
      'description':
          'Write blog posts, newsletters, and case studies highlighting student-led startups across ALU campuses.',
      'tags': ['Marketing', 'Remote', 'Content'],
      'location': 'Remote',
      'timeCommitment': 'Part-time',
      'postedById': 'seed-script',
      'postedAt': Timestamp.now(),
    },
    {
      'title': 'Brand Partnerships Intern',
      'organization': 'Kigali Startups Hub',
      'description':
          'Support outreach to potential sponsors and partners for community tech events and hackathons.',
      'tags': ['Marketing', 'Kigali', 'Partnerships'],
      'location': 'Kigali',
      'timeCommitment': 'Full-time',
      'postedById': 'seed-script',
      'postedAt': Timestamp.now(),
    },
    {
      'title': 'Data Analyst Intern',
      'organization': 'RwandaStats Consulting',
      'description':
          'Clean and analyze survey datasets using Python/pandas, and build dashboards for client reporting.',
      'tags': ['Data', 'Remote', 'Analytics'],
      'location': 'Remote',
      'timeCommitment': 'Part-time',
      'postedById': 'seed-script',
      'postedAt': Timestamp.now(),
    },
    {
      'title': 'Machine Learning Intern (Malaria Prediction Project)',
      'organization': 'HealthAI Rwanda',
      'description':
          'Support model development for predicting malaria outbreak risk using regional health and climate datasets.',
      'tags': ['Data', 'Kigali', 'Machine Learning'],
      'location': 'Kigali',
      'timeCommitment': 'Full-time',
      'postedById': 'seed-script',
      'postedAt': Timestamp.now(),
    },
    {
      'title': 'Business Intelligence Intern',
      'organization': 'MicroFinance Plus',
      'description':
          'Build SQL queries and Power BI dashboards to track loan repayment trends for a microfinance institution.',
      'tags': ['Data', 'Remote', 'BI'],
      'location': 'Remote',
      'timeCommitment': 'Part-time',
      'postedById': 'seed-script',
      'postedAt': Timestamp.now(),
    },
    {
      'title': 'Data Entry & Cleaning Intern',
      'organization': 'Census Support Unit',
      'description':
          'Assist in digitizing and validating household survey records ahead of a regional census initiative.',
      'tags': ['Data', 'Kigali', 'Operations'],
      'location': 'Kigali',
      'timeCommitment': 'Full-time',
      'postedById': 'seed-script',
      'postedAt': Timestamp.now(),
    },
    {
      'title': 'ALU Innovation Fellowship',
      'organization': 'African Leadership University',
      'description':
          'A 6-month fellowship supporting student founders to develop early-stage ventures with mentorship and seed funding.',
      'tags': ['Fellowships', 'Kigali', 'ALU'],
      'location': 'Kigali',
      'timeCommitment': 'Full-time',
      'postedById': 'seed-script',
      'postedAt': Timestamp.now(),
    },
    {
      'title': 'Google Africa Developer Fellowship',
      'organization': 'Google',
      'description':
          'A remote fellowship for student developers to build and ship a project with mentorship from Google engineers.',
      'tags': ['Fellowships', 'Remote', 'Google'],
      'location': 'Remote',
      'timeCommitment': 'Full-time',
      'postedById': 'seed-script',
      'postedAt': Timestamp.now(),
    },
    {
      'title': 'MEST Africa Entrepreneurship Fellowship',
      'organization': 'MEST Africa',
      'description':
          'An intensive program teaching entrepreneurship, software development, and business fundamentals to early founders.',
      'tags': ['Fellowships', 'Remote', 'Entrepreneurship'],
      'location': 'Remote',
      'timeCommitment': 'Full-time',
      'postedById': 'seed-script',
      'postedAt': Timestamp.now(),
    },
    {
      'title': 'Mandela Washington Fellowship (Business Track)',
      'organization': 'U.S. Embassy',
      'description':
          'A leadership fellowship for young African professionals focusing on business, civic leadership, and public management.',
      'tags': ['Fellowships', 'Remote', 'Leadership'],
      'location': 'Remote',
      'timeCommitment': 'Full-time',
      'postedById': 'seed-script',
      'postedAt': Timestamp.now(),
    },
  ];

  final batch = firestore.batch();
  for (final opportunity in opportunities) {
    final doc = collection.doc();
    batch.set(doc, opportunity);
  }

  await batch.commit();
}
