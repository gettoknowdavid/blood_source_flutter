import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/common/image_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked_services/stacked_services.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NavigationService navService = locator<NavigationService>();

    return Padding(
      padding: EdgeInsets.all(20.r),
      child: GestureDetector(
        onTap: () => navService.back(),
        child: const ImageIcon(
          AssetImage(ImageResources.leftArrow),
          color: Colors.white,
        ),
      ),
    );
  }
}
