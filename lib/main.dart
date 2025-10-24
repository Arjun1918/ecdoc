import 'package:ecdoc/provider/patient_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app/app.dart';
import 'app/app_routes.dart';
import 'features/auth/data/service_locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator(); // initialize dependency injection
  runApp(const MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: const Size(1024, 768),
//       minTextAdapt: true,
//       splitScreenMode: true,
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'ECDOC',
//         initialRoute: AppRoutes.login,
//         onGenerateRoute: AppRoutes.generateRoute,
//       ),
//     );
//   }
// }
