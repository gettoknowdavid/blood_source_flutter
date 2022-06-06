import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blood_source/models/blood_source_user.dart';
import 'package:stacked/stacked.dart';

class StoreService with ReactiveServiceMixin {
  StoreService() {
    listenToReactiveValues([_bsUser]);
  }

  final ReactiveValue<BloodSourceUser?> _bsUser =
      ReactiveValue<BloodSourceUser?>(null);
  BloodSourceUser? get bsUser => _bsUser.value;

  final _usersColRef = FirebaseFirestore.instance
      .collection('users')
      .withConverter<BloodSourceUser>(
          fromFirestore: BloodSourceUser.fromFirestore,
          toFirestore: (_b, _) => _b.toFirestore());

  Future<StoreResult> createBloodSourceUser(BloodSourceUser user) async {
    try {
      await _usersColRef.doc(user.uid).set(user);
      _bsUser.value = user;
      return StoreResult(bSUser: user);
    } on FirebaseException catch (e) {
      return StoreResult.error(errorMessage: e.message);
    }
  }

  Future<StoreResult> updateBloodSourceUser(BloodSourceUser user) async {
    try {
      await _usersColRef.doc(user.uid).update(user.toFirestore());
      _bsUser.value = user;
      return StoreResult(bSUser: user);
    } on FirebaseException catch (e) {
      return StoreResult.error(errorMessage: e.message);
    }
  }

  Future<StoreResult?> getUser(String uid) async {
    try {
      final _userData = await _usersColRef.doc(uid).get();
      _bsUser.value = _userData.data();
      return StoreResult(bSUser: _userData.data());
    } on FirebaseException catch (e) {
      return StoreResult.error(errorMessage: e.message);
    }
  }
}

class StoreResult {
  final BloodSourceUser? bSUser;

  final String? errorMessage;

  StoreResult({this.bSUser}) : errorMessage = null;

  StoreResult.error({this.errorMessage}) : bSUser = null;

  bool get hasError => errorMessage != null && errorMessage!.isNotEmpty;
}
