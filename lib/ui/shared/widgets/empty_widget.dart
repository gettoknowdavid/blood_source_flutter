import 'package:blood_source/common/image_resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(18.0).r,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImageResources.empty),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'It\'s lonely here. It seems you haven\'t made any requests yet.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.r,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            60.verticalSpace,
          ],
        ),
      ),
    );
  }
}
