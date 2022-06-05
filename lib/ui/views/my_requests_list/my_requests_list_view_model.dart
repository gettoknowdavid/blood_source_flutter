import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/models/request.dart';
import 'package:blood_source/services/store_service.dart';
import 'package:stacked/stacked.dart';

class MyRequestsListViewModel extends ReactiveViewModel {
  final StoreService _storeService = locator<StoreService>();

  // List<Request>? get requests => _storeService.requests;

  final ReactiveValue<List<Request>?> _requests =
      ReactiveValue<List<Request>?>([]);
  List<Request>? get myRequests => _requests.value;

  Future<void> init() async {
    await longUpdateStuff();
  }

  Future longUpdateStuff() async {
    var result = await runBusyFuture(getRequests());
    return result;
  }

  Future<List<Request>?> getRequests() async {
    final result = await _storeService.getMyRequests();
    if (result.isRequestsEmpty) {
      return [];
    } else {
      _requests.value = result.requests!;
      return _requests.value;
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_storeService];
}
