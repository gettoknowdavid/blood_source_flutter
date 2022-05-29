import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/services/store_service.dart';
import 'package:stacked/stacked.dart';

class RequestListViewModel extends ReactiveViewModel {
  final StoreService _storeService = locator<StoreService>();

  Future<void> init() async {}

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_storeService];
}
