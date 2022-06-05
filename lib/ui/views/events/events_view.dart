import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/models/event.dart';
import 'package:blood_source/ui/shared/widgets/empty_widget.dart';
import 'package:blood_source/ui/shared/widgets/loading_indicator.dart';
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
        if (model.isBusy || !model.dataReady) {
          return const LoadingIndicator();
        }

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
          body: model.data!.docs.isEmpty
              ? const EmptyWidget(
                  message: 'It\'s lonely here. It seems there are no events.',
                )
              : SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        20.verticalSpace,
                        Text(
                          'You have ${model.eventCount} new ${model.eventCount > 1 ? "events" : "event"}.',
                        ),
                        20.verticalSpace,
                        ListView.builder(
                          itemCount: model.data!.docs.length,
                          primary: false,
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(horizontal: 18.r),
                          itemBuilder: (context, i) {
                            final event = model.data!.docs[i].data()! as Event;
                            return EventItem(event: event);
                          },
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

class EventItem extends ViewModelWidget<EventsViewModel> {
  const EventItem({Key? key, required this.event}) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context, EventsViewModel viewModel) {
    return GestureDetector(
      // onTap: () => viewModel.editEvent(event),
      child: Stack(
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
                  title: 'Desc',
                  subtitle: event.description,
                ),
                16.verticalSpace,
                EventDetailWidget(
                  title: 'Place',
                  subtitle: event.location,
                ),
                8.verticalSpace,
                EventDetailWidget(
                  title: 'Date',
                  subtitle: dateFormatter(
                    event.date.toIso8601String(),
                  ),
                ),
                8.verticalSpace,
                EventDetailWidget(
                  title: 'Time',
                  subtitle: event.time,
                ),
              ],
            ),
          ),
          Positioned(
            right: 0.r,
            top: 0.r,
            child: IconButton(
              onPressed: () => viewModel.deleteEvent(event),
              icon: const Icon(PhosphorIcons.trash, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

class EventDetailWidget extends StatelessWidget {
  const EventDetailWidget({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 35.w,
          child: Text(
            "$title:",
            style: TextStyle(fontSize: 12.sp),
          ),
        ),
        10.horizontalSpace,
        Expanded(
          child: Text(
            subtitle,
            style: TextStyle(
              fontSize: 14.sp,
              fontStyle: FontStyle.italic,
              height: 1.3.sp,
            ),
          ),
        ),
      ],
    );
  }
}
