import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/models/event.dart';
import 'package:blood_source/ui/shared/widgets/empty_widget.dart';
import 'package:blood_source/ui/shared/widgets/loading_indicator.dart';
import 'package:blood_source/ui/shared/widgets/offline_widget.dart';
import 'package:blood_source/utils/date_formatter.dart';
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
      onModelReady: (model) async => await model.init(),
      builder: (context, model, Widget? child) {
        if (model.isBusy || model.isConnected == null || model.data == null) {
          return const LoadingIndicator();
        }

        List<Event> events = model.data!.events!;

        return Scaffold(
          appBar: AppBar(title: const Text('Events')),
          floatingActionButton: Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColors.primary),
            ),
            child: IconButton(
              onPressed: () => model.openBottomSheet(),
              color: Colors.white,
              icon: const Icon(PhosphorIcons.plusBold),
            ),
          ),
          body: !model.isConnected!
              ? OfflineWidget(onTap: model.checkConnectivity, addPadding: true)
              : Container(
                  child: events.isEmpty
                      ? const EmptyWidget(
                          message: 'It\'s lonely here. There are no events.',
                        )
                      : RefreshIndicator(
                          onRefresh: model.initialise,
                          child: ListView.builder(
                            itemCount: events.length,
                            padding: const EdgeInsets.all(18).r,
                            itemBuilder: (context, i) {
                              return EventItem(event: events[i]);
                            },
                          ),
                        ),
                ),
        );
      },
    );
  }
}

class EventItem extends ViewModelWidget<EventsViewModel> {
  const EventItem({Key? key, required this.event}) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context, EventsViewModel viewModel) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(18).r,
          margin: const EdgeInsets.only(bottom: 18).r,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                blurRadius: 16.r,
                color: AppColors.swatch.shade100.withOpacity(0.06),
                offset: Offset(0.w, 20.h),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                event.title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
              ),
              4.verticalSpace,
              Text(
                viewModel.getCreator(event),
                style: TextStyle(
                  fontSize: 12.sp,
                  fontStyle: FontStyle.italic,
                  height: 1.3.sp,
                ),
              ),
              16.verticalSpace,
              EventDetailWidget(
                icon: PhosphorIcons.note,
                subtitle: event.description,
              ),
              16.verticalSpace,
              EventDetailWidget(
                icon: PhosphorIcons.mapPin,
                subtitle: event.location,
              ),
              16.verticalSpace,
              EventDetailWidget(
                icon: PhosphorIcons.calendar,
                subtitle: dateFormatter(
                  event.date.toIso8601String(),
                ),
              ),
              16.verticalSpace,
              EventDetailWidget(
                icon: PhosphorIcons.clock,
                subtitle: event.time,
              ),
            ],
          ),
        ),
        Positioned(
          right: 0.r,
          top: 0.r,
          child: !viewModel.isEventBelongToUser(event)
              ? const SizedBox()
              : IconButton(
                  onPressed: () => viewModel.deleteEvent(event),
                  icon: const Icon(PhosphorIcons.trash, color: Colors.red),
                ),
        ),
      ],
    );
  }
}

class EventDetailWidget extends StatelessWidget {
  const EventDetailWidget({
    Key? key,
    required this.icon,
    required this.subtitle,
  }) : super(key: key);

  final IconData icon;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: AppColors.secondary,
          size: 18.sp,
        ),
        10.horizontalSpace,
        Expanded(
          child: Text(
            subtitle,
            style: TextStyle(
              fontSize: 14.sp,
              fontStyle: FontStyle.italic,
              height: 1.1.sp,
            ),
          ),
        ),
      ],
    );
  }
}
