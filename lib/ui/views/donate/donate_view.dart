import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/ui/shared/widgets/app_back_button.dart';
import 'package:blood_source/ui/shared/widgets/app_text_button.dart';
import 'package:blood_source/ui/shared/widgets/donate/contact_button_item.dart';
import 'package:blood_source/ui/shared/widgets/loading_indicator.dart';
import 'package:blood_source/ui/shared/widgets/offline_widget.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:blood_source/models/blood_source_user.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './donate_view_model.dart';

class DonateView extends StatelessWidget {
  const DonateView({Key? key, required this.donor}) : super(key: key);
  final BloodSourceUser donor;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DonateViewModel>.reactive(
      viewModelBuilder: () => DonateViewModel(),
      onModelReady: (DonateViewModel model) async => await model.init(),
      builder: (context, model, Widget? child) {
        if (model.isBusy || model.isConnected == null) {
          return const LoadingIndicator();
        }

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: const AppBackButton(color: AppColors.primary),
          ),
          body: !model.isConnected!
              ? OfflineWidget(onTap: model.checkConnectivity, addPadding: true)
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      80.verticalSpace,
                      CircleAvatar(
                        radius: 0.17.sw,
                        foregroundImage: NetworkImage(donor.avatar!),
                        child: donor.avatar == null
                            ? const Center(child: Icon(PhosphorIcons.person))
                            : const SizedBox(),
                      ),
                      10.verticalSpace,
                      Text(
                        'Contact ${donor.name}',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      AppTextButton(
                        onTap: () => model.gotToDonorProfile(donor),
                        text: 'View Profile',
                        color: AppColors.primary,
                      ),
                      SizedBox(
                        height: 0.6 * 1.sh,
                        child: GridView.builder(
                          primary: false,
                          padding: EdgeInsets.symmetric(
                            horizontal: 32.w,
                            vertical: 30.h,
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 9 / 11,
                            crossAxisSpacing: 20.h,
                            mainAxisSpacing: 20.h,
                          ),
                          itemCount: model.buttons.length,
                          itemBuilder: (BuildContext context, i) {
                            return ContactButtonItem(
                              model: model.buttons[i],
                              onTap: () => model.getAction(
                                model.buttons[i].contactType,
                                donor,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
