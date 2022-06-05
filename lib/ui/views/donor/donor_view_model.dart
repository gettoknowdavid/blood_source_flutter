import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/app/app.router.dart';
import 'package:blood_source/models/blood_source_user.dart';
import 'package:blood_source/models/request.dart';
import 'package:blood_source/services/store_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DonorViewModel extends StreamViewModel<QuerySnapshot<BloodSourceUser?>> {
  final StoreService _storeService = locator<StoreService>();
  final NavigationService _navService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();

  Request? get request => _storeService.request;

  bool compatible = true;

  void goToDonorDetails(BloodSourceUser donor) {
    _navService.navigateTo(
      Routes.donorDetailsView,
      arguments: DonorDetailsViewArguments(donor: donor),
    );
  }

  void goToDonorProfile(BloodSourceUser donor) {
    _navService.navigateTo(
      Routes.profileView,
      arguments: ProfileViewArguments(user: donor, isFromRoute: true),
    );
  }

  Future<void> init() async {}

  void onChangeCompatible() {
    compatible = !compatible;
    notifyListeners();
    notifySourceChanged();
  }

  Future addRequest(Request request) async {
    await _storeService.addRequest(request);
    _dialogService
        .showDialog(
          title: 'Successfully Added',
          description: 'Your blood request has been made.',
        )
        .then((value) => _navService.popRepeated(1));
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_storeService];

  @override
  Stream<QuerySnapshot<BloodSourceUser?>> get stream => compatible
      ? _storeService.getCompatibleDonors(request!)
      : _storeService.getDonors();
}
