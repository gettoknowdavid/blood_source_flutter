import 'package:blood_source/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:blood_source/models/blood_source_user.dart';

class Avatar extends StatelessWidget {
  const Avatar({Key? key, required this.user}) : super(key: key);
  final BloodSourceUser? user;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 0.18 * 1.sw,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: 0.17 * 1.sw,
        foregroundColor: AppColors.primary,
        child: user == null
            ? const Center(child: CircularProgressIndicator())
            : const Icon(Icons.add_a_photo),
        foregroundImage: user != null ? NetworkImage(user!.avatar!) : null,
      ),
    );
  }
}
