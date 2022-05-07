import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/common/header_painter.dart';
import 'package:blood_source/shared/widgets/app_back_button.dart';
import 'package:blood_source/shared/widgets/app_button.dart';
import 'package:blood_source/shared/widgets/app_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signUp() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        user.updateDisplayName(_nameController.text);
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: AppColors.primary.withOpacity(0.03),
              child: CustomPaint(
                painter: HeaderPainter(),
                child: Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 24.r),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Sign Up',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        4.verticalSpace,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40.r),
                          child: Text(
                            "Welcome to BloodSource",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        40.verticalSpace,
                        AppTextField(
                          controller: _nameController,
                          hintText: 'Name',
                        ),
                        18.verticalSpace,
                        AppTextField(
                          controller: _emailController,
                          hintText: 'Email',
                          keyboardType: TextInputType.emailAddress,
                        ),
                        18.verticalSpace,
                        AppTextField(
                          controller: _passwordController,
                          hintText: 'Password',
                          isPassword: true,
                        ),
                        40.verticalSpace,
                        AppButton(onTap: () => signUp(), text: 'Sign Up'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const AppBackButton(),
          ],
        ),
      ),
    );
  }
}
