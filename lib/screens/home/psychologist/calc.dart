// import 'package:flutter/material.dart';

// class AccountingPage extends StatefulWidget {
//   @override
//   _AccountingPageState createState() => _AccountingPageState();
// }

// class _AccountingPageState extends State<AccountingPage> {
//   // داده‌هایی که قبلاً در پلتفرم ثبت شده‌اند
//   double sessionHours = 20; // ساعت‌های جلسه
//   double baseCostPerHour = 100000; // هزینه پایه هر ساعت
//   double paidAmount = 1500000; // مبلغ پرداختی توسط مراجعه‌کننده

//   double totalCost = 0.0;
//   double outstandingAmount = 0.0;

//   @override
//   void initState() {
//     super.initState();
//     // محاسبات هنگام بارگذاری صفحه
//     _calculate();
//   }

//   void _calculate() {
//     setState(() {
//       totalCost = sessionHours * baseCostPerHour;
//       outstandingAmount = totalCost - paidAmount;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('حسابداری روانشناس'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: <Widget>[
//             // نمایش اطلاعات ثبت شده در پلتفرم
//             Text(
//               'ساعت‌های برگزاری جلسه: ${sessionHours.toString()} ساعت',
//               style: TextStyle(fontSize: 18),
//             ),
//             Text(
//               'هزینه پایه هر ساعت: ${baseCostPerHour.toString()} ریال',
//               style: TextStyle(fontSize: 18),
//             ),
//             Text(
//               'مبلغ پرداختی: ${paidAmount.toString()} ریال',
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 20),
//             // دکمه برای محاسبه مجدد هزینه‌ها
//             ElevatedButton(
//               onPressed: _calculate,
//               child: Text('محاسبه دوباره'),
//             ),
//             SizedBox(height: 20),
//             // نمایش نتایج محاسبات
//             Text(
//               'هزینه کل: ${totalCost.toString()} ریال',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             Text(
//               'بستانکاری: ${outstandingAmount.toString()} ریال',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AccountingPage extends StatefulWidget {
  @override
  _AccountingPageState createState() => _AccountingPageState();
}

class _AccountingPageState extends State<AccountingPage> {
  List<ConsultationSession> sessions = [
    ConsultationSession(
        date: DateTime(2025, 5, 1, 14, 30),
        duration: Duration(hours: 1, minutes: 30),
        price: 150000,
        paidAmount: 150000),
    ConsultationSession(
        date: DateTime(2025, 5, 3, 10, 0),
        duration: Duration(hours: 2),
        price: 200000,
        paidAmount: 100000),
    ConsultationSession(
        date: DateTime(2025, 5, 5, 16, 15),
        duration: Duration(hours: 1, minutes: 0),
        price: 120000,
        paidAmount: 120000),
    ConsultationSession(
        date: DateTime(2025, 5, 7, 9, 45),
        duration: Duration(hours: 1, minutes: 45),
        price: 180000,
        paidAmount: 180000),
    ConsultationSession(
        date: DateTime(2025, 5, 9, 11, 0),
        duration: Duration(hours: 2, minutes: 30),
        price: 250000,
        paidAmount: 200000),
    ConsultationSession(
        date: DateTime(2025, 5, 12, 13, 30),
        duration: Duration(hours: 1, minutes: 15),
        price: 140000,
        paidAmount: 140000),
    ConsultationSession(
        date: DateTime(2025, 5, 15, 15, 0),
        duration: Duration(hours: 1, minutes: 30),
        price: 160000,
        paidAmount: 150000),
  ];

  double get totalPrice =>
      sessions.fold(0, (sum, session) => sum + session.price);

  double get totalPaid =>
      sessions.fold(0, (sum, session) => sum + session.paidAmount);

  double get totalOutstanding => totalPrice - totalPaid;

  final dateFormat = DateFormat('yyyy/MM/dd');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('حسابداری روانشناس'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // اطلاعات کلی
            Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _infoColumn('تعداد جلسات', sessions.length.toString()),
                    _infoColumn('مجموع هزینه', '${totalPrice} ریال'),
                    _infoColumn('مجموع دریافتی', '${totalPaid} ریال'),
                    _infoColumn('مجموع طلبکاری', '${totalOutstanding} ریال',
                        isOutstanding: true),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),

            // نمودار قیمت جلسات بر اساس تاریخ
            SizedBox(
              height: 250,
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: LineChart(
                    _buildLineChartData(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),

            // لیست جلسات
            Expanded(
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: ListView.separated(
                    itemCount: sessions.length,
                    separatorBuilder: (_, __) => Divider(),
                    itemBuilder: (context, index) {
                      final s = sessions[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blueAccent,
                          child: Text('${index + 1}',
                              style: TextStyle(color: Colors.white)),
                        ),
                        title: Text(
                          '${dateFormat.format(s.date)} ساعت ${s.date.hour.toString().padLeft(2, '0')}:${s.date.minute.toString().padLeft(2, '0')}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                            'مدت جلسه: ${s.duration.inHours} ساعت و ${s.duration.inMinutes % 60} دقیقه\nقیمت: ${s.price} ریال\nپرداختی: ${s.paidAmount} ریال'),
                        isThreeLine: true,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoColumn(String title, String value, {bool isOutstanding = false}) {
    return Column(
      children: [
        Text(title,
            style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                fontWeight: FontWeight.w600)),
        SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isOutstanding ? Colors.red : Colors.black,
          ),
        ),
      ],
    );
  }

  LineChartData _buildLineChartData() {
    List<FlSpot> spots = [];
    List<String> dates = [];

    // مرتب سازی بر اساس تاریخ
    sessions.sort((a, b) => a.date.compareTo(b.date));

    for (int i = 0; i < sessions.length; i++) {
      spots.add(FlSpot(i.toDouble(), sessions[i].price.toDouble()));
      dates.add(dateFormat.format(sessions[i].date));
    }

    return LineChartData(
      gridData: FlGridData(show: true),
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: (value, meta) {
              int index = value.toInt();
              if (index < 0 || index >= dates.length) return Container();
              return SideTitleWidget(
                meta: meta,
                  child: Text(
                  dates[index].substring(5), // فقط ماه/روز
                  style: TextStyle(fontSize: 10),
                ),
              );
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            interval: totalPrice / 5,
          ),
        ),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.grey.shade400, width: 1)),
      minX: 0,
      maxX: (sessions.length - 1).toDouble(),
      minY: 0,
      maxY:
          (sessions.map((s) => s.price).reduce((a, b) => a > b ? a : b)) * 1.2,
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          color: Colors.blue,
          barWidth: 3,
          dotData: FlDotData(show: true),
          belowBarData:
              BarAreaData(show: true, color: Colors.blue.withOpacity(0.2)),
        ),
      ],
    );
  }
}

class ConsultationSession {
  DateTime date;
  Duration duration;
  double price;
  double paidAmount;

  ConsultationSession({
    required this.date,
    required this.duration,
    required this.price,
    this.paidAmount = 0,
  });
}
