import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileStatWidget extends StatelessWidget {
  const ProfileStatWidget({Key? key, required this.stat, required this.title})
      : super(key: key);
  final int stat;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            '$stat',
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600),
          ),
          Text(
            title,
            style: TextStyle(fontSize: 12.sp, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
