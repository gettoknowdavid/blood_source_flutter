import 'package:blood_source/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Avatar extends StatelessWidget {
  const Avatar({Key? key, this.avatar}) : super(key: key);
  final String? avatar;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 0.18 * 1.sw,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: 0.17 * 1.sw,
        foregroundColor: AppColors.primary,
        child:
            avatar == null ? const Icon(PhosphorIcons.user) : const SizedBox(),
        foregroundImage: avatar != null ? NetworkImage(avatar!) : null,
      ),
    );
  }
}
