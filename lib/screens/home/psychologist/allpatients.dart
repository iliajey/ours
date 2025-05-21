import 'package:flutter/material.dart';

class Patient {
  final String name;
  final String medicalFile;
  final String doctorInfo;
  final String treatmentPlan;
  final String progressReports;
  final String date;
  final String referringDoctor; // دکتر ارجاع‌دهنده

  Patient({
    required this.name,
    required this.medicalFile,
    required this.doctorInfo,
    required this.treatmentPlan,
    required this.progressReports,
    required this.date,
    required this.referringDoctor, // مقداردهی دکتر ارجاع‌دهنده
  });
}

class PatientsList extends StatelessWidget {
  final List<Patient> patients = [
    Patient(
      name: 'مراجع 1',
      medicalFile:
          'مشخصات بیماری: دیابت نوع 2\nجزئیات رژیم دارو درمانی: داروی متفورمین 500 میلی‌گرم روزانه',
      doctorInfo: 'پزشک متخصص: دکتر احمدی، متخصص داخلی، بیمارستان امام خمینی',
      treatmentPlan: 'برنامه درمان: کاهش قند خون با رژیم دارویی و تغذیه‌ای',
      progressReports:
          'گزارش پیشرفت درمان: کاهش قند خون در حد مطلوب، بهبود وضعیت عمومی بیمار',
      date: '1404/01/15', // تاریخ
      referringDoctor: 'دکتر فلان 2', // نام دکتر ارجاع‌دهنده
    ),
    Patient(
      name: 'مراجع 2',
      medicalFile:
          'مشخصات بیماری: فشار خون بالا\nجزئیات رژیم دارو درمانی: داروی آتنولول 50 میلی‌گرم روزانه',
      doctorInfo: 'پزشک متخصص: دکتر جلیلی، متخصص قلب، بیمارستان مدنی',
      treatmentPlan: 'برنامه درمان: کاهش فشار خون با دارو و رژیم غذایی کم نمک',
      progressReports:
          'گزارش پیشرفت درمان: کنترل فشار خون در حد نرمال، نیاز به ادامه درمان',
      date: '1404/01/16', // تاریخ
      referringDoctor: 'دکتر فلان3', // نام دکتر ارجاع‌دهنده
    ),
    // اضافه کردن مراجعین بیشتر
  ];

  PatientsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('لیست مراجعین'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: patients.map((patient) {
          return Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            margin: EdgeInsets.symmetric(vertical: 10),
            child: ExpansionTile(
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, // فاصله بین نام، تاریخ و دکتر ارجاع‌دهنده
                  children: [
                    Text(
                      patient.name,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          patient.date, // تاریخ
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        Text(
                          'ارجاع‌دهنده: ${patient.referringDoctor}', // دکتر ارجاع‌دهنده
                          style:
                              TextStyle(fontSize: 14, color: Colors.blueGrey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              children: <Widget>[
                _buildTile('پرونده پزشکی', patient.medicalFile),
                _buildTile('اطلاعات پزشک', patient.doctorInfo),
                _buildTile('برنامه درمان', patient.treatmentPlan),
                _buildTile('گزارش پیشرفت درمان', patient.progressReports),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  // یک متد برای ساخت کارت‌های اطلاعات هر بخش
  Widget _buildTile(String title, String subtitle) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: ListTile(
        title: Text(title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: TextStyle(fontSize: 14)),
      ),
    );
  }
}
