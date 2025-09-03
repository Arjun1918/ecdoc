import 'package:ecdoc/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopNavigationBar extends StatelessWidget {
  const TopNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/logo.jpeg',
                width: 60.w,
                height: 60.h,
                fit: BoxFit.contain,
              ),
            ],
          ),
          const Spacer(),
          _buildNavItem('Book appointment', true),
          SizedBox(width: 20.w),
          _buildNavItem('Dashboard', false),
          SizedBox(width: 20.w),
          _buildNavItem('Patient', false),
          SizedBox(width: 20.w),
          _buildNavItem('Chat', false),
          SizedBox(width: 20.w),
          _buildNavItem('Report', false),
          SizedBox(width: 20.w),
          _buildNavItem('Wallet', false),
          const Spacer(),
          Icon(Icons.settings, size: 24.sp, color: Colors.grey),
          SizedBox(width: 15.w),
          Icon(Icons.notifications_outlined, size: 24.sp, color: Colors.grey),
          SizedBox(width: 15.w),
          CircleAvatar(
            radius: 18.r,
            backgroundImage: const AssetImage('assets/images/profile.png'),
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String title, bool isActive) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isActive ? AppTheme.primaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.grey[600],
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
