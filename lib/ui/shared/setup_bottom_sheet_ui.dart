import 'package:blood_source/app/app.locator.dart';
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
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    hintText: 'Date',
                    readOnly: true,
                    controller: viewModel.dateController,
                    onTap: () async => viewModel.setEventDate(context),
                  ),
                ),
                10.horizontalSpace,
                Expanded(
                  child: AppTextField(
                    hintText: 'Time',
                    readOnly: true,
                    controller: viewModel.timeController,
                    onTap: () async => viewModel.setEventTime(context),
                  ),
                ),
              ],
            ),
            24.verticalSpace,
            AppButton(
              text: 'Add Event',
              onTap: () async {
                completer(SheetResponse(confirmed: true));
                await viewModel.createNewEvent();
              },
            ),
          ],
        ),
      ),
    );
  }
}
