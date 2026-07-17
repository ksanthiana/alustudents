# ALU Internship Connect

ALU Internship Connect is a Flutter based mobile application that helps ALU students discover internship and startup opportunities while allowing organizations to post roles and recruit talent.

## Features

- User authentication with ALU email validation
- Student-friendly opportunity browsing and search
- Opportunity detail view with apply functionality
- Application tracking dashboard with status categories
- Startup/organization registration for posting opportunities
- Profile page with summary statistics and account actions

## Tech Stack

- Flutter
- Firebase Authentication
- Cloud Firestore
- Riverpod for state management

## Project Structure

- lib/main.dart: app entry point
- lib/src/app.dart: main app configuration and routing
- lib/src/screens/: user-facing screens such as onboarding, sign-in, home, profile, and opportunity posting
- lib/src/services/: authentication and Firestore repository services
- lib/src/models/: data models for users, opportunities, and applications
- lib/src/state/: Riverpod providers and state definitions

## Getting Started

1. Install Flutter and ensure your preferred emulator or device is available.
2. Clone the repository and navigate to the project folder.
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

## Firebase Setup

This project uses Firebase services. Make sure your Firebase project is configured correctly and that the Firebase options file is available in the app.

## Testing

Run the test suite with:

```bash
flutter test
```

## Documentation

A full technical report for this project is available in https://docs.google.com/document/d/1tIOqCAz4BhxgnDZqokE3BYY3-m0cqaAWUTv2yvO6oEk/edit?usp=sharing

