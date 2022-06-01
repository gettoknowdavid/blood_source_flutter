import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/app/app.router.dart';
import 'package:blood_source/models/request.dart';
import 'package:blood_source/services/store_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RequestListViewModel extends ReactiveViewModel {
  final NavigationService _navService = locator<NavigationService>();
  final StoreService _storeService = locator<StoreService>();

  final ReactiveValue<List<Request>?> _requests =
      ReactiveValue<List<Request>?>([]);
  List<Request>? get requests => _requests.value;

  goToDetails(Request req) {
    _navService.navigateTo(
      Routes.requestDetailsView,
      arguments: RequestDetailsViewArguments(request: req),
    );
  }

  Future<void> init() async {
    await longUpdateStuff();
  }

  Future longUpdateStuff() async {
    var result = await runBusyFuture(getRequests());
    return result;
  }

  Future<List<Request>?> getRequests() async {
    final result = await _storeService.getRequests();
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
