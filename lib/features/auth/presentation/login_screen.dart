import 'package:ecdoc/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/app_routes.dart';
import '../../../utils/device_helper.dart';
import '../logic/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => AuthBloc(),
      child: Scaffold(
        body: Row(
          children: [
            // Left side - Image
            Expanded(flex: 1,
              child: SizedBox(width: double.infinity, height: double.infinity,
                child: Image.asset('assets/images/login_image.png', fit: BoxFit.cover),
              ),
            ),
      
            // Right side - Login Form
            Expanded(flex: 1,
              child: Container(color: Colors.grey[50],
                child: Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.h,),
                    child: ConstrainedBox(constraints: BoxConstraints(maxWidth: 400.w),
                      child: Column(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(width: 120.w, decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r),
                            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: Offset(0, 5),),],),
                            child: ClipRRect(borderRadius: BorderRadius.circular(20.r),
                              child: Image.asset('assets/images/logo.jpeg', fit: BoxFit.cover,),
                            ),
                          ),
      
                          SizedBox(height: 30.h),
      
                          // Title
                          Text('Sign in to your account', textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w700, color: const Color(0xFF2D3748),),
                          ),
      
                          SizedBox(height: 10.h),
      
                          // Subtitle
                          Text('Stay connected beyond the clinic.\nMonitor health from wherever you are.', textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16.sp, color: const Color(0xFF718096), height: 1.5,),
                          ),
      
                          SizedBox(height: 20.h),
                          Card(elevation: 8,
                            shadowColor: Colors.black.withValues(alpha: 0.1),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r),),
                            child: Container(padding: EdgeInsets.all(30.w),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(height: 8.h),
                                  TextFormField(controller: _usernameController,
                                    style: TextStyle(fontSize: 16.sp),
                                    decoration: InputDecoration(hintText: 'Enter your username', hintStyle: TextStyle(color: const Color(0xFFA0AEC0), fontSize: 16.sp,), filled: true, fillColor: Colors.white,
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5,),),
                                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5,),),
                                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: Color(0xFF00BCD4), width: 2,),),
                                      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h,),
                                    ),
                                  ),
      
                                  SizedBox(height: 20.h),
      
                                  // Password field
                                  TextFormField(controller: _passwordController, obscureText: _obscurePassword,
                                    style: TextStyle(fontSize: 16.sp),
                                    decoration: InputDecoration(hintText: 'Enter password', hintStyle: TextStyle(color: const Color(0xFFA0AEC0), fontSize: 16.sp,), filled: true, fillColor: Colors.white,
                                      suffixIcon: IconButton(icon: Icon(_obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: const Color(0xFF718096), size: 22.sp,),
                                        onPressed: () {
                                          setState(() {
                                            _obscurePassword = !_obscurePassword;
                                          });
                                        },
                                      ),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5,),),
                                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5,),),
                                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: Color(0xFF00BCD4), width: 2,),),
                                      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h,),
                                    ),
                                  ),
      
                                  SizedBox(height: 10.h),
                                  Row(children: [
                                    Row(children: [
                                      Transform.scale(scale: 1.2,
                                        child: Checkbox(value: _rememberMe,
                                          onChanged: (value) {
                                          setState(() {
                                            _rememberMe = value ?? false;
                                          });
                                          },
                                          activeColor: const Color(0xFF00BCD4,),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r),),
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      Text('Remember me', style: TextStyle(fontSize: 14.sp, color: const Color(0xFF4A5568),),),
                                    ],),
                                    Spacer(),
                                    TextButton(
                                      onPressed: () {},
                                      child: Text('Forgot password?', style: TextStyle(fontSize: 14.sp, color: const Color(0xFF00BCD4), fontWeight: FontWeight.w600,),),
                                    ),
                                  ],),
                                  SizedBox(height: 15.h),

                                  BlocConsumer<AuthBloc, AuthState>(
                                    listener: (context, state) {
                                      if (state is AuthSuccess) {
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login Successful")),);
                                        Navigator.pushNamed(context, AppRoutes.dashboard);
                                      } else if (state is AuthError) {
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)),);
                                      }
                                    },
                                    builder: (context, state) {
                                      return SizedBox(width: double.infinity, height: 50.h,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            final deviceDetails = await DeviceHelper.getDeviceDetails();
                                            final ipAddress = await DeviceHelper.getIpAddress();
                                            debugPrint("the request data in button click: $deviceDetails $ipAddress ${_passwordController.text} ${_usernameController.text}");
                                            context.read<AuthBloc>().add(LoginRequested(_usernameController.text.trim(), _passwordController.text.trim(), ipAddress, deviceDetails),);
                                          },
                                          style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white, elevation: 0, shadowColor: const Color(0xFF00BCD4,).withValues(alpha: 0.3),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r,),),
                                          ),
                                          child: state is AuthLoading
                                              ? Center(
                                            child: SizedBox(width: 28.w, height: 28.w,
                                              child: const CircularProgressIndicator(strokeWidth: 3, color: Colors.white,),),
                                          )
                                              : Text('Sign In', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, letterSpacing: 0.5,),
                                          ),
                                        ),
                                      );
                                    },
                                  ),


                                  SizedBox(height: 25.h),
                                  Row(mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Don't have an account? ", style: TextStyle(fontSize: 15.sp, color: const Color(0xFF718096),),),
                                      TextButton(onPressed: () {},
                                        style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap,),
                                        child: Text('Sign up', style: TextStyle(fontSize: 15.sp, color: AppTheme.primaryColor, fontWeight: FontWeight.w600,),),
                                      ),
                                    ],
                                  ),
                                ],
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
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
