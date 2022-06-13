import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/models/request.dart';
import 'package:blood_source/ui/shared/widgets/app_button.dart';
import 'package:blood_source/ui/shared/widgets/profile/blood_group_widget.dart';
import 'package:blood_source/ui/views/request_details/request_details_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

class RequestMapPanel extends ViewModelWidget<RequestDetailsViewModel> {
  const RequestMapPanel({
    Key? key,
    required this.controller,
    required this.request,
  }) : super(key: key);

  final ScrollController controller;
  final Request request;

  @override
  Widget build(BuildContext context, RequestDetailsViewModel viewModel) {
    bool compatible = viewModel.compatible;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.r, horizontal: 18.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              height: 4.h,
              width: 0.2.sw,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(30.r),
              ),
            ),
          ),
          12.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: viewModel.goToRecipientProfile,
                child: CircleAvatar(
                  radius: 0.09.sw,
                  foregroundColor: AppColors.primary,
                  foregroundImage: NetworkImage(request.user.avatar),
                ),
              ),
              20.horizontalSpace,
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    request.user.name,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  4.verticalSpace,
                  Text(
                    'City: ${viewModel.recipient!.city!}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontStyle: FontStyle.italic,
                      color: Colors.black54,
                    ),
                  ),
                  4.verticalSpace,
                  Text(
                    'Age: ${viewModel.recipient!.age!}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontStyle: FontStyle.italic,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
          20.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BloodGroupWidget(
                bloodGroup: viewModel.user!.bloodGroup!,
                type: BGWidgetType.complex,
                compatible: compatible,
              ),
              10.horizontalSpace,
              const Icon(Icons.chevron_right, color: AppColors.primary),
              10.horizontalSpace,
              BloodGroupWidget(
                bloodGroup: request.bloodGroup,
                type: BGWidgetType.complex,
              ),
            ],
          ),
          14.verticalSpace,
          compatible
              ? const SizedBox()
              : const Text(
                  'Not Compatible',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                    fontStyle: FontStyle.italic,
                  ),
                ),
          compatible ? 26.verticalSpace : 20.verticalSpace,
          AppButton(onTap: compatible ? () {} : null, text: 'Donate Blood')
        ],
      ),
    );
  }
}
