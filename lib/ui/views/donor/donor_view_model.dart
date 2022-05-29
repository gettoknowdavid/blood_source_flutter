import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/models/blood_source_user.dart';
import 'package:blood_source/models/request.dart';
import 'package:blood_source/services/store_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DonorViewModel extends ReactiveViewModel with ReactiveServiceMixin {
  DonorViewModel() {
    listenToReactiveValues([_donors, _donorCount]);
  }

  final StoreService _storeService = locator<StoreService>();
  final NavigationService _navService = locator<NavigationService>();

  final ReactiveValue<List<BloodSourceUser>> _donors =
      ReactiveValue<List<BloodSourceUser>>([]);
  List<BloodSourceUser> get donors => _donors.value;

  final ReactiveValue<int> _donorCount = ReactiveValue<int>(0);
  int get donorCount => _donorCount.value;

  Future<void> init() async {
    getDonors();
    getDonorCountString();
  }

  String getDonorCountString() {
    if (_donorCount.value > 1) {
      return '${_donorCount.value} donor are available';
    }

    if (_donorCount.value == 1) {
      return '${_donorCount.value} donors are available';
    }

    return 'No donors available';
  }

  List<BloodSourceUser> getDonors() {
    FirebaseFirestore.instance.collection("donors").snapshots().listen((event) {
      for (var doc in event.docs) {
        _donors.value.add(BloodSourceUser.fromFirestore(doc, null));
      }
      _donorCount.value = _donors.value.length;
    });

    return _donors.value;
  }

  Future addRequest(Request request) async {
    await _storeService.addRequest(request);
// _navService.clearTillFirstAndShow()
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_storeService];
}
