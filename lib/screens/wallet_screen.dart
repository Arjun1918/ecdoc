import 'package:ecdoc/constants/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentDashboardScreen extends StatelessWidget {
  const PaymentDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Color(0xFFF5FAFB),
      body: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Check',
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5.h),
            Text(
              'Monitor and manage daily payment transactions',
              style: TextStyle(fontSize: 16.sp, color: Colors.black54),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                _summaryCard(
                  icon: Icons.person,
                  value: "25",
                  label: "Today's Patients",
                  delta: "+12%",
                  deltaColor: Colors.green,
                  subtitle: "from yesterday",
                  background: Colors.white,
                  iconColor: Colors.green,
                ),
                SizedBox(width: 20.w),
                _summaryCard(
                  icon: Icons.account_balance_wallet,
                  value: "₹ 50,000",
                  label: "Total Collected",
                  delta: "+12%",
                  deltaColor: Colors.green,
                  subtitle: "from yesterday",
                  background: Colors.white,
                  iconColor: Colors.blueAccent,
                ),
                SizedBox(width: 20.w),
                _summaryCard(
                  icon: Icons.calendar_today,
                  value: "12",
                  label: "Pending Payments",
                  delta: "-12%",
                  deltaColor: Colors.red,
                  subtitle: "to be processed",
                  background: Colors.white,
                  iconColor: Colors.green,
                  useDownArrow: true,
                ),
              ],
            ),
            SizedBox(height: 30.h),

            // Payment History Table
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Payment History',
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Monitor and manage daily payment transactions',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 18.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '01 Jul - 03 Jul',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.blueAccent,
                        size: 22.sp,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // Data Table with Pagination
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18.r),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  children: [
                    _tableHeader(),
                    Expanded(child: _tableRows()),
                    _tablePagination(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryCard({
    required IconData icon,
    required String value,
    required String label,
    required String delta,
    required Color deltaColor,
    required String subtitle,
    required Color background,
    required Color iconColor,
    bool useDownArrow = false,
  }) {
    return Container(
      width: 320.w,
      height: 110.h,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, size: 32.sp, color: iconColor),
          ),
          SizedBox(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                label,
                style: TextStyle(fontSize: 16.sp, color: Colors.black54),
              ),
              SizedBox(height: 5.h),
              Row(
                children: [
                  useDownArrow
                      ? Icon(
                          Icons.arrow_downward,
                          size: 18.sp,
                          color: deltaColor,
                        )
                      : Icon(
                          Icons.arrow_upward,
                          size: 18.sp,
                          color: deltaColor,
                        ),
                  SizedBox(width: 4.w),
                  Text(
                    delta,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: deltaColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14.sp, color: Colors.black38),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tableHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Color(0xFFF5FAFB),
        borderRadius: BorderRadius.vertical(top: Radius.circular(18.r)),
      ),
      child: Row(
        children: [
          _headerCell('Patient', flex: 2),
          _headerCell('Transaction ID', flex: 2),
          _headerCell('Date & Time', flex: 2),
          _headerCell('Payment Method', flex: 1),
          _headerCell('Amount', flex: 1),
          _headerCell('Status', flex: 1),
          _headerCell('Actions', flex: 1),
        ],
      ),
    );
  }

  Widget _headerCell(String text, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16.sp,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _tableRows() {
    final rows = List.generate(
      5,
      (index) => {
        'patient': 'Arjun',
        'patientId': 'PAT-2023-001',
        'txn': 'TXN-78945612',
        'date': 'Jul 21, 2023 · 10:45 AM',
        'method': 'Card',
        'amount': '75.00',
        'status': 'Completed',
      },
    );

    return ListView.separated(
      itemCount: rows.length,
      separatorBuilder: (_, __) =>
          Divider(height: 1.h, color: Colors.grey.shade200),
      itemBuilder: (context, idx) {
        final data = rows[idx];
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['patient']!,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'ID: ' + data['patientId']!,
                      style: TextStyle(fontSize: 13.sp, color: Colors.black45),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(data['txn']!, style: TextStyle(fontSize: 15.sp)),
              ),
              Expanded(
                flex: 2,
                child: Text(data['date']!, style: TextStyle(fontSize: 15.sp)),
              ),
              Expanded(
                flex: 1,
                child: Text(data['method']!, style: TextStyle(fontSize: 15.sp)),
              ),
              Expanded(
                flex: 1,
                child: Text(data['amount']!, style: TextStyle(fontSize: 15.sp)),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  data['status']!,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Icon(
                  Icons.remove_red_eye,
                  color: Color(0xFF4CC6DB),
                  size: 22.sp,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _tablePagination() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
      child: Row(
        children: [
          // Prev button
          _paginationButton("Prev"),
          SizedBox(width: 8.w),
          _paginationItem("1"),
          _paginationItem("2"),
          _paginationItem("3", active: true),
          _paginationItem("4"),
          _paginationItem("5"),
          _paginationItem("6"),
          Text(
            "...",
            style: TextStyle(fontSize: 16.sp, color: Colors.grey.shade700),
          ),
          _paginationItem("20"),
          SizedBox(width: 8.w),
          _paginationButton("Next"),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Color(0xFFF5F7FA),
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: Colors.grey.shade300),
            ),
          ),
        ],
      ),
    );
  }

  Widget _paginationButton(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 15.sp, color: Colors.black54),
      ),
    );
  }

  Widget _paginationItem(String label, {bool active = false}) {
    return Container(
      margin: EdgeInsets.only(right: 4.w, left: 2.w),
      padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: active ? Color(0xFF4CC6DB) : Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 15.sp,
          color: active ? Colors.white : Colors.black87,
          fontWeight: active ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
