import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/app/app.router.dart';
import 'package:blood_source/models/request.dart';
import 'package:blood_source/services/request_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RequestListViewModel extends StreamViewModel<QuerySnapshot<Request?>> {
  final NavigationService _navService = locator<NavigationService>();
  final RequestService _requestService = locator<RequestService>();

  bool compatible = true;

  goToDetails(Request req) {
    _navService.navigateTo(
      Routes.requestDetailsView,
      arguments: RequestDetailsViewArguments(request: req),
    );
  }

  Future<void> init() async {}

  void onCompatibilityChanged() {
    compatible = !compatible;
    notifyListeners();
    notifySourceChanged();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_requestService];

  @override
  Stream<QuerySnapshot<Request?>> get stream => compatible
      ? _requestService.getCompatibleRequests()
      : _requestService.getRequests();
}
