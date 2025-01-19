import 'package:flutter/material.dart';
import 'package:mental_health/viewmodels/break_view_model.dart';
import 'package:mental_health/viewmodels/dashboard_view_model.dart';
import 'package:mental_health/viewmodels/hydration_view_model.dart';
import 'package:mental_health/viewmodels/mindfullness_iew_model.dart';
import 'package:mental_health/viewmodels/mood_tracking_view_model.dart';
import 'package:mental_health/viewmodels/sign_in.dart';
import 'package:mental_health/views/HomeScreen.dart';
import 'package:mental_health/views/break_remainder_screen.dart';
import 'package:mental_health/views/course_screen.dart';
import 'package:mental_health/views/mindfullness_screen.dart';
import 'package:mental_health/views/questionare_screen.dart';
import 'package:mental_health/views/track_screen.dart';
import 'package:provider/provider.dart';

// Import Views
import 'views/sign_in_screen.dart';
import 'views/home_dashboard.dart';
import 'views/hydration_screen.dart';
import 'views/mood_tracking_screen.dart';

// Import ViewModels

void main() {
  runApp(SelfCareApp());
}

class SelfCareApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignInViewModel()),
        Provider(create: (_) => DashboardViewModel()),
        Provider(create: (_) => BreakViewModel()),
        Provider(create: (_) => HydrationViewModel()),
        Provider(create: (_) => MoodTrackingViewModel()),
        Provider(create: (_) => MindfulnessViewModel()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Self-Care Reminder',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SignInScreen(),
          '/home': (context) => HomeScreen(),
          '/question': (context) => HackathonQuestionnaireScreen(),
          '/break': (context) => BreakReminderScreen(),
          '/hydration': (context) => HydrationScreen(),
          '/mood': (context) => MoodTrackingScreen(),
          '/mindfulness': (context) => MindfulnessScreen(),
          // '/settings': (context) => SettingsScreen(),
          // '/': (context) => HomeScreen(),
          '/course': (context) => CourseScreen(),
          '/track': (context) => TrackScreen(),
        },
      ),
    );
  }
}
