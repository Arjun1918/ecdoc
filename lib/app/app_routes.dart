import 'package:ecdoc/features/profile/presentation/doctor_profile_screen.dart';
import 'package:ecdoc/features/patients/presentation/patient_list.dart';
import 'package:ecdoc/features/consultation/presentation/consultation_page.dart';
import 'package:ecdoc/features/auth/presentation/login_screen.dart';
import 'package:ecdoc/features/wallet/presentation/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../features/auth/logic/auth_bloc.dart';
import '../features/dashboard/presentation/medical_dashboard.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String dashboard = '/dashboard';
  static const String login = '/login';
  static const String consultation = '/consultation';
  static const String patientList = '/patient_list';
  static const String vaccination = '/vaccination';
  static const String profile = '/profile';
  static const String wallet = '/wallet';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => AuthBloc(),
            child: const LoginScreen(),
          ),
          settings: settings,
        );

      case AppRoutes.dashboard:
        return MaterialPageRoute(
          builder: (_) => const DashboardScreen(),
          settings: settings,
        );

      case AppRoutes.profile:
        return MaterialPageRoute(
          builder: (_) => const DoctorProfileScreen(),
          settings: settings,
        );

      case AppRoutes.wallet:
        return MaterialPageRoute(
          builder: (_) => const WalletScreen(),
          settings: settings,
        );

      case AppRoutes.patientList:
        return MaterialPageRoute(
          builder: (_) => const PatientListScreen(),
          settings: settings,
        );

      case AppRoutes.consultation:
        return MaterialPageRoute(
          builder: (_) => const ConsultationPage(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) =>
          const Scaffold(
            body: Center(child: Text('No route defined for this path')),
          ),
        );
    }
  }
}
