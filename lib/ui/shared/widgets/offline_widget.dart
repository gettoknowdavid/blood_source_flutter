import 'package:blood_source/common/image_resources.dart';
import 'package:blood_source/ui/shared/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OfflineWidget extends StatelessWidget {
  const OfflineWidget({
    Key? key,
    this.onTap,
    this.addPadding = false,
  }) : super(key: key);

  final void Function()? onTap;
  final bool addPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          addPadding ? EdgeInsets.symmetric(horizontal: 18.r) : EdgeInsets.zero,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(ImageResources.offline),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'It seems you\'re disconnected. \n Check your network connection and let\'s try again.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.r,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            60.verticalSpace,
            AppButton(onTap: onTap, text: 'Reload'),
          ],
        ),
      ),
    );
  }
}
