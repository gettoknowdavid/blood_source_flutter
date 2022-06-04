import 'dart:async';

import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/models/request.dart';
import 'package:blood_source/models/user-type.dart';
import 'package:blood_source/services/storage_service.dart';
import 'package:blood_source/utils/compatible_donors.dart';
import 'package:blood_source/utils/compatible_recipients.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blood_source/models/blood_source_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:logger/logger.dart';

class StoreService with ReactiveServiceMixin {
  StoreService() {
    listenToReactiveValues(
        [_bloodUser, _compatible, _request, _donors, _donorCount]);
  }

  Logger logger = Logger();

  final ReactiveValue<List<BloodSourceUser>> _donors =
      ReactiveValue<List<BloodSourceUser>>([]);
  List<BloodSourceUser> get donors => _donors.value;

  final ReactiveValue<int> _donorCount = ReactiveValue<int>(0);
  int get donorCount => _donorCount.value;

  final ReactiveValue<Request?> _request = ReactiveValue<Request?>(null);
  Request? get request => _request.value;

  final ReactiveValue<bool> _compatible = ReactiveValue<bool>(true);
  bool get compatible => _compatible.value;

  final ReactiveValue<List<Request>?> _requests =
      ReactiveValue<List<Request>?>([]);
  List<Request>? get requests => _requests.value;

  final ReactiveValue<BloodSourceUser?> _bloodUser =
      ReactiveValue<BloodSourceUser?>(null);
  BloodSourceUser? get bloodUser => _bloodUser.value;

  final StorageService _storageService = locator<StorageService>();

  final _usersColRef = FirebaseFirestore.instance
      .collection('users')
      .withConverter<BloodSourceUser>(
          fromFirestore: BloodSourceUser.fromFirestore,
          toFirestore: (_b, _) => _b.toFirestore());

  final _requestColRef = FirebaseFirestore.instance
      .collection('requests')
      .withConverter<Request>(
          fromFirestore: Request.fromFirestore,
          toFirestore: (_b, _) => _b.toFirestore());

  Stream<QuerySnapshot<BloodSourceUser?>> getDonors() {
    return _usersColRef
        .where('uid', isNotEqualTo: _bloodUser.value!.uid)
        .where('userType', isEqualTo: UserType.donor.name)
        .snapshots();
  }

  Stream<QuerySnapshot<BloodSourceUser?>> getCompatibleDonors(Request r) {
    return compatibleDonors(r.bloodGroup);
  }

  Future<Request> setRequest(Request req) async {
    _request.value = req;
    return req;
  }

  Future<bool> setCompatible(bool value) async {
    _compatible.value = value;
    return value;
  }

  Future<StoreResult> addRequest(Request req) async {
    try {
      await _requestColRef.doc().set(req);
      _request.value = req;
      return StoreResult(request: request);
    } on FirebaseException catch (e) {
      return StoreResult.error(errorMessage: e.message);
    }
  }

  Stream<QuerySnapshot<Request?>> getRequests() {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return _requestColRef.where('user.uid', isNotEqualTo: uid).snapshots();
  }

  Future<StoreResult> getMyRequests() async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final list = await _requestColRef
          .where('user.uid', isEqualTo: uid)
          .get()
          .then((value) => value.docs.map((e) => e.data()).toList());

      return StoreResult(requests: list);
    } on FirebaseException catch (e) {
      return StoreResult.error(errorMessage: e.message);
    }
  }

  Stream<QuerySnapshot<Request?>> getCompatibleRequests() {
    return compatibleRecipients(bloodUser!.bloodGroup!, _requestColRef);
  }

  Future<StoreResult> createBloodSourceUser(BloodSourceUser user) async {
    try {
      await _usersColRef.doc(user.uid).set(user);
      _storageService.saveToDisk(user.uid!, user.toJson());
      _bloodUser.value = user;
      return StoreResult(bSUser: user);
    } on FirebaseException catch (e) {
      return StoreResult.error(errorMessage: e.message);
    }
  }

  Future<StoreResult> updateBloodSourceUser(BloodSourceUser user) async {
    try {
      await _usersColRef.doc(user.uid).update(user.toFirestore());
      _storageService.saveToDisk(user.uid!, user.toJson());
      _bloodUser.value = user;
      return StoreResult(bSUser: user);
    } on FirebaseException catch (e) {
      return StoreResult.error(errorMessage: e.message);
    }
  }

  Future<StoreResult?> getUser(String uid) async {
    try {
      final _userData = await _usersColRef
          .doc(uid)
          .withConverter<BloodSourceUser>(
              fromFirestore: BloodSourceUser.fromFirestore,
              toFirestore: (_u, _) => _u.toFirestore())
          .get();
      _bloodUser.value = _userData.data();
      return StoreResult(bSUser: _userData.data());
    } on FirebaseException catch (e) {
      return StoreResult.error(errorMessage: e.message);
    }
  }

  Future<StoreResult?> getUserFromLocalStorage(String uid) async {
    try {
      final _result = _storageService.getFromDisk(uid);
      _bloodUser.value = _result;
      return StoreResult(bSUser: _result);
    } on FirebaseException catch (e) {
      return StoreResult.error(errorMessage: e.message);
    }
  }
}

class StoreResult {
  final BloodSourceUser? bSUser;
  final Request? request;
  final List<Request>? requests;
  final List<BloodSourceUser>? donors;

  final String? errorMessage;

  StoreResult({this.bSUser, this.request, this.requests, this.donors})
      : errorMessage = null;

  StoreResult.error({this.errorMessage})
      : bSUser = null,
        request = null,
        requests = null,
        donors = null;

  bool get hasError => errorMessage != null && errorMessage!.isNotEmpty;

  bool get isRequestsEmpty => requests == null && requests!.isEmpty;

  bool get isDonorsEmpty => donors == null && requests!.isEmpty;
}
