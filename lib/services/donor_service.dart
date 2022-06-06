import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/models/request.dart';
import 'package:blood_source/models/user-type.dart';
import 'package:blood_source/services/store_service.dart';
import 'package:blood_source/utils/compatible_donors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blood_source/models/blood_source_user.dart';

class DonorService {
  final StoreService _storeService = locator<StoreService>();
  BloodSourceUser get _bsUser => _storeService.bsUser!;

  final usersRef = FirebaseFirestore.instance
      .collection('users')
      .withConverter<BloodSourceUser>(
          fromFirestore: BloodSourceUser.fromFirestore,
          toFirestore: (_b, _) => _b.toFirestore());

  Stream<QuerySnapshot<BloodSourceUser?>> getDonors() {
    return usersRef
        .where('uid', isNotEqualTo: _bsUser.uid)
        .where('userType', isEqualTo: UserType.donor.name)
        .snapshots();
  }

  Stream<QuerySnapshot<BloodSourceUser?>> getCompatibleDonors(Request r) {
    final stream = compatibleDonors(r.bloodGroup);
    return stream;
  }
}
