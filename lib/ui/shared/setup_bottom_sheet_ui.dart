import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/models/event.dart';
import 'package:blood_source/models/event_creator.dart';
import 'package:blood_source/services/store_service.dart';
import 'package:blood_source/ui/shared/widgets/app_button.dart';
import 'package:blood_source/ui/shared/widgets/app_textfield.dart';
import 'package:blood_source/utils/bottom_sheet_type.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';

void setupBottomSheetUi() {
  final BottomSheetService bottomSheetService = locator<BottomSheetService>();

  final builders = {
    BottomSheetType.createEvent: (context, sheetRequest, completer) =>
        _CreateEventBottomSheet(request: sheetRequest, completer: completer)
  };

  bottomSheetService.setCustomSheetBuilders(builders);
}

class _CreateEventBottomSheet extends StatefulWidget {
  const _CreateEventBottomSheet({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  final SheetRequest request;
  final Function(SheetResponse) completer;

  @override
  State<_CreateEventBottomSheet> createState() =>
      _CreateEventBottomSheetState();
}

class _CreateEventBottomSheetState extends State<_CreateEventBottomSheet> {
  final storeService = locator<StoreService>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  bool formVerified() {
    if (titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        locationController.text.isNotEmpty &&
        dateController.text.isNotEmpty &&
        timeController.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void setEventDate(context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        dateController.text = formattedDate;
      });
    }
  }

  void setEventTime(context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input,
    );

    if (pickedTime != null) {
      String formattedTime = pickedTime.format(context);
      setState(() {
        timeController.text = formattedTime;
      });
    }
  }

  @override
  void initState() {
    titleController.clear();
    descriptionController.clear();
    locationController.clear();
    dateController.clear();
    timeController.clear();
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    dateController.dispose();
    timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      height: 1.sh,
      width: 1.sw,
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0).r,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 10).r,
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
              controller: titleController,
              hintText: 'Event Title',
            ),
            10.verticalSpace,
            AppTextField(
              controller: descriptionController,
              hintText: 'Description',
              maxLines: 2,
            ),
            10.verticalSpace,
            AppTextField(
              controller: locationController,
              hintText: 'Location or Address',
            ),
            10.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    hintText: 'Date',
                    readOnly: true,
                    controller: dateController,
                    onTap: () => setEventDate(context),
                  ),
                ),
                10.horizontalSpace,
                Expanded(
                  child: AppTextField(
                    hintText: 'Time',
                    readOnly: true,
                    controller: timeController,
                    onTap: () => setEventTime(context),
                  ),
                ),
              ],
            ),
            24.verticalSpace,
            AppButton(
              text: 'Add Event',
              onTap: !formVerified()
                  ? null
                  : () async {
                      final _uid = FirebaseAuth.instance.currentUser!.uid;
                      final _r = await storeService.getUser(_uid);

                      final newEvent = Event(
                        uid: const Uuid().v4(),
                        title: titleController.text,
                        description: descriptionController.text,
                        location: locationController.text,
                        date: DateTime.parse(dateController.text),
                        time: timeController.text,
                        timeAdded: DateTime.now(),
                        creator: EventCreator(
                          uid: _uid,
                          name: _r!.bSUser!.name!,
                        ),
                      );

                      widget.completer(SheetResponse(
                        confirmed: true,
                        data: newEvent,
                      ));
                    },
            ),
          ],
        ),
      ),
    );
  }
}
