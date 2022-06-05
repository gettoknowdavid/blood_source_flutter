import 'package:blood_source/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './events_view_model.dart';

class EventsView extends StatelessWidget {
  const EventsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EventsViewModel>.reactive(
      viewModelBuilder: () => EventsViewModel(),
      onModelReady: (EventsViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        EventsViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          appBar: AppBar(title: const Text('Events')),
          floatingActionButton: Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColors.primary),
            ),
            child: IconButton(
              onPressed: model.openBottomSheet,
              color: Colors.white,
              icon: const Icon(PhosphorIcons.plusBold),
            ),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  20.verticalSpace,
                  const Text('You have 2 new events'),
                  20.verticalSpace,
                  Container(
                    height: 0.14.sh,
                    width: 1.sw,
                    margin: const EdgeInsets.fromLTRB(18, 0, 18, 18).r,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 20.r,
                            color: Colors.black12,
                            offset: Offset(0.w, 20.h),
                          )
                        ]),
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
