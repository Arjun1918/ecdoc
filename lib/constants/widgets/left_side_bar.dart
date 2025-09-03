import 'package:ecdoc/screens/dashboard/patient_card.dart';
import 'package:ecdoc/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LeftSidebar extends StatelessWidget {
  final String selectedFilter;
  final String selectedDay;
  final Function(String) onFilterChanged;
  final Function(String) onDayChanged;

  const LeftSidebar({
    super.key,
    required this.selectedFilter,
    required this.selectedDay,
    required this.onFilterChanged,
    required this.onDayChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(20.w),
            child: Row(
              children: [
                _buildFilterChip(
                  'Today',
                  selectedDay == 'Today',
                  () => onDayChanged('Today'),
                ),
                SizedBox(width: 10.w),
                _buildFilterChip(
                  'Tomorrow',
                  selectedDay == 'Tomorrow',
                  () => onDayChanged('Tomorrow'),
                ),
                SizedBox(width: 10.w),
                _buildFilterChip(
                  'Custom Range',
                  selectedDay == 'Custom Range',
                  () => onDayChanged('Custom Range'),
                ),
                SizedBox(width: 20.w),
                DropdownButton<String>(
                  value: selectedFilter,
                  items: ['All Appointment', 'Online', 'Offline'].map((
                    String value,
                  ) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) onFilterChanged(newValue);
                  },
                ),
                SizedBox(width: 20.w),
                Container(
                  width: 200.w,
                  height: 40.h,
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(20.w),
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            height: 45.h,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(25.r),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.grey, size: 20.sp),
                SizedBox(width: 10.w),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search patients...',
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Text(
                  'All',
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                ),
                SizedBox(width: 10.w),
                Container(
                  width: 20.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '2',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Icon(Icons.calendar_today, size: 18.sp, color: Colors.grey),
              ],
            ),
          ),

          SizedBox(height: 20.h),

          // Patient List
          Expanded(
            child: ListView(
              children: const [
                PatientCard(
                  name: 'Sarah Johnson',
                  id: '998764248',
                  mrn: 'MRG7819',
                  time: '09:30 AM',
                  status: 'Online',
                  statusColor: Colors.green,
                  subtitle: 'Follow up + Website',
                ),
                PatientCard(
                  name: 'Michael Brown',
                  id: '998764248',
                  mrn: 'MRG7819',
                  time: '11:30 AM',
                  status: 'Offline',
                  statusColor: Colors.red,
                  subtitle: 'Follow up + IVIS',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? AppTheme.primaryColor : Colors.grey[300]!,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[600],
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
