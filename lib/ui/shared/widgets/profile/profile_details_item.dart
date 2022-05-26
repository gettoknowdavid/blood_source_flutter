import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileDetailsItem extends StatelessWidget {
  const ProfileDetailsItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.value,
  }) : super(key: key);
  final Widget icon;
  final String title;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 0,
      leading: icon,
      title: Text(title, style: TextStyle(fontSize: 16.sp)),
      trailing: Text(
        value == null ? 'Not set yet' : value!,
        style: TextStyle(fontSize: 14.sp),
      ),
    );
  }
}
