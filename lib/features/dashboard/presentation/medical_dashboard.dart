import 'package:ecdoc/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/app_routes.dart';
import '../../../core/widgets/custom_appbar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String selectedFilter = 'All Appointment';
  String selectedPatients = 'All';

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(1280, 800),
      minTextAdapt: true,
      splitScreenMode: true,
    );
    return Scaffold(
      backgroundColor: AppTheme.appbackground,
      appBar: CustomAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            _buildFilterSection(),
            Expanded(
              child: Row(
                children: [
                  Expanded(flex: 3, child: buildLeftPanel()),
                  Expanded(flex: 2, child: _buildRightPanel()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      color: Colors.white,
      child: Row(
        children: [
          _buildDateButton('Today', true),
          SizedBox(width: 8.w),
          _buildDateButton('Tomorrow', false),
          SizedBox(width: 8.w),
          _buildDateButton('📅 Custom Range', false),
          SizedBox(width: 24.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: DropdownButton<String>(
              value: selectedFilter,
              underline: const SizedBox(),
              items: ['All Appointment', 'Confirmed', 'Pending', 'Cancelled']
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e, style: TextStyle(fontSize: 20.sp)),
                    ),
                  )
                  .toList(),
              onChanged: (value) => setState(() => selectedFilter = value!),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildDateButton(String text, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF00BCD4) : Colors.transparent,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey.shade700,
          fontWeight: FontWeight.w500,
          fontSize: 18.sp,
        ),
      ),
    );
  }

  Widget buildLeftPanel() {
    return Container(
      margin: EdgeInsets.all(16.w),
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 44.h,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search patients...',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 20.sp,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey.shade600,
                          size: 22.sp,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 12.w,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(
                            color: Colors.blue.shade400,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _buildPatientCard(
                    'Sarah Johnson',
                    '9867675428',
                    'MR67819',
                    '09:30 AM',
                    'A4',
                    true,
                    'Follow-up • Website',
                    'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg',
                  ),
                  SizedBox(height: 16.h),
                  _buildPatientCard(
                    'Michael Brown',
                    '9867675428',
                    'MR67819',
                    '11:30 AM',
                    'A5',
                    false,
                    'Follow-up • IVRS',
                    'https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPatientCard(
    String name,
    String phone,
    String mrNumber,
    String time,
    String room,
    bool isOnline,
    String type,
    String imageUrl,
  ) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context, AppRoutes.consultation
        );
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            CircleAvatar(radius: 25.r, backgroundImage: NetworkImage(imageUrl)),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                    ),
                  ),
                  Text(
                    phone,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 20.sp,
                    ),
                  ),
                  Text(
                    mrNumber,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 20.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: isOnline
                              ? const Color(0xFF2196F3)
                              : const Color(0xFF9C27B0),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          isOnline ? 'Online' : 'Offline',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        type,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 20.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  time,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  width: 30.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Center(
                    child: Text(
                      room,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRightPanel() {
    return Container(
      margin: EdgeInsets.all(16.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // News & Search Container
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 44.h,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search  articles',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 20.sp,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey.shade600,
                          size: 22.sp,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 12.w,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(
                            color: Colors.blue.shade400,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    height: 200.h,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildNewsCard(
                          'TOP 10 MEDICAL JOURNALS IN INDIA',
                          'BBC News • 20 hours ago',
                          'Constipation is a frequent adverse event associated with opioid for pain relief, less is known about...',
                          'https://images.pexels.com/photos/4173251/pexels-photo-4173251.jpeg',
                        ),
                        _buildNewsCard(
                          'Journal of the American Medical Association',
                          'BBC News • 20 hours ago',
                          'Constipation is a frequent adverse event associated with opioid for pain relief, less is known about...',
                          'https://images.pexels.com/photos/3938023/pexels-photo-3938023.jpeg',
                        ),
                        _buildNewsCard(
                          'Constipation is a frequent adverse event associated',
                          'BBC News • 20 hours ago',
                          'Constipation is a frequent adverse event associated with opioid for pain relief, less is known about...',
                          'https://images.pexels.com/photos/4167541/pexels-photo-4167541.jpeg',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE3F2FD),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      'You may have 10 additional Patients Today',
                      style: TextStyle(
                        color: const Color(0xFF1976D2),
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E8),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      'You have a Meeting On Friday 10th June, 2022 @ 2:30PM',
                      style: TextStyle(
                        color: const Color(0xFF388E3C),
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8EAF6),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      'You have an upcoming holiday on 13th June, 2022',
                      style: TextStyle(
                        color: const Color(0xFF3F51B5),
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E8),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      'You have an upcoming holiday on 13th June, 2022',
                      style: TextStyle(
                        color: const Color(0xFF388E3C),
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            Container(
              height: 300.h,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _ChartLegend(
                        color: const Color(0xFF9C27B0),
                        label: 'Consultation',
                      ),
                      _ChartLegend(
                        color: const Color(0xFFE91E63),
                        label: 'Online',
                      ),
                      _ChartLegend(
                        color: const Color(0xFF00BCD4),
                        label: 'Vaccination',
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Expanded(
                    child: LineChart(
                      LineChartData(
                        gridData: const FlGridData(show: true),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                const days = [
                                  'Mon',
                                  'Tue',
                                  'Wed',
                                  'Thu',
                                  'Fri',
                                  'Sat',
                                ];
                                if (value.toInt() < days.length) {
                                  return Text(
                                    days[value.toInt()],
                                    style: TextStyle(fontSize: 12.sp),
                                  );
                                }
                                return const Text('');
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  value.toInt().toString(),
                                  style: TextStyle(fontSize: 12.sp),
                                );
                              },
                            ),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            spots: const [
                              FlSpot(0, 30),
                              FlSpot(1, 60),
                              FlSpot(2, 40),
                              FlSpot(3, 80),
                              FlSpot(4, 50),
                              FlSpot(5, 70),
                            ],
                            isCurved: true,
                            color: const Color(0xFF9C27B0),
                            barWidth: 3.w,
                            dotData: FlDotData(
                              show: true,
                              getDotPainter: (spot, percent, barData, index) {
                                return FlDotCirclePainter(
                                  radius: 4.r,
                                  color: const Color(0xFF9C27B0),
                                  strokeWidth: 2.w,
                                  strokeColor: Colors.white,
                                );
                              },
                            ),
                          ),
                          LineChartBarData(
                            spots: const [
                              FlSpot(0, 20),
                              FlSpot(1, 50),
                              FlSpot(2, 30),
                              FlSpot(3, 60),
                              FlSpot(4, 40),
                              FlSpot(5, 50),
                            ],
                            isCurved: true,
                            color: const Color(0xFFE91E63),
                            barWidth: 3.w,
                            dotData: FlDotData(
                              show: true,
                              getDotPainter: (spot, percent, barData, index) {
                                return FlDotCirclePainter(
                                  radius: 4.r,
                                  color: const Color(0xFFE91E63),
                                  strokeWidth: 2.w,
                                  strokeColor: Colors.white,
                                );
                              },
                            ),
                          ),
                          LineChartBarData(
                            spots: const [
                              FlSpot(0, 40),
                              FlSpot(1, 70),
                              FlSpot(2, 90),
                              FlSpot(3, 50),
                              FlSpot(4, 80),
                              FlSpot(5, 30),
                            ],
                            isCurved: true,
                            color: const Color(0xFF00BCD4),
                            barWidth: 3.w,
                            dotData: FlDotData(
                              show: true,
                              getDotPainter: (spot, percent, barData, index) {
                                return FlDotCirclePainter(
                                  radius: 4.r,
                                  color: const Color(0xFF00BCD4),
                                  strokeWidth: 2.w,
                                  strokeColor: Colors.white,
                                );
                              },
                            ),
                          ),
                        ],
                        minY: 0,
                        maxY: 100,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    '2025- HELYXON - v.003',
                    style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsCard(
    String title,
    String source,
    String description,
    String imageUrl,
  ) {
    return Container(
      width: 280.w,
      margin: EdgeInsets.only(right: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1.r,
            blurRadius: 4.r,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(8.r)),
            child: Image.network(
              imageUrl,
              height: 100.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  source,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 12.sp,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartLegend extends StatelessWidget {
  final Color color;
  final String label;

  const _ChartLegend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12.w,
          height: 12.h,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 4.w),
        Text(label, style: TextStyle(fontSize: 12.sp)),
      ],
    );
  }
}
