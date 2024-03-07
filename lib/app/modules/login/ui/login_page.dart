import 'package:flutter/material.dart';
import './widgets/login_form.dart';
import '/app/core/values/app_values.dart';
import '/app/core/values/app_text_styles.dart';

class LoginPage extends StatelessWidget {

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 50, bottom: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/logo.png', width: 50, height: 50),
                      const SizedBox(width: 20),
                      const Text(AppValues.appName, style: AppTextStyle.loginTitle),
                    ],
                  )
              ),
              const LoginForm(),
              const SizedBox(height: 40),
              Text(AppValues.version, style: Theme.of(context).textTheme.bodySmall)
            ],
          ),
        ),
      ),
    );
  }

}