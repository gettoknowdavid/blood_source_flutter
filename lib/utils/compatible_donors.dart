import 'package:blood_source/models/blood_group.dart';
import 'package:blood_source/models/user-type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:blood_source/models/blood_source_user.dart';

Stream<QuerySnapshot<BloodSourceUser?>> compatibleDonors(
    BloodGroup bloodGroup) {
  final ref = FirebaseFirestore.instance
      .collection('users')
      .withConverter<BloodSourceUser>(
        fromFirestore: BloodSourceUser.fromFirestore,
        toFirestore: (_b, _) => _b.toFirestore(),
      );

  final uid = FirebaseAuth.instance.currentUser!.uid;
  switch (bloodGroup) {
    case BloodGroup.aPositive:
      return ref
          .where('uid', isNotEqualTo: uid)
          .where('userType', isEqualTo: UserType.donor.name)
          .where('bloodGroup', whereIn: [
        BloodGroup.aPositive.value.desc,
        BloodGroup.aNegative.value.desc,
        BloodGroup.oPositive.value.desc,
        BloodGroup.oNegative.value.desc,
      ]).snapshots();

    case BloodGroup.oPositive:
      return ref
          .where('uid', isNotEqualTo: uid)
          .where('userType', isEqualTo: UserType.donor.name)
          .where('bloodGroup', whereIn: [
        BloodGroup.oPositive.value.desc,
        BloodGroup.oNegative.value.desc,
      ]).snapshots();

    case BloodGroup.bPositive:
      return ref
          .where('uid', isNotEqualTo: uid)
          .where('userType', isEqualTo: UserType.donor.name)
          .where('bloodGroup', whereIn: [
        BloodGroup.bPositive.value.desc,
        BloodGroup.bNegative.value.desc,
        BloodGroup.oPositive.value.desc,
        BloodGroup.oNegative.value.desc,
      ]).snapshots();

    case BloodGroup.abPositive:
      return ref
          .where('uid', isNotEqualTo: uid)
          .where('userType', isEqualTo: UserType.donor.name)
          .snapshots();

    case BloodGroup.aNegative:
      return ref
          .where('uid', isNotEqualTo: uid)
          .where('userType', isEqualTo: UserType.donor.name)
          .where('bloodGroup', whereIn: [
        BloodGroup.aNegative.value.desc,
        BloodGroup.oNegative.value.desc,
      ]).snapshots();

    case BloodGroup.oNegative:
      return ref
          .where('uid', isNotEqualTo: uid)
          .where('userType', isEqualTo: UserType.donor.name)
          .where('bloodGroup', isEqualTo: BloodGroup.oNegative.value.desc)
          .snapshots();

    case BloodGroup.bNegative:
      return ref
          .where('uid', isNotEqualTo: uid)
          .where('userType', isEqualTo: UserType.donor.name)
          .where('bloodGroup', whereIn: [
        BloodGroup.bNegative.value.desc,
        BloodGroup.oNegative.value.desc,
      ]).snapshots();

    case BloodGroup.abNegative:
      return ref
          .where('uid', isNotEqualTo: uid)
          .where('userType', isEqualTo: UserType.donor.name)
          .where('bloodGroup', whereIn: [
        BloodGroup.abNegative.value.desc,
        BloodGroup.aNegative.value.desc,
        BloodGroup.bNegative.value.desc,
        BloodGroup.oNegative.value.desc,
      ]).snapshots();

    default:
      return ref
          .where('uid', isNotEqualTo: uid)
          .where('userType', isEqualTo: UserType.donor.name)
          .snapshots();
  }
}
