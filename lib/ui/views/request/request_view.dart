import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/common/image_resources.dart';
import 'package:blood_source/models/blood_group.dart';
import 'package:blood_source/ui/shared/widgets/app_back_button.dart';
import 'package:blood_source/ui/shared/widgets/app_button.dart';
import 'package:blood_source/ui/shared/widgets/loading_indicator.dart';
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
      onModelReady: (model) async => await model.init(),
      builder: (context, model, Widget? child) {
        if (model.isBusy) {
          return const LoadingIndicator();
        }

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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(4, 20, 4, 0).r,
                    height: 0.3.sh,
                    width: 1.sw,
                    decoration: BoxDecoration(
                      color: AppColors.swatch.shade700,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40.r),
                      ),
                    ),
                    child: Image.asset(ImageResources.bloodDonation),
                  ),
                  18.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18).r,
                    child: Text(
                      'Select Blood group',
                      style: TextStyle(
                        fontSize: 18.r,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  5.verticalSpace,
                  GridView.builder(
                    primary: false,
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 18.r),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 9 / 11,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 10.h,
                    ),
                    itemCount: model.bgList.length,
                    itemBuilder: (BuildContext context, i) {
                      final isSelected = model.bloodGroup == model.bgList[i];
                      return GestureDetector(
                        onTap: () => model.onBGChanged(model.bgList[i]),
                        child: Opacity(
                          opacity: isSelected ? 1 : 0.5,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10.r),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(14.r),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.swatch.shade500
                                    : Colors.black26,
                                width: 2.w,
                              ),
                            ),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    height: 70.h,
                                    child: Image.asset(
                                      'assets/images/red-blood.png',
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0.r,
                                  right: 5.r,
                                  child: Container(
                                    height: 42.h,
                                    width: 42.h,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF464A57),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      model.bgList[i].value.name,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  5.verticalSpace,
                  CheckboxListTile(
                    value: model.showContact,
                    onChanged: (value) => model.onShowPhoneChanged(value),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0).r,
                    checkboxShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    title: Text(
                      'Make my contact information visible',
                      style: TextStyle(
                        fontSize: 16.r,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  CheckboxListTile(
                    value: model.compatible,
                    onChanged: (value) => model.onCompatibilityChanged(value),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0).r,
                    checkboxShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    title: Text(
                      'Show only compatible donors',
                      style: TextStyle(
                        fontSize: 16.r,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  10.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0).r,
                    child: AppButton(
                      onTap: model.searchDonations,
                      text: 'Search',
                    ),
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
