import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/models/request.dart';
import 'package:blood_source/services/request_service.dart';
import 'package:stacked/stacked.dart';

class MyRequestsListViewModel extends ReactiveViewModel
    with ReactiveServiceMixin {
  MyRequestsListViewModel() {
    listenToReactiveValues([_requests]);
  }
  final RequestService _requestService = locator<RequestService>();

  final ReactiveValue<List<Request>?> _requests =
      ReactiveValue<List<Request>?>([]);
  List<Request>? get myRequests => _requests.value;

  Future<void> init() async {
    setBusy(true);
    await getMyRequests();
    setBusy(false);
  }

  Future getMyRequests() async {
    final result = await _requestService.getMyRequests();
    if (result.isRequestsEmpty) {
      _requests.value = [];
    } else {
      _requests.value = result.requests!;
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_requestService];
}
