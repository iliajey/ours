import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/signup_controller.dart';

class SignUpPage extends StatelessWidget {
  final controller = Get.put(SignUpController());

   SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ثبت‌نام')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: controller.nameController,
                decoration: InputDecoration(labelText: 'نام کامل'),
                validator: (value) =>
                    value!.isEmpty ? 'نام را وارد کنید' : null,
              ),
              TextFormField(
                controller: controller.emailController,
                decoration: InputDecoration(labelText: 'ایمیل'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    !GetUtils.isEmail(value!) ? 'ایمیل معتبر نیست' : null,
              ),
              TextFormField(
                controller: controller.passwordController,
                decoration: InputDecoration(labelText: 'رمز عبور'),
                obscureText: true,
                validator: (value) =>
                    value!.length < 6 ? 'رمز باید حداقل ۶ کاراکتر باشد' : null,
              ),
              TextFormField(
                controller: controller.confirmPasswordController,
                decoration: InputDecoration(labelText: 'تایید رمز عبور'),
                obscureText: true,
                validator: (value) =>
                    value != controller.passwordController.text
                        ? 'رمز مطابقت ندارد'
                        : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: controller.submit,
                child: Text('ثبت‌نام'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
