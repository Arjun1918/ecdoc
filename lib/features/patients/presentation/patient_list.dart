import 'package:ecdoc/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/widgets/custom_appbar.dart';

class PatientListScreen extends StatelessWidget {
  const PatientListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppTheme.appbackground,
        body: Column(
          children: [
            CustomAppBar(),
            Expanded(
              child: TabBarView(
                children: [_buildPatientGrid(), _buildPatientGrid()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientGrid() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            _buildSearchAndFilter(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: GridView.builder(
                  itemCount: 16,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 12.h,
                    crossAxisSpacing: 12.w,
                    childAspectRatio: 2.0,
                  ),
                  itemBuilder: (context, index) {
                    return _buildPatientCard(index);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.r),
          topRight: Radius.circular(12.r),
        ),
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              border: Border.all(color: Colors.grey.shade300, width: 1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "All Sources",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 20.sp,
                  color: Colors.black54,
                ),
              ],
            ),
          ),

          SizedBox(width: 16.w),

          // Search Bar
          Expanded(
            child: Container(
              height: 42.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                border: Border.all(color: Colors.grey.shade300, width: 1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                // 👈 ensures everything centers inside container
                child: TextField(
                  textAlignVertical: TextAlignVertical.center, // text in middle
                  style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                  decoration: InputDecoration(
                    isCollapsed: true, // 👈 removes default padding
                    hintText: "Search patients...",
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey.shade500,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey.shade500,
                      size: 20.sp,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                    ), // only side padding
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPatientCard(int index) {
    bool isFemale = index % 2 == 0;

    Color backgroundColor = index % 2 == 0
        ? const Color(0xFFE3F2FD)
        : const Color(0xFFFCE4EC);

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.grey.shade200, width: 0.5),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18.r,
                backgroundColor: isFemale
                    ? Colors.pink.shade100
                    : Colors.blue.shade100,
                child: Icon(
                  Icons.person,
                  color: isFemale ? Colors.pink.shade700 : Colors.blue.shade700,
                  size: 18.sp,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  "Sarah Johnson",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                isFemale ? "Female, 23y" : "Male, 30y",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          SizedBox(height: 8.h),

          // Bottom Row: Patient Details and Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Patient Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "MR67748",
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "9367543203",
                      style: TextStyle(fontSize: 18.sp, color: Colors.black54),
                    ),
                  ],
                ),
              ),

              // Action Buttons
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildActionButton(Icons.videocam, Colors.green),
                  SizedBox(width: 6.w),
                  _buildActionButton(Icons.call, Colors.blue),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Icon(icon, color: color, size: 20.sp),
    );
  }
}
