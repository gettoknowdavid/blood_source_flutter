import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/app/app.router.dart';
import 'package:blood_source/models/dashboard_button_model.dart';
import 'package:blood_source/models/request.dart';
import 'package:blood_source/models/request_user.dart';
import 'package:blood_source/models/user-type.dart';
import 'package:blood_source/models/user_location.dart';
import 'package:blood_source/services/auth_service.dart';
import 'package:blood_source/services/request_service.dart';
import 'package:blood_source/services/store_service.dart';
import 'package:blood_source/models/blood_source_user.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:uuid/uuid.dart';

class DashboardViewModel extends ReactiveViewModel with ReactiveServiceMixin {
  DashboardViewModel() {
    listenToReactiveValues([_buttonList]);
  }

  Future<void> init() async {
    setBusy(true);
    final result = await getList();
    _buttonList.value = result;
    setBusy(false);
  }

  final AuthService _authService = locator<AuthService>();
  final RequestService _requestService = locator<RequestService>();
  final StoreService _storeService = locator<StoreService>();
  final NavigationService _navService = locator<NavigationService>();

  final ReactiveValue<List<DashboardButtonModel>> _buttonList =
      ReactiveValue<List<DashboardButtonModel>>(donorButtonList);
  List<DashboardButtonModel> get buttonList => _buttonList.value;

  String get displayName => _authService.currentUser!.displayName!;

  BloodSourceUser get user => _storeService.bsUser!;

  String get firstName => displayName.toString().split(" ").first;

  Future<List<DashboardButtonModel>> getList() async {
    switch (user.userType) {
      case UserType.donor:
        _buttonList.value = donorButtonList;
        break;
      case UserType.recipient:
        _buttonList.value = recipientButtonList;
        break;
      default:
        _buttonList.value = donorButtonList;
    }
    return _buttonList.value;
  }

  void goToDonors() async {
    final Request request = Request(
      uid: const Uuid().v4(),
      bloodGroup: user.bloodGroup!,
      requestGranted: false,
      timeAdded: DateTime.now(),
      user: RequestUser(
        uid: user.uid!,
        name: user.name!,
        avatar: user.avatar!,
        location: UserLocation(
          user.location!.latitude,
          user.location!.longitude,
        ),
      ),
    );

    await _requestService.setRequest(request);

    _navService.navigateTo(
      Routes.donorView,
      arguments: DonorViewArguments(request: request, fromRequestView: false),
    );
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_storeService];
}
