import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/models/request.dart';
import 'package:blood_source/services/store_service.dart';
import 'package:stacked/stacked.dart';

class RequestListViewModel extends ReactiveViewModel {
  final StoreService _storeService = locator<StoreService>();

  Future<void> init() async {
    await longUpdateStuff();
  }

  Future longUpdateStuff() async {
    var result = await runBusyFuture(getRequests());
    return result;
  }

  Future<List<Request>?> getRequests() async {
    final result = await _storeService.getRequests();
    return result.requests;
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_storeService];
}
