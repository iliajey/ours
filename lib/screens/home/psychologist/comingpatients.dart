// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';

// class Patient {
//   final String name;
//   final String medicalFile;
//   final String doctorInfo;
//   final String treatmentPlan;
//   final String progressReports;
//   final String date;
//   final String referringDoctor;

//   Patient({
//     required this.name,
//     required this.medicalFile,
//     required this.doctorInfo,
//     required this.treatmentPlan,
//     required this.progressReports,
//     required this.date,
//     required this.referringDoctor,
//   });
// }

// class PatientsListsoon extends StatefulWidget {
//   @override
//   _PatientsListState createState() => _PatientsListState();
// }

// class _PatientsListState extends State<PatientsListsoon> {
//   // تقویم
//   late final ValueNotifier<List<DateTime>> _selectedDays;
//   late final CalendarFormat _calendarFormat;
//   late final DateTime _focusedDay;
//   late final DateTime _selectedDay;

//   @override
//   void initState() {
//     super.initState();
//     _focusedDay = DateTime.now();
//     _selectedDay = _focusedDay;
//     _calendarFormat = CalendarFormat.month;

//     // تاریخ‌های خاص برای بولد شدن
//     _selectedDays = ValueNotifier([
//       DateTime(1404, 1, 15), // تاریخ نمونه برای بولد شدن
//       DateTime(1404, 1, 16), // تاریخ نمونه برای بولد شدن
//     ]);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final List<Patient> patients = [
//       Patient(
//         name: 'مراجع 1',
//         medicalFile:
//             'مشخصات بیماری: دیابت نوع 2\nجزئیات رژیم دارو درمانی: داروی متفورمین 500 میلی‌گرم روزانه',
//         doctorInfo: 'پزشک متخصص: دکتر احمدی، متخصص داخلی، بیمارستان امام خمینی',
//         treatmentPlan: 'برنامه درمان: کاهش قند خون با رژیم دارویی و تغذیه‌ای',
//         progressReports:
//             'گزارش پیشرفت درمان: کاهش قند خون در حد مطلوب، بهبود وضعیت عمومی بیمار',
//         date: '1404/01/15',
//         referringDoctor: 'دکتر احمدی',
//       ),
//       Patient(
//         name: 'مراجع 2',
//         medicalFile:
//             'مشخصات بیماری: فشار خون بالا\nجزئیات رژیم دارو درمانی: داروی آتنولول 50 میلی‌گرم روزانه',
//         doctorInfo: 'پزشک متخصص: دکتر جلیلی، متخصص قلب، بیمارستان مدنی',
//         treatmentPlan:
//             'برنامه درمان: کاهش فشار خون با دارو و رژیم غذایی کم نمک',
//         progressReports:
//             'گزارش پیشرفت درمان: کنترل فشار خون در حد نرمال، نیاز به ادامه درمان',
//         date: '1404/01/16',
//         referringDoctor: 'دکتر جلیلی',
//       ),
//     ];

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('لیست مراجعین'),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: Row(
//         children: [
//           // تقویم کنار صفحه
//           Expanded(
//             flex: 2,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TableCalendar(
//                 firstDay: DateTime.utc(2020, 1, 1),
//                 lastDay: DateTime.utc(2030, 12, 31),
//                 focusedDay: _focusedDay,
//                 selectedDayPredicate: (day) {
//                   // انتخاب روز
//                   return isSameDay(_selectedDay, day);
//                 },
//                 onDaySelected: (selectedDay, focusedDay) {
//                   setState(() {
//                     _selectedDay = selectedDay;
//                     _focusedDay = focusedDay;
//                   });
//                 },
//                 calendarFormat: _calendarFormat,
//                 availableGestures: AvailableGestures.all,
//                 eventLoader: (day) {
//                   return _selectedDays.value.contains(day) ? ['روز ویژه'] : [];
//                 },
//                 // تنظیم تاریخ‌های بولد
//                 holidayPredicate: (day) {
//                   return _selectedDays.value.contains(day);
//                 },
//                 headerStyle: HeaderStyle(
//                   formatButtonVisible: false,
//                   titleCentered: true,
//                 ),
//               ),
//             ),
//           ),
//           // لیست مراجعین
//           Expanded(
//             flex: 3,
//             child: ListView(
//               padding: EdgeInsets.all(8),
//               children: patients.map((patient) {
//                 return Card(
//                   elevation: 5,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   margin: EdgeInsets.symmetric(vertical: 10),
//                   child: ExpansionTile(
//                     title: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             patient.name,
//                             style: TextStyle(
//                                 fontSize: 20, fontWeight: FontWeight.bold),
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Text(
//                                 patient.date,
//                                 style:
//                                     TextStyle(fontSize: 14, color: Colors.grey),
//                               ),
//                               Text(
//                                 'ارجاع‌دهنده: ${patient.referringDoctor}',
//                                 style: TextStyle(
//                                     fontSize: 14, color: Colors.blueGrey),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     children: <Widget>[
//                       _buildTile('پرونده پزشکی', patient.medicalFile),
//                       _buildTile('اطلاعات پزشک', patient.doctorInfo),
//                       _buildTile('برنامه درمان', patient.treatmentPlan),
//                       _buildTile('گزارش پیشرفت درمان', patient.progressReports),
//                     ],
//                   ),
//                 );
//               }).toList(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTile(String title, String subtitle) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//       child: ListTile(
//         title: Text(title,
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//         subtitle: Text(subtitle, style: TextStyle(fontSize: 14)),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:shamsi_date/shamsi_date.dart';

// class Patient {
//   final String name;
//   final String medicalFile;
//   final String doctorInfo;
//   final String treatmentPlan;
//   final String progressReports;
//   final DateTime dateTime; // تغییر به DateTime برای ساعت و دقیقه
//   final String referringDoctor;
//   final Duration sessionDuration;

//   Patient({
//     required this.name,
//     required this.medicalFile,
//     required this.doctorInfo,
//     required this.treatmentPlan,
//     required this.progressReports,
//     required this.dateTime,
//     required this.referringDoctor,
//     required this.sessionDuration,
//   });
// }

// class PatientsListsoon extends StatefulWidget {
//   @override
//   _PatientsListState createState() => _PatientsListState();
// }

// class _PatientsListState extends State<PatientsListsoon> {
//   late DateTime _focusedDay;
//   DateTime? _selectedDay;

//   // نمونه داده‌ها
//   final List<Patient> patients = [
//     Patient(
//       name: 'مراجع 1',
//       medicalFile:
//           'مشخصات بیماری: دیابت نوع 2\nجزئیات رژیم دارو درمانی: داروی متفورمین 500 میلی‌گرم روزانه',
//       doctorInfo: 'پزشک متخصص: دکتر احمدی، متخصص داخلی، بیمارستان امام خمینی',
//       treatmentPlan: 'برنامه درمان: کاهش قند خون با رژیم دارویی و تغذیه‌ای',
//       progressReports:
//           'گزارش پیشرفت درمان: کاهش قند خون در حد مطلوب، بهبود وضعیت عمومی بیمار',
//       dateTime: DateTime(2025, 4, 4, 14, 30),
//       referringDoctor: 'دکتر احمدی',
//       sessionDuration: Duration(hours: 1, minutes: 30),
//     ),
//     Patient(
//       name: 'مراجع 2',
//       medicalFile:
//           'مشخصات بیماری: فشار خون بالا\nجزئیات رژیم دارو درمانی: داروی آتنولول 50 میلی‌گرم روزانه',
//       doctorInfo: 'پزشک متخصص: دکتر جلیلی، متخصص قلب، بیمارستان مدنی',
//       treatmentPlan: 'برنامه درمان: کاهش فشار خون با دارو و رژیم غذایی کم نمک',
//       progressReports:
//           'گزارش پیشرفت درمان: کنترل فشار خون در حد نرمال، نیاز به ادامه درمان',
//       dateTime: DateTime(2025, 4, 5, 10, 0),
//       referringDoctor: 'دکتر جلیلی',
//       sessionDuration: Duration(hours: 2),
//     ),
//     Patient(
//       name: 'مراجع 3',
//       medicalFile:
//           'مشخصات بیماری: کم‌خونی\nجزئیات رژیم دارو درمانی: مکمل آهن و ویتامین B12',
//       doctorInfo: 'پزشک متخصص: دکتر رضایی، متخصص داخلی، بیمارستان مهر',
//       treatmentPlan: 'برنامه درمان: افزایش هموگلوبین با تغذیه و مکمل',
//       progressReports:
//           'گزارش پیشرفت درمان: افزایش سطح هموگلوبین، بهبود انرژی و حالت عمومی',
//       dateTime: DateTime(2025, 4, 7, 9, 15),
//       referringDoctor: 'دکتر رضایی',
//       sessionDuration: Duration(hours: 1, minutes: 15),
//     ),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _focusedDay = DateTime.now();
//     _selectedDay = _focusedDay;
//   }

//   // برای پیدا کردن جلسات آن روز
//   List<Patient> _getPatientsForDay(DateTime day) {
//     return patients.where((patient) {
//       return isSameDay(patient.dateTime, day);
//     }).toList();
//   }

//   // تبدیل میلادی به شمسی
//   String _formatJalali(DateTime date) {
//     final f = Jalali.fromDateTime(date);
//     return '${f.year}/${f.month.toString().padLeft(2, '0')}/${f.day.toString().padLeft(2, '0')}';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('لیست مراجعین'),
//         backgroundColor: Colors.blueAccent,
//         centerTitle: true,
//       ),
//       body: Row(
//         children: [
//           // تقویم
//           Expanded(
//             flex: 2,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TableCalendar<Patient>(
//                 firstDay: DateTime.utc(2020, 1, 1),
//                 lastDay: DateTime.utc(2030, 12, 31),
//                 focusedDay: _focusedDay,
//                 selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
//                 onDaySelected: (selectedDay, focusedDay) {
//                   setState(() {
//                     _selectedDay = selectedDay;
//                     _focusedDay = focusedDay;
//                   });
//                 },
//                 calendarFormat: CalendarFormat.month,
//                 eventLoader: _getPatientsForDay,
//                 headerStyle: HeaderStyle(
//                   formatButtonVisible: false,
//                   titleCentered: true,
//                 ),
//                 calendarBuilders: CalendarBuilders(
//                   markerBuilder: (context, date, patients) {
//                     if (patients.isNotEmpty) {
//                       return Positioned(
//                         bottom: 6,
//                         child: Container(
//                           width: 6,
//                           height: 6,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.redAccent,
//                           ),
//                         ),
//                       );
//                     }
//                     return null;
//                   },
//                   todayBuilder: (context, date, _) {
//                     return Container(
//                       margin: const EdgeInsets.all(6.0),
//                       decoration: BoxDecoration(
//                         color: Colors.blueAccent.withOpacity(0.5),
//                         shape: BoxShape.circle,
//                       ),
//                       child: Center(
//                         child: Text(
//                           date.day.toString(),
//                           style: TextStyle(
//                               color: Colors.white, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     );
//                   },
//                   selectedBuilder: (context, date, _) {
//                     return Container(
//                       margin: const EdgeInsets.all(6.0),
//                       decoration: BoxDecoration(
//                         color: Colors.blueAccent,
//                         shape: BoxShape.circle,
//                       ),
//                       child: Center(
//                         child: Text(
//                           date.day.toString(),
//                           style: TextStyle(
//                               color: Colors.white, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ),

//           // لیست مراجعین
//           Expanded(
//             flex: 3,
//             child: _selectedDay == null
//                 ? Center(child: Text('روز را انتخاب کنید'))
//                 : _buildPatientList(_getPatientsForDay(_selectedDay!)),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPatientList(List<Patient> dayPatients) {
//     if (dayPatients.isEmpty) {
//       return Center(
//         child: Text('هیچ جلسه‌ای برای این روز وجود ندارد',
//             style: TextStyle(fontSize: 16)),
//       );
//     }

//     return ListView.builder(
//       padding: EdgeInsets.all(8),
//       itemCount: dayPatients.length,
//       itemBuilder: (context, index) {
//         final patient = dayPatients[index];
//         final jalaliDate = _formatJalali(patient.dateTime);
//         final time =
//             '${patient.dateTime.hour.toString().padLeft(2, '0')}:${patient.dateTime.minute.toString().padLeft(2, '0')}';
//         final durationHours = patient.sessionDuration.inHours;
//         final durationMinutes = patient.sessionDuration.inMinutes % 60;

//         return Card(
//           margin: EdgeInsets.symmetric(vertical: 8),
//           elevation: 4,
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//           child: ExpansionTile(
//             title: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   patient.name,
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Text('$jalaliDate',
//                         style: TextStyle(color: Colors.grey[600])),
//                     Text('ساعت: $time',
//                         style: TextStyle(color: Colors.grey[600])),
//                     Text(
//                         'مدت جلسه: ${durationHours} ساعت و ${durationMinutes} دقیقه',
//                         style: TextStyle(color: Colors.grey[600])),
//                   ],
//                 )
//               ],
//             ),
//             children: [
//               _buildTile('پرونده پزشکی', patient.medicalFile),
//               _buildTile('اطلاعات پزشک', patient.doctorInfo),
//               _buildTile('برنامه درمان', patient.treatmentPlan),
//               _buildTile('گزارش پیشرفت درمان', patient.progressReports),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 child: Text(
//                   'ارجاع‌دهنده: ${patient.referringDoctor}',
//                   style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildTile(String title, String subtitle) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//       child: ListTile(
//         title: Text(title,
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//         subtitle: Text(subtitle, style: TextStyle(fontSize: 14)),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shamsi_date/shamsi_date.dart';

class Patient {
  final String name;
  final DateTime dateTime;
  final Duration sessionDuration;
  final String medicalFile;
  final String doctorInfo;
  final String treatmentPlan;
  final String progressReports;
  final String referringDoctor;

  Patient({
    required this.name,
    required this.dateTime,
    required this.sessionDuration,
    required this.medicalFile,
    required this.doctorInfo,
    required this.treatmentPlan,
    required this.progressReports,
    required this.referringDoctor,
  });
}

class PersianCalendarPage extends StatefulWidget {
  @override
  _PersianCalendarPageState createState() => _PersianCalendarPageState();
}

class _PersianCalendarPageState extends State<PersianCalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // نمونه داده جلسات
  final List<Patient> patients = [
    Patient(
      name: 'مراجع 1',
      dateTime: DateTime(2025, 5, 1, 14, 30),
      sessionDuration: Duration(hours: 1, minutes: 30),
      medicalFile:
          'مشخصات بیماری: دیابت نوع 2\nجزئیات رژیم دارو درمانی: متفورمین',
      doctorInfo: '2دکتر قلان',
      treatmentPlan: 'کاهش قند خون',
      progressReports: 'بهبود وضعیت عمومی',
      referringDoctor: '2دکتر فلان',
    ),
    Patient(
      name: 'مراجع 2',
      dateTime: DateTime(2025, 5, 3, 10, 0),
      sessionDuration: Duration(hours: 2),
      medicalFile: 'مشخصات بیماری: فشار خون بالا\nداروی آتنولول',
      doctorInfo: 'دکتر فلان 3',
      treatmentPlan: 'کاهش فشار خون',
      progressReports: 'نیاز به ادامه درمان',
      referringDoctor: 'دکتر فلان 3',
    ),
    Patient(
      name: 'مراجع 3',
      dateTime: DateTime(2025, 5, 3, 12, 0),
      sessionDuration: Duration(hours: 1, minutes: 15),
      medicalFile: 'کم‌خونی\nمکمل آهن',
      doctorInfo: 'دکتر فلان4',
      treatmentPlan: 'افزایش هموگلوبین',
      progressReports: 'افزایش سطح هموگلوبین',
      referringDoctor: 'دکتر فلان4',
    ),
    Patient(
      name: 'مراجع 4',
      dateTime: DateTime(2025, 5, 5, 9, 0),
      sessionDuration: Duration(hours: 1),
      medicalFile: 'آرتروز زانو\nدارو و فیزیوتراپی',
      doctorInfo: 'دکتر فلان 5',
      treatmentPlan: 'کاهش درد',
      progressReports: 'کاهش التهاب',
      referringDoctor: 'دکتر فلان5',
    ),
  ];

  // تبدیل میلادی به شمسی رشته‌ای
  String _formatJalali(DateTime dt) {
    final f = Jalali.fromDateTime(dt);
    return '${f.year}/${f.month.toString().padLeft(2, '0')}/${f.day.toString().padLeft(2, '0')}';
  }

  // استخراج جلسات هر روز
  List<Patient> _getPatientsForDay(DateTime day) {
    return patients.where((p) => isSameDay(p.dateTime, day)).toList();
  }

  // تمام جلسات
  List<Patient> get allPatients => patients;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final patientsForSelectedDay =
        _selectedDay == null ? [] : _getPatientsForDay(_selectedDay!);

    return Scaffold(
      appBar: AppBar(
        title: Text('تقویم شمسی جلسات'),
        centerTitle: true,
      ),
      body: Row(
        children: [
          // سمت چپ: تقویم
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: TableCalendar<Patient>(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                calendarFormat: CalendarFormat.month,
                eventLoader: _getPatientsForDay,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextFormatter: (date, locale) {
                    final f = Jalali.fromDateTime(date);
                    return '${f.year} / ${f.month.toString().padLeft(2, '0')}';
                  },
                ),
                calendarBuilders: CalendarBuilders(
                  dowBuilder: (context, day) {
                    final weekdays = ['ش', 'ی', 'د', 'س', 'چ', 'پ', 'ج'];
                    // ignore: unused_local_variable
                    final f = Jalali.fromDateTime(day);
                    return Center(
                      child: Text(
                        weekdays[day.weekday % 7],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                  defaultBuilder: (context, day, focusedDay) {
                    final f = Jalali.fromDateTime(day);
                    return Center(child: Text(f.day.toString()));
                  },
                  todayBuilder: (context, day, focusedDay) {
                    final f = Jalali.fromDateTime(day);
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          f.day.toString(),
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                  selectedBuilder: (context, day, focusedDay) {
                    final f = Jalali.fromDateTime(day);
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          f.day.toString(),
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                  markerBuilder: (context, date, patients) {
                    if (patients.isNotEmpty) {
                      return Positioned(
                        bottom: 4,
                        right: 4,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),

          // سمت راست: لیست تمام جلسات
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: ListView.builder(
                itemCount: allPatients.length,
                itemBuilder: (context, index) {
                  final p = allPatients[index];
                  final isSelected = _selectedDay != null &&
                      isSameDay(p.dateTime, _selectedDay!);
                  final jalaliDate = _formatJalali(p.dateTime);
                  final timeStr =
                      '${p.dateTime.hour.toString().padLeft(2, '0')}:${p.dateTime.minute.toString().padLeft(2, '0')}';
                  final durHours = p.sessionDuration.inHours;
                  final durMinutes = p.sessionDuration.inMinutes % 60;

                  return Card(
                    color: isSelected ? Colors.blue.shade100 : null,
                    elevation: isSelected ? 6 : 2,
                    margin: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      title: Text(p.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 6),
                          Text('تاریخ: $jalaliDate',
                              style: TextStyle(fontSize: 14)),
                          Text('ساعت: $timeStr',
                              style: TextStyle(fontSize: 14)),
                          Text(
                              'مدت جلسه: ${durHours} ساعت و ${durMinutes} دقیقه',
                              style: TextStyle(fontSize: 14)),
                          SizedBox(height: 6),
                          Text('ارجاع‌دهنده: ${p.referringDoctor}',
                              style: TextStyle(
                                  fontSize: 14, fontStyle: FontStyle.italic)),
                        ],
                      ),
                      onTap: () {
                        // با کلیک روی جلسه، تاریخش رو انتخاب کن و هایلایت کن
                        setState(() {
                          _selectedDay = p.dateTime;
                          _focusedDay = p.dateTime;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
