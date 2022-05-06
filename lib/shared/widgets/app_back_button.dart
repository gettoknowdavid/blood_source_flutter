import 'package:blood_source/common/image_resources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.r, vertical: 20.r),
      child: GestureDetector(
        onTap: () => Get.back(),
        child: const ImageIcon(
          AssetImage(ImageResources.letArrow),
          color: Colors.white,
        ),
      ),
    );
  }
}
