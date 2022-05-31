import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/models/blood_source_user.dart';
import 'package:blood_source/models/request.dart';
import 'package:blood_source/ui/shared/widgets/app_back_button.dart';
import 'package:blood_source/ui/shared/widgets/app_button.dart';
import 'package:blood_source/ui/shared/widgets/loading_indicator.dart';
import 'package:blood_source/ui/shared/widgets/profile/blood_group_widget.dart';
import 'package:blood_source/ui/shared/widgets/request_details/map_panel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './request_details_view_model.dart';

class RequestDetailsView extends StatelessWidget {
  const RequestDetailsView({Key? key, required this.request}) : super(key: key);
  final Request request;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RequestDetailsViewModel>.reactive(
      viewModelBuilder: () => RequestDetailsViewModel(),
      onModelReady: (model) async => await model.init(request),
      builder: (context, model, Widget? child) {
        if (model.isBusy) {
          return const LoadingIndicator();
        }

        return Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: Container(
              margin: EdgeInsets.only(left: 8.r, top: 8.r),
              child: const AppBackButton(color: AppColors.primary),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
          body: Stack(
            clipBehavior: Clip.none,
            fit: StackFit.loose,
            children: [
              SlidingUpPanel(
                body: OSMFlutter(
                  controller: model.controller,
                  trackMyPosition: false,
                  initZoom: 17,
                  minZoomLevel: 8,
                  maxZoomLevel: 18,
                  stepZoom: 1.0,
                  userLocationMarker: UserLocationMaker(
                    personMarker: MarkerIcon(
                      icon: Icon(
                        Icons.location_history_rounded,
                        color: Colors.red,
                        size: 48.sp,
                      ),
                    ),
                    directionArrowMarker: MarkerIcon(
                      icon: Icon(Icons.double_arrow, size: 48.sp),
                    ),
                  ),
                ),
                minHeight: 0.17.sh,
                maxHeight: 0.54.sh,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
                panelBuilder: (c) => MapPanel(controller: c, request: request),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({
    Key? key,
    required this.request,
    required this.user,
  }) : super(key: key);

  final Request request;
  final BloodSourceUser user;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(18, 8, 18, 32).r,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
              radius: 0.18 * 1.sw,
              backgroundColor: AppColors.swatch.shade100,
              child: CircleAvatar(
                radius: 0.17 * 1.sw,
                foregroundColor: AppColors.primary,
                foregroundImage: NetworkImage(request.user.avatar),
              ),
            ),
            20.verticalSpace,
            Text(
              user.name!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            10.verticalSpace,
            Text(
              user.city!,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.sp),
            ),
            10.verticalSpace,
            !request.showContactInfo
                ? const SizedBox()
                : Text(
                    user.phone!,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.sp),
                  ),
            20.verticalSpace,
            BloodGroupWidget(
              bloodGroup: request.bloodGroup,
              type: BGWidgetType.complex,
            ),
            30.verticalSpace,
            AppButton(onTap: () {}, text: 'Donate Blood'),
          ],
        ),
      ),
    );
  }
}
