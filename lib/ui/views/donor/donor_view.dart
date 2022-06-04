import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/models/request.dart';
import 'package:blood_source/ui/shared/widgets/app_back_button.dart';
import 'package:blood_source/ui/shared/widgets/app_text_button.dart';
import 'package:blood_source/ui/shared/widgets/donor/donor_list_item.dart';
import 'package:blood_source/ui/shared/widgets/empty_widget.dart';
import 'package:blood_source/ui/shared/widgets/loading_indicator.dart';
import 'package:blood_source/ui/shared/widgets/profile/blood_group_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './donor_view_model.dart';

class DonorView extends StatelessWidget {
  const DonorView({Key? key, this.fromRequestView = false, this.request})
      : super(key: key);

  final bool fromRequestView;
  final Request? request;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DonorViewModel>.reactive(
      viewModelBuilder: () => DonorViewModel(),
      onModelReady: (model) async => await model.init(),
      builder: (context, model, Widget? child) {
        if (!model.dataReady || model.isBusy) {
          return const LoadingIndicator();
        }

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: const AppBackButton(color: AppColors.primaryDark),
            backgroundColor: Colors.white,
            elevation: 0,
            actions: [
              AppTextButton(
                onTap: () => model.addRequest(request!),
                text: 'Add Request',
                padding: EdgeInsets.only(right: 18.r),
                fontSize: 16.sp,
                color: AppColors.primaryDark,
              )
            ],
          ),
          body: model.data!.docs.isEmpty
              ? const EmptyWidget()
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BloodGroupWidget(
                        bloodGroup: request!.bloodGroup,
                        type: BGWidgetType.complex,
                      ),
                      20.verticalSpace,
                      // Text(model.getDonorCountString()),
                      20.verticalSpace,
                      ListView.builder(
                        itemCount: model.data!.docs.length,
                        primary: false,
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: 18.r),
                        itemBuilder: (context, i) {
                          final donor = model.data!.docs[i].data()!;
                          return DonorListItem(donor: donor);
                        },
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
