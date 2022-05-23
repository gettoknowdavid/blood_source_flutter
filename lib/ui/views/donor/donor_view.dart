import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/common/app_icons.dart';
import 'package:blood_source/ui/shared/widgets/app_back_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './donor_view_model.dart';

class DonorView extends StatelessWidget {
  const DonorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DonorViewModel>.reactive(
      viewModelBuilder: () => DonorViewModel(),
      onModelReady: (model) async => await model.init(),
      builder: (context, model, Widget? child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: const AppBackButton(color: AppColors.primaryDark),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    height: 160.h,
                    width: 107.w,
                    padding: EdgeInsets.symmetric(vertical: 18.r),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.03),
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(
                        color: AppColors.swatch.shade500,
                        width: 2.w,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                height: 65.h,
                                width: 46.w,
                                child:
                                    Image.asset('assets/images/red-blood.png'),
                              ),
                            ),
                            Positioned(
                              left: 48.w,
                              top: 4.h,
                              child: Container(
                                alignment: Alignment.center,
                                height: 32.h,
                                width: 32.h,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF464A57),
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white),
                                ),
                                child: Text(
                                  'A+',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        6.verticalSpace,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.r),
                          child: Text(
                            'A Positive (A+)',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              height: 1.4.h,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                20.verticalSpace,
                const Text('25 Donors are available'),
                20.verticalSpace,
                ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 26.r),
                  children: [
                    DonorListItem(),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class DonorListItem extends StatelessWidget {
  const DonorListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      width: 1.sw,
      padding: EdgeInsets.symmetric(
        vertical: 10.r,
        horizontal: 16.r,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 18,
            spreadRadius: 0,
            color: Colors.black12,
            offset: Offset(0, 10.h),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 25.w,
            backgroundColor: AppColors.swatch.shade400,
          ),
          10.horizontalSpace,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Jaber Khalaf',
                style: TextStyle(fontSize: 17.sp),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_pin,
                    color: AppColors.secondary,
                    size: 18.sp,
                  ),
                  Text(
                    'Tulkarm',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Container(
            height: 46.h,
            width: 46.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: const Color(0xFF826DEE),
            ),
            child: Text(
              '5km',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
