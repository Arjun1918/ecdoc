import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/widgets/custom_appbar.dart';

class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Color(0xFFE5F6FB),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30.h),
            Container(
              width: 600.w,
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40.r,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: NetworkImage(
                          'https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg',
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Dr. Sarah Johnson",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24.sp,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            "MBBS, MD (Cardiology)",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.teal[400],
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.teal,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 10.h,
                          ),
                          elevation: 0,
                          side: BorderSide(color: Colors.teal),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        icon: Icon(Icons.edit, size: 18.sp),
                        label: Text(
                          'Edit Profile',
                          style: TextStyle(fontSize: 14.sp),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Contact Information
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Contact Information",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            ListTile(
                              dense: true,
                              leading: Icon(
                                Icons.email,
                                color: Colors.teal,
                                size: 22.sp,
                              ),
                              title: Text(
                                "dr.sarah.johnson@mediclinic.com",
                                style: TextStyle(fontSize: 14.sp),
                              ),
                            ),
                            ListTile(
                              dense: true,
                              leading: Icon(
                                Icons.phone,
                                color: Colors.teal,
                                size: 22.sp,
                              ),
                              title: Text(
                                "+1 (555) 123-4567",
                                style: TextStyle(fontSize: 14.sp),
                              ),
                            ),
                            ListTile(
                              dense: true,
                              leading: Icon(
                                Icons.location_on,
                                color: Colors.teal,
                                size: 22.sp,
                              ),
                              title: Text(
                                "MediClinic, 123 Health Avenue, Boston, MA",
                                style: TextStyle(fontSize: 14.sp),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 24.w),
                      // Professional Information
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Professional Information",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            ListTile(
                              dense: true,
                              leading: Icon(
                                Icons.medical_services,
                                color: Colors.teal,
                                size: 22.sp,
                              ),
                              title: Text(
                                "Specialty: Cardiology",
                                style: TextStyle(fontSize: 14.sp),
                              ),
                            ),
                            ListTile(
                              dense: true,
                              leading: Icon(
                                Icons.timeline,
                                color: Colors.teal,
                                size: 22.sp,
                              ),
                              title: Text(
                                "Experience: 15+ years",
                                style: TextStyle(fontSize: 14.sp),
                              ),
                            ),
                            ListTile(
                              dense: true,
                              leading: Icon(
                                Icons.school,
                                color: Colors.teal,
                                size: 22.sp,
                              ),
                              title: Text(
                                "Education: Harvard Medical School",
                                style: TextStyle(fontSize: 14.sp),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 36.h),
            Container(
              width: 600.w,
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Availability Schedule",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        ),
                      ),
                      Spacer(),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.schedule, size: 16.sp),
                        label: Text(
                          'Edit Schedule',
                          style: TextStyle(fontSize: 13.sp),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 8.h,
                          ),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildDaySchedule(
                        "Mon",
                        "9AM-5PM",
                        Colors.green.withOpacity(0.3),
                        Colors.teal[800],
                      ),
                      _buildDaySchedule(
                        "Tue",
                        "9AM-5PM",
                        Colors.green.withOpacity(0.3),
                        Colors.teal[800],
                      ),
                      _buildDaySchedule(
                        "Wed",
                        "9AM-5PM",
                        Colors.green.withOpacity(0.3),
                        Colors.teal[800],
                      ),
                      _buildDaySchedule(
                        "Thu",
                        "9AM-5PM",
                        Colors.green.withOpacity(0.3),
                        Colors.teal[800],
                      ),
                      _buildDaySchedule(
                        "Fri",
                        "9AM-5PM",
                        Colors.yellow.withOpacity(0.3),
                        Colors.orange[900],
                      ),
                      _buildDaySchedule(
                        "Sat",
                        "Unavailable",
                        Colors.red.withOpacity(0.2),
                        Colors.red[600],
                      ),
                      _buildDaySchedule(
                        "Sun",
                        "Unavailable",
                        Colors.red.withOpacity(0.2),
                        Colors.red[600],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDaySchedule(
    String day,
    String time,
    Color? bgColor,
    Color? textColor,
  ) {
    return Container(
      width: 75.w,
      height: 75.h,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15.sp,
              color: textColor,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            time,
            style: TextStyle(fontSize: 13.sp, color: textColor),
          ),
        ],
      ),
    );
  }
}
