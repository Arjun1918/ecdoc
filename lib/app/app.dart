import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/storage/share_pref/shared_preferences_manager.dart';
import '../features/auth/logic/auth_bloc.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/dashboard/presentation/medical_dashboard.dart';
import 'app_routes.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1024, 768),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AuthBloc()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ECDOC',
          // initialRoute: AppRoutes.login,
          onGenerateRoute: AppRoutes.generateRoute,
          home: AppInitializer(),
        ),
      ),
    );
  }
}

class AppInitializer extends StatefulWidget {
  const AppInitializer({super.key});

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  bool _isChecking = true;
  bool _hasToken = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final token = await SharedPref().getAccessToken();
    if (token.isNotEmpty) {
      debugPrint("the login token is not empty");
      // You can add token validation or refresh check here
      setState(() {
        _hasToken = true;
        _isChecking = false;
      });
    } else {
      setState(() {
        _hasToken = false;
        _isChecking = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isChecking) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return _hasToken ? const DashboardScreen() : const LoginScreen();
  }
}
