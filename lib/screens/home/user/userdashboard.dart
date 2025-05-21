import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:get/get.dart';


class ReferralApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // locale: Locale('fa'),
      title: 'Referral Digital Platform',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Color(0xFFF5F7FA),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.indigo,
          elevation: 4,
          centerTitle: true,
          titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        drawerTheme: DrawerThemeData(
          scrimColor: Colors.black38,
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.indigo[900]),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.grey[800]),
          bodySmall: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
      ),
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// صفحه اصلی: داشبورد اولیه با جدول پرداخت، تقویم جلسات، ریمایندر و نیوزلتر
class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // نمونه داده پرداخت
  final List<Map<String, String>> payments = [
    {"date": "1404-02-21", "amount": "100 هزار", "description": "جلسه روانشناسی"},
    {"date": "1404-02-25", "amount": "150 هزار", "description": "مشاوره ویدیویی"},
  ];

  // نمونه جلسات تقویم
  final List<Map<String, String>> sessions = [
    {"date": "۲۱ اردیبهشت ۱۴۰۴ - ساعت ۱۴:۰۰", "title": "جلسه با دکتر فلانی1"},
    {"date": "۲۵ اردیبهشت ۱۴۰۴ - ساعت ۱۶:۳۰", "title": "جلسه مشاوره متنی"},
  ];

  // نمونه نیوزلتر آموزشی
  final List<String> newsletters = [
    "چگونه استرس را کنترل کنیم؟",
    "فواید مدیتیشن برای سلامت روان",
    "نکاتی برای خواب بهتر و سلامت ذهن",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('داشبورد مراجع'),
        elevation: 5,
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: "جدول پرداخت‌ها", icon: Icons.payment),
            SizedBox(height: 12),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: DataTable(
                headingRowColor: MaterialStateProperty.all(Colors.indigo.shade50),
                columns: [
                  DataColumn(
                      label: Text('تاریخ',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo))),
                  DataColumn(
                      label: Text('مبلغ',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo))),
                  DataColumn(
                      label: Text('توضیحات',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo))),
                ],
                rows: payments
                    .map(
                      (p) => DataRow(
                        cells: [
                          DataCell(Text(p["date"]!, style: TextStyle(fontSize: 16))),
                          DataCell(Text(p["amount"]!, style: TextStyle(fontSize: 16))),
                          DataCell(Text(p["description"]!, style: TextStyle(fontSize: 16))),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
            SizedBox(height: 32),

            SectionTitle(title: "تقویم جلسات", icon: Icons.event_available),
            SizedBox(height: 12),
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: sessions.length,
              separatorBuilder: (_, __) => Divider(height: 16),
              itemBuilder: (context, i) {
                final s = sessions[i];
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  tileColor: Colors.indigo.shade50,
                  leading: CircleAvatar(
                    backgroundColor: Colors.indigo.shade400,
                    child: Icon(Icons.event, color: Colors.white),
                  ),
                  title: Text(s["title"]!,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.indigo[900],
                          fontSize: 18)),
                  subtitle: Text(s["date"]!, style: TextStyle(fontSize: 14)),
                );
              },
            ),
            SizedBox(height: 32),

            SectionTitle(title: "نیوزلترهای آموزشی سلامت روان", icon: Icons.article),
            SizedBox(height: 12),
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: newsletters.length,
              separatorBuilder: (_, __) => Divider(height: 16),
              itemBuilder: (context, i) {
                final n = newsletters[i];
                return ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  tileColor: Colors.indigo.shade50,
                  leading: CircleAvatar(
                    backgroundColor: Colors.indigo.shade300,
                    child: Icon(Icons.article, color: Colors.white),
                  ),
                  title: Text(n,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: Colors.indigo[900])),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.indigo),
                  onTap: () {
                    // در آینده می‌توانید به صفحه جزئیات نیوزلتر برید
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('نمایش جزئیات "$n" در آینده')));
                  },
                );
              },
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;

  const SectionTitle({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.indigo, size: 28),
        SizedBox(width: 10),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }
}

