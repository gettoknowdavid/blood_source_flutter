import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/common/header_painter.dart';
import 'package:blood_source/shared/widgets/app_button.dart';
import 'package:blood_source/shared/widgets/app_text_button.dart';
import 'package:blood_source/shared/widgets/app_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  createState() => _SignInPage();
}

class _SignInPage extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
                      'Hello Again!',
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
                        "Welcome back, you've been missed!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                    40.verticalSpace,
                    AppTextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Enter email',
                    ),
                    18.verticalSpace,
                    AppTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                      isPassword: true,
                    ),
                    AppTextButton(
                      text: 'Password Recovery',
                      onTap: () {},
                      fontSize: 16.sp,
                      color: Colors.black54,
                      alignment: Alignment.centerRight,
                    ),
                    40.verticalSpace,
                    AppButton(onTap: () {}, text: 'Sign In'),
                    30.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Not a member?',
                          style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                        6.horizontalSpace,
                        AppTextButton(
                          text: 'Register now',
                          onTap: () {},
                          fontSize: 17.sp,
                          color: AppColors.swatch.shade500,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
