import 'package:blood_source/models/blood_group.dart';
import 'package:blood_source/models/request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<List<Request>> compatibleRecipients(
  BloodGroup bloodGroup,
  CollectionReference<Map<String, dynamic>> ref,
) async {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  switch (bloodGroup) {
    case BloodGroup.aPositive:
      return await ref
          .where('uid', isNotEqualTo: uid)
          .where('bloodGroup', whereIn: [
            BloodGroup.aPositive.value.desc,
            BloodGroup.abPositive.value.desc,
          ])
          .get()
          .then((snapshots) => snapshots.docs
              .map((e) => Request.fromFirestore(e, null))
              .toList());

    case BloodGroup.oPositive:
      return await ref
          .where('uid', isNotEqualTo: uid)
          .where('bloodGroup', whereIn: [
            BloodGroup.oPositive.value.desc,
            BloodGroup.bPositive.value.desc,
            BloodGroup.aPositive.value.desc,
            BloodGroup.abPositive.value.desc,
          ])
          .get()
          .then((snapshots) => snapshots.docs
              .map((e) => Request.fromFirestore(e, null))
              .toList());

    case BloodGroup.bPositive:
      return await ref
          .where('uid', isNotEqualTo: uid)
          .where('bloodGroup', whereIn: [
            BloodGroup.bPositive.value.desc,
            BloodGroup.abPositive.value.desc,
          ])
          .get()
          .then((snapshots) => snapshots.docs
              .map((e) => Request.fromFirestore(e, null))
              .toList());

    case BloodGroup.abPositive:
      return await ref
          .where('uid', isNotEqualTo: uid)
          .where('bloodGroup', whereIn: [BloodGroup.abPositive.value.desc])
          .get()
          .then((snapshots) => snapshots.docs
              .map((e) => Request.fromFirestore(e, null))
              .toList());

    case BloodGroup.aNegative:
      return await ref
          .where('uid', isNotEqualTo: uid)
          .where('bloodGroup', whereIn: [
            BloodGroup.aPositive.value.desc,
            BloodGroup.aNegative.value.desc,
            BloodGroup.abPositive.value.desc,
            BloodGroup.abNegative.value.desc,
          ])
          .get()
          .then((snapshots) => snapshots.docs
              .map((e) => Request.fromFirestore(e, null))
              .toList());

    case BloodGroup.oNegative:
      return await ref.where('uid', isNotEqualTo: uid).get().then((snapshots) =>
          snapshots.docs.map((e) => Request.fromFirestore(e, null)).toList());

    case BloodGroup.bNegative:
      return await ref
          .where('uid', isNotEqualTo: uid)
          .where('bloodGroup', whereIn: [
            BloodGroup.bPositive.value.desc,
            BloodGroup.bNegative.value.desc,
            BloodGroup.abPositive.value.desc,
            BloodGroup.abNegative.value.desc,
          ])
          .get()
          .then((snapshots) => snapshots.docs
              .map((e) => Request.fromFirestore(e, null))
              .toList());

    case BloodGroup.abNegative:
      return await ref
          .where('uid', isNotEqualTo: uid)
          .where('bloodGroup', whereIn: [
            BloodGroup.abPositive.value.desc,
            BloodGroup.abNegative.value.desc,
          ])
          .get()
          .then((snapshots) => snapshots.docs
              .map((e) => Request.fromFirestore(e, null))
              .toList());

    default:
      return await ref.where('uid', isNotEqualTo: uid).get().then((snapshots) =>
          snapshots.docs.map((e) => Request.fromFirestore(e, null)).toList());
  }
}
