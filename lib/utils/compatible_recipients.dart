import 'package:blood_source/models/blood_group.dart';
import 'package:blood_source/models/request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Stream<QuerySnapshot<Request>> compatibleRecipients(
  BloodGroup bloodGroup,
  CollectionReference<Request> ref,
) {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  switch (bloodGroup) {
    case BloodGroup.aPositive:
      return ref
          .where('user.uid', isNotEqualTo: uid)
          .where('bloodGroup', whereIn: [
        BloodGroup.aPositive.value.desc,
        BloodGroup.abPositive.value.desc,
      ]).snapshots();

    case BloodGroup.oPositive:
      return ref
          .where('user.uid', isNotEqualTo: uid)
          .where('bloodGroup', whereIn: [
        BloodGroup.oPositive.value.desc,
        BloodGroup.bPositive.value.desc,
        BloodGroup.aPositive.value.desc,
        BloodGroup.abPositive.value.desc,
      ]).snapshots();

    case BloodGroup.bPositive:
      return ref
          .where('user.uid', isNotEqualTo: uid)
          .where('bloodGroup', whereIn: [
        BloodGroup.bPositive.value.desc,
        BloodGroup.abPositive.value.desc,
      ]).snapshots();

    case BloodGroup.abPositive:
      return ref
          .where('user.uid', isNotEqualTo: uid)
          .where('bloodGroup', isEqualTo: BloodGroup.abPositive.value.desc)
          .snapshots();

    case BloodGroup.aNegative:
      return ref
          .where('user.uid', isNotEqualTo: uid)
          .where('bloodGroup', whereIn: [
        BloodGroup.aPositive.value.desc,
        BloodGroup.aNegative.value.desc,
        BloodGroup.abPositive.value.desc,
        BloodGroup.abNegative.value.desc,
      ]).snapshots();

    case BloodGroup.oNegative:
      return ref.where('user.uid', isNotEqualTo: uid).snapshots();

    case BloodGroup.bNegative:
      return ref
          .where('user.uid', isNotEqualTo: uid)
          .where('bloodGroup', whereIn: [
        BloodGroup.bPositive.value.desc,
        BloodGroup.bNegative.value.desc,
        BloodGroup.abPositive.value.desc,
        BloodGroup.abNegative.value.desc,
      ]).snapshots();

    case BloodGroup.abNegative:
      return ref
          .where('user.uid', isNotEqualTo: uid)
          .where('bloodGroup', whereIn: [
        BloodGroup.abPositive.value.desc,
        BloodGroup.abNegative.value.desc,
      ]).snapshots();

    default:
      return ref.where('user.uid', isNotEqualTo: uid).snapshots();
  }
}
