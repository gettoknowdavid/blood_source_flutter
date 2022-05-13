import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DonorFormField extends StatelessWidget {
  const DonorFormField({
    Key? key,
    required this.title,
    required this.content,
    this.showBorder = true,
  }) : super(key: key);

  final String title;
  final Widget content;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: showBorder
              ? const BorderSide(color: Colors.black26)
              : BorderSide.none,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          content,
        ],
      ),
    );
  }
}
