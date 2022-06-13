import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/ui/shared/widgets/app_back_button.dart';
import 'package:blood_source/ui/shared/widgets/donor_details/donor_map_panel_widget.dart';
import 'package:blood_source/ui/shared/widgets/loading_indicator.dart';
import 'package:blood_source/ui/shared/widgets/offline_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:stacked/stacked.dart';
import 'package:blood_source/models/blood_source_user.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './donor_details_view_model.dart';

class DonorDetailsView extends StatelessWidget {
  const DonorDetailsView({Key? key, required this.donor}) : super(key: key);
  final BloodSourceUser donor;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DonorDetailsViewModel>.reactive(
      viewModelBuilder: () => DonorDetailsViewModel(),
      onModelReady: (model) async => await model.init(),
      builder: (context, model, Widget? child) {
        if (model.isBusy || model.isConnected == null) {
          return const LoadingIndicator();
        }

        if (!model.isConnected!) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: const AppBackButton(color: AppColors.primary),
            ),
            body: OfflineWidget(
              onTap: model.checkConnectivity,
              addPadding: true,
            ),
          );
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
                minHeight: 120.h,
                maxHeight: 0.52.sh,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
                panelBuilder: (c) => DonorMapPanel(controller: c, donor: donor),
              ),
            ],
          ),
        );
      },
    );
  }
}
