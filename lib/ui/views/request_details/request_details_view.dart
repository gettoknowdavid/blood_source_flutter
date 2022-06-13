import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/models/request.dart';
import 'package:blood_source/ui/shared/widgets/app_back_button.dart';
import 'package:blood_source/ui/shared/widgets/loading_indicator.dart';
import 'package:blood_source/ui/shared/widgets/offline_widget.dart';
import 'package:blood_source/ui/shared/widgets/request_details/request_map_panel_widget.dart';
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
        if (model.isBusy || model.isConnected == null) {
          return const LoadingIndicator();
        }

        return Scaffold(
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
          body: !model.isConnected!
              ? OfflineWidget(onTap: model.checkConnectivity, addPadding: true)
              : SlidingUpPanel(
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
                  maxHeight: 0.54.sh,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30.r),
                  ),
                  panelBuilder: (c) =>
                      RequestMapPanel(controller: c, request: request),
                ),
        );
      },
    );
  }
}
