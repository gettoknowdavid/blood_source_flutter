import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/app/app.router.dart';
import 'package:blood_source/models/blood_source_user.dart';
import 'package:blood_source/models/request.dart';
import 'package:blood_source/services/store_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:logger/logger.dart';

class DonorViewModel extends ReactiveViewModel with ReactiveServiceMixin {
  DonorViewModel() {
    listenToReactiveValues([_donors]);
  }

  final Logger _logger = Logger();

  final StoreService _storeService = locator<StoreService>();
  final NavigationService _navService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();

  final ReactiveValue<List<BloodSourceUser>> _donors =
      ReactiveValue<List<BloodSourceUser>>([]);
  List<BloodSourceUser> get donors => _donors.value;

  BloodSourceUser? get user => _storeService.bloodUser;

  Request? get request => _storeService.request;

  void goToDonorDetails(BloodSourceUser donor) {
    _navService.navigateTo(
      Routes.donorDetailsView,
      arguments: DonorDetailsViewArguments(donor: donor),
    );
  }

  Future<void> init(Request req, bool isCompatible) async {
    setBusy(true);

    if (isCompatible) {
      final result = await _storeService.getCompatibleDonors(req);
      _donors.value = result.donors!;
      setBusy(false);
    } else {
      final result = await _storeService.getDonors();
      _donors.value = result.donors!;
      setBusy(false);
    }
  }

  Future getDonors() async {
    final result = await _storeService.getDonors();
    _donors.value = result.donors!;
  }

  // Future longUpdateStuff() async {
  //   await runBusyFuture(getDonors());
  // }

  Future addRequest(Request request) async {
    _logger.i(request);
    await _storeService.addRequest(request);
    _dialogService
        .showDialog(
          title: 'Successfully Added',
          description: 'Your blood request has been made.',
        )
        .then((value) => _navService.popRepeated(2));
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_storeService];
}
