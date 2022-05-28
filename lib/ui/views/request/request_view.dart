import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/common/image_resources.dart';
import 'package:blood_source/ui/shared/widgets/app_back_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './request_view_model.dart';

class RequestView extends StatelessWidget {
  const RequestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RequestViewModel>.reactive(
      viewModelBuilder: () => RequestViewModel(),
      onModelReady: (RequestViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        RequestViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.swatch.shade700,
            leading: const AppBackButton(),
            centerTitle: true,
            elevation: 0,
            title: Text(
              'Request Blood',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.r,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(4, 20, 4, 0).r,
                    height: 0.35.sh,
                    width: 1.sw,
                    decoration: BoxDecoration(
                      color: AppColors.swatch.shade700,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40.r),
                      ),
                    ),
                    child: Image.asset(ImageResources.bloodDonation),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
