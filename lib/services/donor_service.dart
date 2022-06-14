import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/models/request.dart';
import 'package:blood_source/models/user_type.dart';
import 'package:blood_source/services/store_service.dart';
import 'package:blood_source/utils/compatible_donors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blood_source/models/blood_source_user.dart';
import 'package:stacked/stacked.dart';

class DonorService with ReactiveServiceMixin {
  DonorService() {
    listenToReactiveValues([_donorForDetails]);
  }

  final StoreService _storeService = locator<StoreService>();

  final ReactiveValue<BloodSourceUser?> _donorForDetails =
      ReactiveValue<BloodSourceUser?>(null);
  BloodSourceUser? get donorForDetails => _donorForDetails.value;

  BloodSourceUser get _bsUser => _storeService.bsUser!;

  void setDonorForDetails(BloodSourceUser d) {
    _donorForDetails.value = d;
    notifyListeners();
  }

  final usersRef = FirebaseFirestore.instance
      .collection('users')
      .withConverter<BloodSourceUser>(
          fromFirestore: BloodSourceUser.fromFirestore,
          toFirestore: (_b, _) => _b.toFirestore());

  Future<DonorResult> getDonors() async {
    try {
      final _donors = await usersRef
          .where('uid', isNotEqualTo: _bsUser.uid)
          .where('userType', isEqualTo: UserType.donor.name)
          .get()
          .then((snap) => snap.docs.map((e) => e.data()).toList())
          .timeout(const Duration(seconds: 8));
      return DonorResult(donors: _donors);
    } on FirebaseException catch (e) {
      return DonorResult.error(errorMessage: e.message);
    } on Exception {
      return DonorResult.error(
        errorMessage: 'Connection timed out. Try again.',
      );
    }
  }

  Future<DonorResult> getCompatibleDonors(Request r) async {
    try {
      final _donors = await compatibleDonors(r.bloodGroup);
      return DonorResult(compatibleDonors: _donors);
    } on FirebaseException {
      return DonorResult.error(
        errorMessage: 'There seems to be a problem, try again.',
      );
    } on Exception {
      return DonorResult.error(
        errorMessage: 'Connection timed out. Try again.',
      );
    }
  }
}

class DonorResult {
  final BloodSourceUser? donor;
  final List<BloodSourceUser>? donors;
  final List<BloodSourceUser>? compatibleDonors;

  final String? errorMessage;

  DonorResult({
    this.donor,
    this.donors,
    this.compatibleDonors,
  }) : errorMessage = null;

  DonorResult.error({this.errorMessage})
      : donor = null,
        donors = null,
        compatibleDonors = null;

  bool get hasError => errorMessage != null && errorMessage!.isNotEmpty;

  bool get isDonorsEmpty => donor == null && donors!.isEmpty;
}
