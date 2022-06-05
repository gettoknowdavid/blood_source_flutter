import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/app/app.router.dart';
import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/ui/shared/widgets/app_button.dart';
import 'package:blood_source/ui/shared/widgets/app_textfield.dart';
import 'package:blood_source/ui/views/events/events_view_model.dart';
import 'package:blood_source/utils/bottom_sheet_type.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void setupBottomSheetUi() {
  final BottomSheetService bottomSheetService = locator<BottomSheetService>();

  final builders = {
    BottomSheetType.floating: (context, sheetRequest, completer) =>
        _FloatingBoxBottomSheet(request: sheetRequest, completer: completer),
    BottomSheetType.createEvent: (context, sheetRequest, completer) =>
        _CreateEventBottomSheet(request: sheetRequest, completer: completer)
  };

  bottomSheetService.setCustomSheetBuilders(builders);
}

class _CreateEventBottomSheet extends StatelessWidget {
  const _CreateEventBottomSheet({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  final SheetRequest request;
  final Function(SheetResponse) completer;

  @override
  Widget build(BuildContext context) {
    final viewModel = locator<EventsViewModel>();
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      height: 1.sh,
      width: 1.sw,
      padding: const EdgeInsets.all(20).r,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add a new Event',
              style: TextStyle(
                fontSize: 18.r,
                fontWeight: FontWeight.w600,
              ),
            ),
            16.verticalSpace,
            AppTextField(
              controller: viewModel.titleController,
              hintText: 'Event Title',
            ),
            10.verticalSpace,
            AppTextField(
              controller: viewModel.descriptionController,
              hintText: 'Description',
              maxLines: 2,
            ),
            10.verticalSpace,
            AppTextField(
              controller: viewModel.locationController,
              hintText: 'Location or Address',
            ),
            10.verticalSpace,
            AppTextField(
              controller: viewModel.locationController,
              hintText: 'Date and Time',
            ),
            24.verticalSpace,
            AppButton(onTap: () {}, text: 'Add Event'),
          ],
        ),
      ),
    );
  }
}

class _FloatingBoxBottomSheet extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;

  const _FloatingBoxBottomSheet({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    NavigationService navigationService = locator<NavigationService>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  completer(SheetResponse(confirmed: true));
                },
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColorLight,
                  child: Icon(Icons.close, size: 22.sp),
                ),
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 25, right: 25, left: 25).r,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () {
                  completer(SheetResponse(confirmed: true));
                  navigationService.navigateTo(Routes.requestView);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 15,
                  ).r,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.primary,
                        child: Icon(
                          Icons.mic,
                          color: Theme.of(context).primaryColor,
                          size: 22.sp,
                        ),
                      ),
                      3.horizontalSpace,
                      Text(
                        'Start broadcast now',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16.sp,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Divider(height: 0),
              TextButton(
                onPressed: () {
                  completer(SheetResponse(confirmed: true));

                  navigationService.navigateTo(Routes.requestView);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 15,
                  ).r,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.primary,
                        child: Icon(
                          Icons.punch_clock_rounded,
                          color: Theme.of(context).primaryColor,
                          size: 22.sp,
                        ),
                      ),
                      3.horizontalSpace,
                      Text(
                        'Schedule for later',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16.sp,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
