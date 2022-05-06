import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/common/header_painter.dart';
import 'package:blood_source/shared/widgets/app_button.dart';
import 'package:blood_source/shared/widgets/app_text_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColors.primary.withOpacity(0.02),
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
                    TextField(
                      controller: _emailController,
                      style: TextStyle(fontSize: 18.sp),
                      decoration: InputDecoration(
                        hintText: 'Enter email',
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 24.r,
                          horizontal: 26.r,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AppColors.primary,
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    ),
                    18.verticalSpace,
                    TextField(
                      controller: _passwordController,
                      obscureText: _isObscure,
                      style: TextStyle(fontSize: 18.sp),
                      decoration: InputDecoration(
                        hintText: 'Password',
                        fillColor: Colors.white,
                        filled: true,
                        suffixIcon: IconButton(
                          icon: _isObscure
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                          padding: EdgeInsets.all(26.r),
                          onPressed: () {
                            setState(() => _isObscure = !_isObscure);
                          },
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 24.r,
                          horizontal: 26.r,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AppColors.primary,
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
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
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            splashFactory: NoSplash.splashFactory,
                          ),
                          child: Text(
                            'Register now',
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.swatch.shade500,
                            ),
                          ),
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
