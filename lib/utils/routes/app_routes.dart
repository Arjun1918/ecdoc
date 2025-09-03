import 'package:ecdoc/constants/widgets/slide_transition.dart';
import 'package:ecdoc/screens/login/login_screen.dart';
import 'package:ecdoc/screens/dashboard/medical_dashboard.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String dashboard = '/dashboard';
  static const String login = '/login';
  static const String otpView = '/otp';
  static const String bottomNavBar = '/bottom';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String addressBook = '/address';
  static const String walletView = '/walletView';
  static const String ordersView = '/ordersView';
  static const String trackordersView = '/trackordersView';
  static const String notificationView = '/notificationView';
  static const String itemsView = '/itemsView';
  static const String itemDetailsView = '/itemsDetailsView';
  static const String cartView = '/cartView';
  static const String privacyPolicyView = '/privacyPolicyView';
  static const String faqsview = '/faqsview';
  static const String termsAndConditionsView = '/termsAndConditionsView';
  static const String cancellationPolicy = '/cancellationPolicy';
  static const String contactUs = '/contactUs';
  static const String razorpay = '/razorpay';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
      // return MaterialPageRoute(builder: (_) => const SplashView());
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
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('No route defined for this path')),
          ),
        );
    }
  }
}
