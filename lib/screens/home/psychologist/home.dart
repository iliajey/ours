import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home/psychologist/profile.dart';

import 'allpatients.dart';
import 'calc.dart';
import 'comingpatients.dart';

class TabManagementPage extends StatefulWidget {
  const TabManagementPage({super.key});

  @override
  _TabManagementPageState createState() => _TabManagementPageState();
}

class _TabManagementPageState extends State<TabManagementPage> {
  int selectedTabIndex = 0;
  bool isMenuCollapsed = false; // برای کنترل وضعیت باز و بسته بودن منو

  final List<String> tabs = [
    'داشبورد',
    'مراجعین پیش رو',
    'ارشیو مراجعین',
    'گزارشات مالی'
  ];
  final List<IconData> tabIcons = [
    Icons.dashboard,
    Icons.group,
    Icons.settings,
    Icons.report,
  ];

  final List<Widget> tabContents = [
    ProfilePage(),
    PersianCalendarPage(),
    PatientsList(),
    AccountingPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: Row(
        children: [
          // 3/4 سمت چپ (محتوا)
          
          // 1/4 سمت راست (منو تب‌ها)
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: isMenuCollapsed ? 50 : 200, // تغییر اندازه منو
            color: Colors.grey[200],
            child: ListView.builder(
              itemCount: tabs.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTabIndex = index;
                    });
                  },
                  child: ListTile(
                    leading: Icon(
                      tabIcons[index],
                      color: selectedTabIndex == index
                          ? Colors.blue
                          : Colors.black,
                    ),
                    title: isMenuCollapsed
                        ? null // فقط آیکون نشان داده می‌شود زمانی که منو بسته است
                        : Text(
                            tabs[index],
                            style: TextStyle(
                              fontWeight: selectedTabIndex == index
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                    selected: selectedTabIndex == index,
                  ),
                );
              },
            ),
          ),Expanded(
            flex: 4,
            child: Container(
              color: Colors.white,
              child: tabContents[selectedTabIndex],
            ),
          ),
        ],
      ),
      // یک دکمه برای باز و بسته کردن منو
      floatingActionButton: FloatingActionButton(

        onPressed: () {
          setState(() {
            isMenuCollapsed = !isMenuCollapsed; // باز و بسته کردن منو
          });
        },
        child: Icon(isMenuCollapsed ? Icons.arrow_forward : Icons.arrow_back),
      ),
    );
  }
}
