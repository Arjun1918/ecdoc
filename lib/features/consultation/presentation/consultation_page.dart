import 'package:ecdoc/provider/patient_page_provider.dart';
import 'package:ecdoc/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/custom_appbar.dart';

class ConsultationPage extends StatelessWidget {
  const ConsultationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ConsultationProvider(),
      child: ScreenUtilInit(
        designSize: const Size(1280, 768),
        minTextAdapt: true,
        builder: (context, child) {
          return Scaffold(
            appBar: CustomAppBar(),
            backgroundColor: AppTheme.appbackground,
            body: Row(
              children: [
                Consumer<ConsultationProvider>(
                  builder: (context, provider, child) {
                    return Container(
                      width: 80.w,
                      color: Colors.white,
                      padding: EdgeInsets.all(8.w),
                      child: ListView.builder(
                        itemCount: provider.patients.length,
                        itemBuilder: (context, index) {
                          return _buildPatientItem(
                            provider.patients[index]['name']!,
                            provider.patients[index]['image']!,
                            provider.patients[index]['selected'] == 'true',
                            () => provider.selectPatient(index),
                          );
                        },
                      ),
                    );
                  },
                ),

                // Main Content Area
                Expanded(
                  flex: 2,
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildPatientHeader(),
                          SizedBox(height: 16.h),
                          _buildVitalMeasurements(),
                          SizedBox(height: 16.h),
                          _buildPreviousConsultations(),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 800.w,
                  color: AppTheme.appbackground,
                  child: _buildConsultationBuilder(),
                ),
              ],
            ),

            // Bottom Status Bar
            bottomNavigationBar: _buildBottomStatusBar(),
          );
        },
      ),
    );
  }

  Widget _buildPatientItem(
    String name,
    String imagePath,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.h),
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: CircleAvatar(
              radius: 25.r,
              backgroundImage: imagePath.startsWith("http")
                  ? NetworkImage(imagePath)
                  : AssetImage(imagePath) as ImageProvider,
              backgroundColor: isSelected ? Colors.blue : Colors.grey[300],
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            name,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.black : Colors.grey[600],
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildPatientHeader() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            spreadRadius: 1.r,
            blurRadius: 3.r,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 60.r,
            backgroundImage: NetworkImage(
              "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg",
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        'Sarah Johnson',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        'A4',
                        style: TextStyle(color: Colors.white, fontSize: 12.sp),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  'Sarah',
                  style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                ),
                Text(
                  'Female, 35 years',
                  style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                ),
                Text(
                  '9344453626',
                  style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Wrap(
            spacing: 8.w,
            children: [
              _buildActionButton(Icons.call, Colors.green),
              _buildActionButton(Icons.chat, Colors.blue),
              _buildActionButton(Icons.videocam, Colors.red),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, Color color) {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Icon(icon, color: Colors.white, size: 20.sp),
    );
  }

  Widget _buildVitalMeasurements() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            spreadRadius: 1.r,
            blurRadius: 3.r,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Vital Measurements',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              Icon(Icons.edit, color: Colors.blue, size: 20.sp),
            ],
          ),
          SizedBox(height: 16.h),

          // 🔥 Fixed grid layout
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 16.w,
            mainAxisSpacing: 16.h,
            childAspectRatio: 2.2, // adjust for better height/width ratio
            children: [
              _buildVitalCard('Height', '165 cm', Icons.height),
              _buildVitalCard('Weight', '62 Kg', Icons.monitor_weight),
              _buildVitalCard('Blood Pressure', '120/80', Icons.favorite),
              _buildVitalCard('Glucose', '95 mg/dL', Icons.bloodtype),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVitalCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20.sp, color: Colors.grey[600]),
              SizedBox(width: 8.w),
              Text(
                title,
                style: TextStyle(color: Colors.grey[600], fontSize: 12.sp),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviousConsultations() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            spreadRadius: 1.r,
            blurRadius: 3.r,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Previous Consultations',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                'View all',
                style: TextStyle(color: Colors.blue, fontSize: 14.sp),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildConsultationItem(
            'Respiratory Infection',
            'Jun 5, 2023',
            'Prescribed amoxicillin for 7 days, advised rest and increased fluid intake.',
          ),
          _buildConsultationItem(
            'Annual Check-up',
            'Mar 12, 2023',
            'All vitals normal. Recommended Vitamin D supplement due to slightly low levels.',
          ),
        ],
      ),
    );
  }

  Widget _buildConsultationItem(String title, String date, String description) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
              ),
              Text(
                date,
                style: TextStyle(color: Colors.grey[500], fontSize: 12.sp),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            description,
            style: TextStyle(color: Colors.grey[600], fontSize: 13.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildConsultationBuilder() {
    return Consumer<ConsultationProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            // Top Header Row
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
              ),
              child: Row(
                children: [
                  _buildHeaderButton(
                    label: "Growth Chart",
                    icon: Icons.show_chart,
                    isActive: provider.activeHeaderButton == 'Growth Chart',
                    onTap: () {
                      provider.setActiveHeaderButton('Growth Chart');
                    },
                  ),
                  SizedBox(width: 8.w),
                  _buildHeaderButton(
                    label: "Milestones",
                    icon: Icons.assignment,
                    isActive: provider.activeHeaderButton == 'Milestones',
                    onTap: () {
                      provider.setActiveHeaderButton('Milestones');
                    },
                  ),
                  SizedBox(width: 8.w),
                  _buildHeaderButton(
                    label: "Vaccination",
                    icon: Icons.vaccines,
                    isActive: provider.activeHeaderButton == 'Vaccination',
                    onTap: () {
                      provider.setActiveHeaderButton('Vaccination');
                    },
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 6.h,
                        ),
                        child: Text(
                          '00:00:00',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(
                          Icons.medical_services,
                          color: Colors.white,
                          size: 16.sp,
                        ),
                        label: Text(
                          'Start Consultation',
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 6.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Show template section only if not Vaccination
            if (provider.activeHeaderButton != 'Vaccination')
              _buildTemplateSection(),

            // Dynamic Content Area based on selected header
            Expanded(child: _buildDynamicContent()),
          ],
        );
      },
    );
  }

  Widget _buildDynamicContent() {
    return Consumer<ConsultationProvider>(
      builder: (context, provider, child) {
        switch (provider.activeHeaderButton) {
          case 'Vaccination':
            return _buildVaccinationDashboard();
          case 'Growth Chart':
            return _buildGrowthChartContent();
          case 'Milestones':
            return _buildMilestonesContent();
          default:
            return _buildDefaultConsultationBuilder();
        }
      },
    );
  }

  Widget _buildVaccinationDashboard() {
    return Container(
      margin: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Vaccination',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF4ECDC4),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.print, color: Colors.white, size: 16.sp),
                    SizedBox(width: 8.w),
                    Text(
                      'Print',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 24.h),

          // Status Legend
          Row(
            children: [
              _buildStatusLegend('Given', const Color(0xFF4CAF50)),
              SizedBox(width: 24.w),
              _buildStatusLegend('Due', const Color(0xFF2196F3)),
              SizedBox(width: 24.w),
              _buildStatusLegend('Deferred', const Color(0xFFFF9800)),
              SizedBox(width: 24.w),
              _buildStatusLegend('Not Given', Colors.grey),
              SizedBox(width: 24.w),
              _buildStatusLegend('Pending', const Color(0xFFE57373)),
              SizedBox(width: 24.w),
              _buildStatusLegend('Not Required', Colors.black87),
            ],
          ),

          SizedBox(height: 32.h),

          // Vaccine Summary
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.1),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Last Vaccine',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        'MMR (2nd)',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Given',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.check_circle,
                            color: const Color(0xFF4CAF50),
                            size: 16.sp,
                          ),
                        ],
                      ),
                      Text(
                        '14',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Adherence',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '92%',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Container(
                              height: 4.h,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(2.r),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: 0.92,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF4CAF50),
                                    borderRadius: BorderRadius.circular(2.r),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        'Sep 10, 2023',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        '24 required',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 10.h),

          Row(
            children: [
              _buildTimeHeader('At Birth', 120.w),
              _buildTimeHeader('6 Weeks', 120.w),
              _buildTimeHeader('10 Weeks', 120.w),
              _buildTimeHeader('14 Weeks', 120.w),
              _buildTimeHeader('6 Months', 120.w),
              _buildTimeHeader('9-12 Months', 120.w),
            ],
          ),

          SizedBox(height: 16.h),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildVaccinationRow(),
                  SizedBox(height: 16.h),
                  _buildVaccinationRow(),
                  SizedBox(height: 16.h),
                  _buildVaccinationRow(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusLegend(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12.w,
          height: 12.h,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8.w),
        Text(
          label,
          style: TextStyle(fontSize: 14.sp, color: Colors.black87),
        ),
      ],
    );
  }

  Widget _buildTimeHeader(String text, double width) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: Colors.grey[700],
        ),
      ),
    );
  }

  Widget _buildVaccinationRow() {
    return Row(
      children: [
        _buildVaccinationCard(
          'Hepatitis B',
          '1st dose',
          'Given\nJan 15, 2021',
          const Color(0xFF4CAF50),
          VaccineStatus.given,
        ),
        SizedBox(width: 12.w),
        _buildVaccinationCard(
          'Hepatitis B',
          '1st dose',
          'Given\nJan 15, 2021',
          const Color(0xFFFF9800),
          VaccineStatus.deferred,
        ),
        SizedBox(width: 12.w),
        _buildVaccinationCard(
          'Hepatitis B',
          '1st dose',
          'Time Remaining\n48 days',
          const Color(0xFF2196F3),
          VaccineStatus.due,
        ),
        SizedBox(width: 12.w),
        _buildVaccinationCard(
          'Hepatitis B',
          '1st dose',
          'Action\nReview Required',
          const Color(0xFFE57373),
          VaccineStatus.pending,
        ),
        SizedBox(width: 12.w),
        _buildVaccinationCard(
          'Hepatitis B',
          '1st dose',
          'Status\nMissed',
          Colors.grey,
          VaccineStatus.notGiven,
        ),
        SizedBox(width: 12.w),
        _buildVaccinationCard(
          'Hepatitis B',
          '1st dose',
          'Reason\nNot routine in reg',
          Colors.black87,
          VaccineStatus.notRequired,
        ),
      ],
    );
  }

  Widget _buildVaccinationCard(
    String vaccine,
    String dose,
    String status,
    Color color,
    VaccineStatus vaccineStatus,
  ) {
    return Expanded(
      child: Container(
        height: 120.h,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: color.withValues(alpha: 0.3), width: 1.w),
        ),
        child: Column(
          children: [
            // Header section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.r),
                  topRight: Radius.circular(8.r),
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.medical_services_outlined,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    vaccine,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    dose,
                    style: TextStyle(color: Colors.white, fontSize: 10.sp),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            // Status section
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(8.w),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGrowthChartContent() {
    return _buildDefaultConsultationBuilder();
  }

  Widget _buildMilestonesContent() {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Text(
          "Milestones Content",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildDefaultConsultationBuilder() {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading
          Text(
            "Consultation Builder",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12.h),

          // Scrollable Tile List
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildConsultationTile(
                    title: 'Chief Complaints',
                    count: '5',
                    child: _buildChiefComplaintsChips(),
                  ),
                  _buildConsultationTile(
                    title: 'Signs',
                    count: '2',
                    child: _buildPlaceholderContent('Signs Content Here'),
                  ),
                  _buildConsultationTile(
                    title: 'Diagnosis',
                    count: '1',
                    child: _buildPlaceholderContent('Diagnosis Content Here'),
                  ),
                  _buildConsultationTile(
                    title: 'Investigation',
                    count: '',
                    child: _buildPlaceholderContent(
                      'Investigation Content Here',
                    ),
                  ),
                  _buildConsultationTile(
                    title: 'Drug Prescription',
                    count: '',
                    child: _buildPlaceholderContent(
                      'Drug Prescription Content Here',
                    ),
                  ),
                  _buildConsultationTile(
                    title: 'Advices',
                    count: '',
                    child: _buildPlaceholderContent('Advices Content Here'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderButton({
    required String label,
    required IconData icon,
    bool isActive = false,
    VoidCallback? onTap, // <-- added onTap
  }) {
    return GestureDetector(
      onTap: onTap, // trigger the navigation or any action
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isActive ? AppTheme.primaryColor : Colors.grey[100],
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 16.sp,
              color: isActive ? Colors.white : Colors.black87,
            ),
            SizedBox(width: 6.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: isActive ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTemplateSection() {
    return Consumer<ConsultationProvider>(
      builder: (context, provider, child) {
        return Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Row(
            children: [
              // Left: Template Info
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(
                        Icons.view_agenda,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Choose Template",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.sp,
                            ),
                            children: [
                              TextSpan(
                                text: "Selected Template: ",
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              TextSpan(
                                text: provider.selectedTemplate,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(left: 0.w, right: 2.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCustomRadio("With Header", provider.withHeader, () {
                        provider.setWithHeader(true);
                      }),
                      SizedBox(height: 6.h),
                      _buildCustomRadio(
                        "Without Header",
                        !provider.withHeader,
                        () {
                          provider.setWithHeader(false);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildActionButton2("Save Draft", Icons.save),
                    SizedBox(width: 5.w),
                    _buildActionButton2("Print", Icons.print),
                    SizedBox(width: 5.w),
                    _buildActionButton2("Preview", Icons.remove_red_eye),
                    SizedBox(width: 5.w),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCustomRadio(String title, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 20.w,
            height: 20.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppTheme.primaryColor, width: 2.w),
              color: selected ? AppTheme.primaryColor : Colors.transparent,
            ),
            child: selected
                ? Icon(Icons.circle, size: 12.sp, color: Colors.white)
                : null,
          ),
          SizedBox(width: 6.w),
          Text(
            title,
            style: TextStyle(fontSize: 14.sp, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _buildConsultationTile({
    required String title,
    required String count,
    required Widget child,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 4.h), 
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 0.h,
          ), // reduced height
          childrenPadding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 6.h,
          ),
          dense: true, // makes tile compact
          title: Text(
            title,
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (count.isNotEmpty)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    count,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ),
              SizedBox(width: 4.w),
              Icon(Icons.chevron_right, size: 18.sp, color: Colors.grey[600]),
            ],
          ),
          children: [child],
        ),
      ),
    );
  }

  Widget _buildPlaceholderContent(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
    );
  }

  Widget _buildActionButton2(
    String text,
    IconData icon, {
    bool isBlue = false,
  }) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 20.sp),
      label: Text(text, style: TextStyle(fontSize: 16.sp)),
      style: ElevatedButton.styleFrom(
        backgroundColor: isBlue ? AppTheme.primaryColor : Colors.grey[100],
        foregroundColor: isBlue ? Colors.white : Colors.black,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        minimumSize: Size(0, 32.h),
      ),
    );
  }

  Widget _buildChiefComplaintsChips() {
    List<String> complaints = [
      'Fever',
      'Cough',
      'Headache',
      'Sore Throat',
      'Abdominal Pain',
    ];
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Wrap(
        spacing: 8.w,
        runSpacing: 8.h,
        children: complaints
            .map(
              (complaint) => Chip(
                label: Text(complaint, style: TextStyle(fontSize: 14.sp)),
                backgroundColor: Colors.grey[200],
                side: BorderSide(color: Colors.grey[200]!),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildBottomStatusBar() {
    return Container(
      height: 80.h,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: _buildStatusItem(
              'OPD',
              'Booking\nWaiting',
              '0\n3',
              Colors.blue,
              Icons.medical_services,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: _buildStatusItem(
              'Tele',
              'Booking\nWaiting',
              '0\n3',
              Colors.purple,
              Icons.videocam,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: _buildStatusItem(
              'Token',
              'Current Token\nNext Token',
              '0\n3',
              Colors.indigo,
              Icons.confirmation_num,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: _buildStatusItem(
              'Seen',
              'Total Seen',
              '3',
              Colors.green,
              Icons.remove_red_eye,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: _buildStatusItem(
              'Waiting',
              'Total Waiting',
              '3',
              Colors.orange,
              Icons.access_time,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusItem(
    String title,
    String subtitle,
    String count,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          // Icon with soft background
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, color: color, size: 20.sp),
          ),
          SizedBox(width: 12.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                ),
              ],
            ),
          ),

          // Count
          Text(
            count,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),
        ],
      ),
    );
  }
}

enum VaccineStatus { given, due, deferred, notGiven, pending, notRequired }
