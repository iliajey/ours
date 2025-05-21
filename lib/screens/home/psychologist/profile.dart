
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // ignore: unused_field
  int _selectedIndex = 0;

  final List<GlobalKey> _sectionKeys = [
    GlobalKey(), // برای پروفایل
    GlobalKey(), // برای خدمات
    GlobalKey(), // برای نظرات
    GlobalKey(), // برای تماس
    GlobalKey(), // برای موقعیت مکانی
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Scrollable.ensureVisible(_sectionKeys[index].currentContext!,
        duration: Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5, // تعداد تب‌ها
      child: Scaffold(
        appBar: AppBar(
          title: Text('پروفایل دکتر فلان فلانی'),
          backgroundColor: Colors.blueAccent,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'پروفایل'),
              Tab(text: 'خدمات'),
              Tab(text: 'نظرات'),
              Tab(text: 'تماس'),
              Tab(text: 'موقعیت مکانی'),
            ],
            onTap: _onItemTapped,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ProfileSection(key: _sectionKeys[0]),
              Divider(),
              ServicesSection(key: _sectionKeys[1]),
              Divider(),
              ReviewsSection(key: _sectionKeys[2]),
              Divider(),
              ContactSection(key: _sectionKeys[3]),
              Divider(),
              LocationSection(key: _sectionKeys[4]),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage:
                NetworkImage('https://www.example.com/profile_pic.jpg'),
          ),
          SizedBox(height: 20),
          Text(
            'دکتر فلان فلانی',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            'روانشناس و متخصص سلامت روان',
            style: TextStyle(color: Colors.white70),
          ),
          SizedBox(height: 20),
          Text(
            'تحصیلات و تخصص‌ها:',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            'دکترای روانشناسی بالینی، دانشگاه تهران',
            style: TextStyle(color: Colors.white70),
          ),
          Text(
            'تخصص در درمان شناختی-رفتاری (CBT)',
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'خدمات درمانی:',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent),
          ),
          SizedBox(height: 20),
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [
              ServiceCard(
                title: 'مشاوره و روان‌درمانی',
                description:
                    'این خدمات شامل مشاوره فردی و گروهی برای درمان مشکلات روانی و هیجانی است.',
              ),
              ServiceCard(
                title: 'مشاوره کودک و نوجوان',
                description:
                    'مشاوره تخصصی برای درمان مشکلات رفتاری و هیجانی در کودکان و نوجوانان.',
              ),
              ServiceCard(
                title: 'مشاوره زوجین',
                description:
                    'کمک به زوج‌ها برای حل مشکلات ارتباطی و بهبود رابطه.',
              ),
              ServiceCard(
                title: 'درمان افسردگی و اضطراب',
                description:
                    'درمان‌های علمی و اثبات شده برای کمک به افرادی که از افسردگی یا اضطراب رنج می‌برند.',
              ),
              ServiceCard(
                title: 'مشاوره پیش از ازدواج',
                description:
                    'آماده‌سازی زوج‌ها برای زندگی مشترک با راهنمایی‌های روانشناسی و بررسی مسائل عاطفی.',
              ),
              ServiceCard(
                title: 'درمان اختلالات رفتاری',
                description:
                    'درمان اختلالات رفتاری مانند اختلالات خوردن، اضطراب اجتماعی و دیگر مشکلات مشابه.',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String title;
  final String description;

  const ServiceCard({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.blue[50],
      elevation: 5,
      shadowColor: Colors.black26,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(Icons.healing, size: 40, color: Colors.blueAccent),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent),
            ),
            SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(fontSize: 12, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class ReviewsSection extends StatelessWidget {
  const ReviewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'نظرات مراجعین:',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent),
          ),
          ReviewCard(
              name: 'فلانی 1',
              review: 'روانشناس عالی! به من در مدیریت اضطراب کمک زیادی کرد.'),
          ReviewCard(
              name: 'فلانی 2',
              review: 'بسیار فهمیده و مهربان. به شدت توصیه می‌کنم.'),
        ],
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final String name;
  final String review;

  const ReviewCard({super.key, required this.name, required this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      elevation: 5,
      shadowColor: Colors.black26,
      child: ListTile(
        title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(review),
      ),
    );
  }
}

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('اطلاعات تماس:',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.blueAccent)),
          Text('ایمیل: folan_folani@example.com'),
          Text('تلفن: +123 456 7890'),
          Text('وب‌سایت: www.folan_psychologist.com'),
        ],
      ),
    );
  }
}

class LocationSection extends StatelessWidget {
  const LocationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('موقعیت مکانی:',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.blueAccent)),
          Text('کلینیک دکتر فلان فلانی، تهران، ایران'),
          SizedBox(height: 20),
          Container(
            height: 200,
            color: Colors.blue[100],
            child: Center(
              child: Text('گنجاندن نقشه گوگل'),
            ),
          ),
        ],
      ),
    );
  }
}
