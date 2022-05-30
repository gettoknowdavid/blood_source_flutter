import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/models/blood_source_user.dart';
import 'package:blood_source/models/request.dart';
import 'package:blood_source/services/store_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:logger/logger.dart';

class DonorViewModel extends ReactiveViewModel with ReactiveServiceMixin {
  DonorViewModel() {
    listenToReactiveValues([_donors]);
  }

  final Logger _logger = Logger();

  final StoreService _storeService = locator<StoreService>();
  final NavigationService _navService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();

  final ReactiveValue<List<BloodSourceUser>> _donors =
      ReactiveValue<List<BloodSourceUser>>([]);
  List<BloodSourceUser> get donors => _donors.value;

  BloodSourceUser? get user => _storeService.bloodUser;

  Request? get request => _storeService.request;

  Future<void> init() async {
    await longUpdateStuff();
  }

  // String getDonorCountString() {
  //   if (_donorCount.value > 1) {
  //     return '${_donorCount.value} donor are available';
  //   }

  //   if (_donorCount.value == 1) {
  //     return '${_donorCount.value} donors are available';
  //   }

  //   return 'No donors available';
  // }

  Future getDonors() async {
    // FirebaseFirestore.instance
    //     .collection('users')
    //     .where('uid', isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
    //     .where('bloodGroup', isEqualTo: request!.bloodGroup.value.desc)
    //     .where('userType', isEqualTo: UserType.donor.name)
    //     .snapshots()
    //     .listen((event) {
    //   _donors.value = event.docs
    //       .map((e) => BloodSourceUser.fromFirestore(e, null))
    //       .toList();

    // });

    final result = await _storeService.getDonors();
    _donors.value = result.donors!;
  }

  Future longUpdateStuff() async {
    await runBusyFuture(getDonors());
  }

  Future addRequest(Request request) async {
    _logger.i(request);
    await _storeService.addRequest(request);
    _dialogService
        .showDialog(
          title: 'Successfully Added',
          description: 'Your blood request has been made.',
        )
        .then((value) => _navService.popRepeated(2));
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_storeService];
}
