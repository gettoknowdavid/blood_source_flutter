import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/utils/bottom_sheet_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class EventsViewModel extends BaseViewModel {
  Future<void> init() async {}

  final NavigationService _navService = locator<NavigationService>();
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();

  void openBottomSheet() =>
      _bottomSheetService.showCustomSheet(variant: BottomSheetType.createEvent);

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  DateTime? timeAdded;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    super.dispose();
  }
}
