import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/models/dashboard_button_model.dart';
import 'package:blood_source/models/user-type.dart';
import 'package:blood_source/services/auth_service.dart';
import 'package:blood_source/services/store_service.dart';
import 'package:blood_source/models/blood_source_user.dart';
import 'package:stacked/stacked.dart';

class DashboardViewModel extends ReactiveViewModel with ReactiveServiceMixin {
  Future longUpdateStuff() async {
    var result = await runBusyFuture(getList());
    _buttonList.value = result;
  }

  Future<void> init() async {}

  final ReactiveValue<List<DashboardButtonModel>> _buttonList =
      ReactiveValue<List<DashboardButtonModel>>(donorButtonList);
  List<DashboardButtonModel> get buttonList => _buttonList.value;

  final AuthService _authService = locator<AuthService>();
  String get displayName => _authService.currentUser!.displayName!;

  final StoreService _storeService = locator<StoreService>();
  BloodSourceUser? get user => _storeService.bloodUser!;

  String get firstName => displayName.toString().split(" ").first;

  Future<List<DashboardButtonModel>> getList() async {
    if (user != null) {
      switch (user!.userType) {
        case UserType.donor:
          _buttonList.value = donorButtonList;
          break;
        case UserType.recipient:
          _buttonList.value = recipientButtonList;
          break;
        default:
          _buttonList.value = donorButtonList;
      }
    }
    return _buttonList.value;
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_storeService];
}
