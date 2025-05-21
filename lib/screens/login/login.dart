import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home/user/userdashboard.dart';
import 'package:flutter_application_1/screens/login/signup_page.dart';
import 'package:get/get.dart';
import '../home/psychologist/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _selectedRole;
  final _animationDuration = const Duration(milliseconds: 350);
  double ms = Get.height;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: AnimatedContainer(
          duration: _animationDuration,
          curve: Curves.easeInOut,
          padding: const EdgeInsets.all(24),
          constraints: BoxConstraints(
            maxWidth: 400,
            // وقتی نقش انتخاب میشه ارتفاع بزرگتر میشه تا جا باز کنه
            minHeight: _selectedRole != null ? 510 : 320,
            minWidth: 300,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 20,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 32,
                backgroundColor: Colors.blueAccent,
                child: Icon(Icons.add, color: Colors.white, size: 32),
              ),
              const SizedBox(height: 16),
              const Text(
                'ورود به پلتفرم روانشناسی',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                'به پلتفرم ارتباط روانشناس، روانپزشک و مراجع خوش آمدید',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 28),

              // نقش‌ها با انیمیشن
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _animatedRoleButton('user', Icons.person, 'مراجع'),
                  const SizedBox(width: 8),
                  _animatedRoleButton(
                      'psychologist', Icons.science, 'روانشناس'),
                  const SizedBox(width: 8),
                  _animatedRoleButton(
                      'psychiatrist', Icons.local_hospital, 'روانپزشک'),
                ],
              ),

              if (_selectedRole != null) ...[
                const SizedBox(height: 28),
                AnimatedOpacity(
                  opacity: _selectedRole != null ? 1.0 : 0.0,
                  duration: _animationDuration,
                  child: Column(
                    children: [
                      TextField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: 'نام کاربری',
                          prefixIcon: Icon(Icons.person_outline),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'رمز عبور',
                          prefixIcon: Icon(Icons.lock_outline),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.to(SignUpPage());
                            },
                            child: const Text(
                              'ثبت‌نام کنید',
                              style: TextStyle(
                                color: Color(0xFF305AFF), // رنگ دلخواه
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // TODO: افزودن عملکرد بازیابی رمز
                            },
                            child: const Text(
                              'فراموشی رمز؟',
                              style: TextStyle(
                                color: Color(0xFF305AFF), // همرنگ ثبت نام
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_selectedRole == 'user') {
                              Get.to(MainPage());
                            } else if (_selectedRole == 'psychologist') {
                              Get.to(TabManagementPage());
                            } else if (_selectedRole == 'psychiatrist') {
                              Get.snackbar(
                                'Error',
                                'invalid password',
                                dismissDirection: DismissDirection.up,
                                icon: Icon(Icons.error_outline),
                                snackPosition: SnackPosition.TOP,
                                backgroundColor:
                                    Color.fromARGB(112, 244, 67, 54),
                                margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                              );                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            backgroundColor:
                                const Color.fromARGB(255, 55, 80, 202),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)),
                          ),
                          child: const Text(
                            'ورود به سامانه',
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(199, 255, 255, 255)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // نقش با افکت بزرگ شدن هنگام انتخاب
  Widget _animatedRoleButton(String role, IconData icon, String label) {
    final isSelected = _selectedRole == role;
    return Expanded(
      child: AnimatedScale(
        duration: _animationDuration,
        scale: isSelected ? 1.12 : 1.0,
        curve: Curves.easeInOut,
        child: GestureDetector(
          onTap: () {
            setState(() {
              _selectedRole = role;
            });
          },
          child: AnimatedContainer(
            duration: _animationDuration,
            curve: Curves.easeInOut,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            padding: EdgeInsets.symmetric(
              vertical: isSelected ? 18 : 14,
              horizontal: 0,
            ),
            decoration: BoxDecoration(
              color: isSelected ? Colors.indigo[50] : Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? Colors.indigo : Colors.transparent,
                width: 2,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: Colors.indigo.withOpacity(0.12),
                        blurRadius: 12,
                        offset: Offset(0, 3),
                      ),
                    ]
                  : [],
            ),
            child: Column(
              children: [
                Icon(icon,
                    color: isSelected ? Colors.indigo : Colors.black54,
                    size: isSelected ? 32 : 26),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    color: isSelected ? Colors.indigo : Colors.black87,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
