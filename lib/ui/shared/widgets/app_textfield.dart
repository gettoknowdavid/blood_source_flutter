import 'package:blood_source/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.textInputAction,
  }) : super(key: key);

  final TextEditingController controller;
  final bool isPassword;
  final String hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputAction? textInputAction;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _isObscure = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: widget.textInputAction,
      onChanged: widget.onChanged,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      obscureText: widget.isPassword ? !_isObscure : _isObscure,
      style: TextStyle(fontSize: 18.sp),
      decoration: InputDecoration(
        hintText: widget.hintText,
        errorStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.swatch.shade900),
          borderRadius: BorderRadius.circular(12.r),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.swatch.shade900),
          borderRadius: BorderRadius.circular(12.r),
        ),
        fillColor: Colors.white,
        filled: true,
        suffixIcon: !widget.isPassword
            ? const SizedBox()
            : IconButton(
                icon:
                    Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
                padding: EdgeInsets.all(26.r),
                onPressed: () => setState(() => _isObscure = !_isObscure),
              ),
        contentPadding: EdgeInsets.symmetric(vertical: 24.r, horizontal: 26.r),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.secondary),
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }
}
