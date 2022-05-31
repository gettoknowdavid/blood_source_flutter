import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/models/request.dart';
import 'package:blood_source/services/store_service.dart';
import 'package:stacked/stacked.dart';
import 'package:blood_source/models/blood_source_user.dart';

class RequestDetailsViewModel extends BaseViewModel with ReactiveServiceMixin {
  RequestDetailsViewModel() {
    listenToReactiveValues([_user]);
  }

  final StoreService _storeService = locator<StoreService>();

  final ReactiveValue<BloodSourceUser?> _user =
      ReactiveValue<BloodSourceUser?>(null);
  BloodSourceUser? get user => _user.value;

  Future<void> init(Request req) async {
    setBusy(true);
    final result = await _storeService.getUser(req.user.uid);
    setBusy(false);
    _user.value = result!.bSUser;
    print(user!.name);
  }
}
