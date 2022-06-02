import 'package:blood_source/models/blood_group.dart';
import 'package:blood_source/models/user-type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:blood_source/models/blood_source_user.dart';

Future<List<BloodSourceUser>> compatibleDonors(
  BloodGroup bloodGroup,
  CollectionReference<Map<String, dynamic>> ref,
) async {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  switch (bloodGroup) {
    case BloodGroup.aPositive:
      return await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isNotEqualTo: uid)
          .where('userType', isEqualTo: UserType.donor.name)
          .where('bloodGroup', whereIn: [
            BloodGroup.aPositive.value.desc,
            BloodGroup.aNegative.value.desc,
            BloodGroup.oPositive.value.desc,
            BloodGroup.oNegative.value.desc,
          ])
          .get()
          .then((snapshots) => snapshots.docs
              .map((e) => BloodSourceUser.fromFirestore(e, null))
              .toList());

    case BloodGroup.oPositive:
      return await ref
          .where('uid', isNotEqualTo: uid)
          .where('userType', isEqualTo: UserType.donor.name)
          .where('bloodGroup', whereIn: [
            BloodGroup.oPositive.value.desc,
            BloodGroup.oNegative.value.desc,
          ])
          .get()
          .then((snapshots) => snapshots.docs
              .map((e) => BloodSourceUser.fromFirestore(e, null))
              .toList());

    case BloodGroup.bPositive:
      return await ref
          .where('uid', isNotEqualTo: uid)
          .where('userType', isEqualTo: UserType.donor.name)
          .where('bloodGroup', whereIn: [
            BloodGroup.bPositive.value.desc,
            BloodGroup.bNegative.value.desc,
            BloodGroup.oPositive.value.desc,
            BloodGroup.oNegative.value.desc,
          ])
          .get()
          .then((snapshots) => snapshots.docs
              .map((e) => BloodSourceUser.fromFirestore(e, null))
              .toList());

    case BloodGroup.abPositive:
      return await ref
          .where('uid', isNotEqualTo: uid)
          .where('userType', isEqualTo: UserType.donor.name)
          .get()
          .then((snapshots) => snapshots.docs
              .map((e) => BloodSourceUser.fromFirestore(e, null))
              .toList());

    case BloodGroup.aNegative:
      return await ref
          .where('uid', isNotEqualTo: uid)
          .where('userType', isEqualTo: UserType.donor.name)
          .where('bloodGroup', whereIn: [
            BloodGroup.aNegative.value.desc,
            BloodGroup.oNegative.value.desc,
          ])
          .get()
          .then((snapshots) => snapshots.docs
              .map((e) => BloodSourceUser.fromFirestore(e, null))
              .toList());

    case BloodGroup.oNegative:
      return await ref
          .where('uid', isNotEqualTo: uid)
          .where('userType', isEqualTo: UserType.donor.name)
          .where('bloodGroup', isEqualTo: BloodGroup.oNegative.value.desc)
          .get()
          .then((snapshots) => snapshots.docs
              .map((e) => BloodSourceUser.fromFirestore(e, null))
              .toList());

    case BloodGroup.bNegative:
      return await ref
          .where('uid', isNotEqualTo: uid)
          .where('userType', isEqualTo: UserType.donor.name)
          .where('bloodGroup', whereIn: [
            BloodGroup.bNegative.value.desc,
            BloodGroup.oNegative.value.desc,
          ])
          .get()
          .then((snapshots) => snapshots.docs
              .map((e) => BloodSourceUser.fromFirestore(e, null))
              .toList());

    case BloodGroup.abNegative:
      return await ref
          .where('uid', isNotEqualTo: uid)
          .where('userType', isEqualTo: UserType.donor.name)
          .where('bloodGroup', whereIn: [
            BloodGroup.abNegative.value.desc,
            BloodGroup.aNegative.value.desc,
            BloodGroup.bNegative.value.desc,
            BloodGroup.oNegative.value.desc,
          ])
          .get()
          .then((snapshots) => snapshots.docs
              .map((e) => BloodSourceUser.fromFirestore(e, null))
              .toList());

    default:
      return await ref
          .where('uid', isNotEqualTo: uid)
          .where('userType', isEqualTo: UserType.donor.name)
          .get()
          .then((snapshots) => snapshots.docs
              .map((e) => BloodSourceUser.fromFirestore(e, null))
              .toList());
  }
}
