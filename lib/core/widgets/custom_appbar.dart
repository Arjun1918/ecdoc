import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/app_routes.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(80.h);
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool isIn = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      color: Colors.white,
      child: Row(
        children: [
          Image.asset(
            "assets/images/logo.jpeg",
            width: 100.w,
            height: 50.h,
            fit: BoxFit.contain,
          ),
          SizedBox(width: 24.w),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                _toggleButton("In", isIn, Colors.green, () {
                  setState(() => isIn = true);
                }),
                _toggleButton("Out", !isIn, Colors.red, () {
                  setState(() => isIn = false);
                }),
              ],
            ),
          ),
          const Spacer(),
          _navButton(
            "Book appointment",
            active: true,
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (_) => const SizedBox()),
              // );
            },
          ),
          SizedBox(width: 8.w),
          _navButton(
            "Dashboard",
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.dashboard);
            },
          ),
          SizedBox(width: 8.w),
          _navButton(
            "Patient",
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.patientList);
            },
          ),
          SizedBox(width: 8.w),
          _navButton(
            "Chat",
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (_) => const SizedBox()),
              // );
            },
          ),
          SizedBox(width: 8.w),
          _navButton(
            "Report",
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (_) => const SizedBox()),
              // );
            },
          ),
          SizedBox(width: 8.w),
          _navButton(
            "Wallet",
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.wallet);
            },
          ),

          SizedBox(width: 16.w),

          _circleIcon(Icons.settings),
          SizedBox(width: 16.w),
          _circleIcon(Icons.notifications_outlined),
          SizedBox(width: 16.w),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.profile);
            },
            child: CircleAvatar(
              radius: 20.r,
              backgroundImage: const NetworkImage(
                'https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _toggleButton(
    String text,
    bool selected,
    Color activeColor,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: selected ? activeColor : Colors.transparent,
          borderRadius: text == "In"
              ? BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  bottomLeft: Radius.circular(30.r),
                )
              : BorderRadius.only(
                  topRight: Radius.circular(30.r),
                  bottomRight: Radius.circular(30.r),
                ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black54,
            fontSize: selected ? 18.sp : 14.sp,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  /// Navigation button
  /// Navigation button
  Widget _navButton(String text, {bool active = false, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF00BCD4) : const Color(0xFFF5F7FA),
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14.sp,
            color: active ? Colors.white : Colors.black87,
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  /// Circle icon
  Widget _circleIcon(IconData icon) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: const BoxDecoration(
        color: Color(0xFFF5F7FA),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 20.sp, color: Colors.black54),
    );
  }
}
