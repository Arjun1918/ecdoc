import 'package:ecdoc/constants/widgets/slide_transition.dart';
import 'package:ecdoc/screens/doctor_profile_screen.dart';
import 'package:ecdoc/screens/patient_list.dart';
import 'package:ecdoc/screens/patient_page.dart';
import 'package:ecdoc/screens/login/login_screen.dart';
import 'package:ecdoc/screens/dashboard/medical_dashboard.dart';
import 'package:ecdoc/screens/wallet_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String dashboard = '/dashboard';
  static const String login = '/login';
  static const String patientpage = '/patientpage';
  static const String patientlist = '/patientlist';
  static const String vaccination = '/vaccination';
  static const String profile = '/profile';
  static const String wallet = '/wallet';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
      case login:
        return SlideTransitionRoute.create(
          settings: settings,
          destination: const LoginScreen(),
        );
      case dashboard:
        return SlideTransitionRoute.create(
          settings: settings,
          destination: const DashboardScreen(),
        );
      case profile:
        return SlideTransitionRoute.create(
          settings: settings,
          destination: const DoctorProfileScreen(),
        );
      case wallet:
        return SlideTransitionRoute.create(
          settings: settings,
          destination: const PaymentDashboardScreen(),
        );
      case patientpage:
        return SlideTransitionRoute.create(
          settings: settings,
          destination: const ConsultationPage(),
        );
      case patientlist:
        return SlideTransitionRoute.create(
          settings: settings,
          destination: const PatientListScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('No route defined for this path')),
          ),
        );
    }
  }
}