/// منوی کشویی راست
class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo),
              child: Center(
                child: Text(
                  'منوی مراجع',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard, color: Colors.indigo),
              title: Text('داشبورد', style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => MainPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.person, color: Colors.indigo),
              title: Text('پروفایل مراجع', style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => ProfilePage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.psychology, color: Colors.indigo),
              title: Text('لیست روانشناسان', style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => PsychologistsListPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.folder_shared, color: Colors.indigo),
              title: Text('پرونده‌های پزشکی', style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => MedicalRecordsPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// صفحه پروفایل مراجع با اطلاعات اولیه و شرح حال
class ProfilePage extends StatelessWidget {
  final Map<String, String> basicInfo = {
    "نام": "فلان",
    "نام خانوادگی": "فلانی",
    "سن": "123",
    "جنسیت": "مرد",
    "تلفن": "09123456789",
  };

  final String chiefComplaint =
      "احساس اضطراب و استرس زیاد در محیط کار و زندگی روزمره، مشکلات خواب و کاهش تمرکز.";

  final List<String> mainNeeds = [
    "کاهش اضطراب",
    "بهبود کیفیت خواب",
    "مدیریت استرس",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('پروفایل مراجع'),
        elevation: 5,
      ),
      endDrawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: ListView(
          children: [
            SectionTitle(title: "اطلاعات اولیه", icon: Icons.person_outline),
            SizedBox(height: 12),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: basicInfo.entries
                      .map((e) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${e.key}:',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: Colors.indigo[900])),
                                Text(e.value,
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.grey[800])),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
            SizedBox(height: 28),
            SectionTitle(title: "شرح حال اخذ شده اولیه", icon: Icons.note_alt_outlined),
            SizedBox(height: 12),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  chiefComplaint,
                  style: TextStyle(fontSize: 16, height: 1.5, color: Colors.grey[800]),
                ),
              ),
            ),
            SizedBox(height: 28),
            SectionTitle(title: "نیازهای اصلی مراجع", icon: Icons.check_circle_outline),
            SizedBox(height: 12),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: mainNeeds
                      .map((need) => ListTile(
                            leading: Icon(Icons.check_circle, color: Colors.indigo),
                            title: Text(
                              need,
                              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// صفحه لیست روانشناسان متناسب با ترجیحات مراجع
class PsychologistsListPage extends StatelessWidget {
  final List<Map<String, dynamic>> psychologists = [
    {
      "name": "دکتر فلان فلانی",
      "approach": "رفتاردرمانی شناختی",
      "experience": "۵ سال",
      "modalities": ["متن", "صوت", "ویدئو"]
    },
    {
      "name": "دکتر فلان فلانی",
      "approach": "روانکاوی",
      "experience": "۸ سال",
      "modalities": ["متن", "ویدئو"]
    },
    {
      "name": "دکتر فلان فلانی",
      "approach": "روانشناسی مثبت‌گرا",
      "experience": "۳ سال",
      "modalities": ["صوت", "ویدئو"]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('لیست روانشناسان متناسب'),
        elevation: 5,
      ),
      endDrawer: AppDrawer(),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        itemCount: psychologists.length,
        itemBuilder: (context, index) {
          var psy = psychologists[index];
          return Card(
            margin: EdgeInsets.only(bottom: 18),
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              title: Text(
                psy["name"],
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.indigo[900]),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("رویکرد درمانی: ${psy["approach"]}",
                          style: TextStyle(
                              fontSize: 16, color: Colors.grey[800], height: 1.3)),
                      SizedBox(height: 4),
                      Text("سابقه فعالیت: ${psy["experience"]}",
                          style: TextStyle(
                              fontSize: 16, color: Colors.grey[800], height: 1.3)),
                      SizedBox(height: 4),
                      Text(
                          "مودالیته جلسه: ${psy["modalities"].join(", ")}",
                          style: TextStyle(
                              fontSize: 16, color: Colors.grey[800], height: 1.3)),
                    ]),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// صفحه پرونده‌های پزشکی مراجع
class MedicalRecordsPage extends StatelessWidget {
  final List<Map<String, String>> medicalRecords = [
    {
      "date": "۱۱ آبان ۱۴۰۳",
      "specialist": "دکتر پزشکی متخصص داخلی",
      "diagnosis": "دیابت نوع ۲",
      "medication": "متفورمین ۵۰۰ میلی‌گرم هر ۱۲ ساعت",
      "notes": "نیاز به کنترل قند خون دقیق و پیگیری منظم"
    },
    {
      "date": "۲۵ بهمن ۱۴۰۳",
      "specialist": "دکتر روانشناس",
      "diagnosis": "اضطراب فراگیر",
      "medication": "داروهای ضد اضطراب تجویز شده",
      "notes": "ادامه جلسات درمان شناختی رفتاری"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('پرونده‌های پزشکی مراجع'),
        elevation: 5,
      ),
      endDrawer: AppDrawer(),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        itemCount: medicalRecords.length,
        itemBuilder: (context, index) {
          var record = medicalRecords[index];
          return Card(
            margin: EdgeInsets.only(bottom: 20),
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("تاریخ: ${record['date']}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.indigo[900])),
                  SizedBox(height: 8),
                  Text("پزشک متخصص: ${record['specialist']}",
                      style: TextStyle(fontSize: 16, color: Colors.grey[800])),
                  SizedBox(height: 8),
                  Text("تشخیص: ${record['diagnosis']}",
                      style: TextStyle(fontSize: 16, color: Colors.grey[800])),
                  SizedBox(height: 8),
                  Text("رژیم دارو درمانی: ${record['medication']}",
                      style: TextStyle(fontSize: 16, color: Colors.grey[800])),
                  SizedBox(height: 8),
                  Text("یادداشت‌ها: ${record['notes']}",
                      style: TextStyle(fontSize: 16, color: Colors.grey[800])),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
