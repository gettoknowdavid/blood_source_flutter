import 'dart:async';

import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/models/request.dart';
import 'package:blood_source/models/user-type.dart';
import 'package:blood_source/services/storage_service.dart';
import 'package:blood_source/utils/compatible_donors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blood_source/models/blood_source_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:logger/logger.dart';

class StoreService with ReactiveServiceMixin {
  StoreService() {
    listenToReactiveValues([_bloodUser, _request, _donors, _donorCount]);
  }

  Logger logger = Logger();

  final ReactiveValue<List<BloodSourceUser>> _donors =
      ReactiveValue<List<BloodSourceUser>>([]);
  List<BloodSourceUser> get donors => _donors.value;

  final ReactiveValue<int> _donorCount = ReactiveValue<int>(0);
  int get donorCount => _donorCount.value;

  final ReactiveValue<Request?> _request = ReactiveValue<Request?>(null);
  Request? get request => _request.value;

  final ReactiveValue<List<Request>?> _requests =
      ReactiveValue<List<Request>?>([]);
  List<Request>? get requests => _requests.value;

  final ReactiveValue<BloodSourceUser?> _bloodUser =
      ReactiveValue<BloodSourceUser?>(null);
  BloodSourceUser? get bloodUser => _bloodUser.value;

  final StorageService _storageService = locator<StorageService>();

  final _usersColRef = FirebaseFirestore.instance.collection('users');
  final _requestColRef = FirebaseFirestore.instance.collection('requests');

  Future<StoreResult> getDonors() async {
    try {
      final list = await _usersColRef
          .where('uid', isNotEqualTo: _bloodUser.value!.uid)
          .where('userType', isEqualTo: UserType.donor.name)
          .get()
          .then((snapshots) => snapshots.docs
              .map((e) => BloodSourceUser.fromFirestore(e, null))
              .toList());
      if (list.isEmpty) {
        return StoreResult(donors: []);
      } else {
        return StoreResult(donors: list);
      }
    } on FirebaseException catch (e) {
      return StoreResult.error(errorMessage: e.message);
    }
  }

  Future<StoreResult> getCompatibleDonors(Request r) async {
    try {
      final _result = await compatibleDonors(r.bloodGroup, _usersColRef);
      return StoreResult(donors: _result);
    } on FirebaseException catch (e) {
      return StoreResult.error(errorMessage: e.message);
    }
  }

  Future<Request> setRequest(Request req) async {
    _request.value = req;
    return req;
  }

  Future<StoreResult> addRequest(Request req) async {
    try {
      await _requestColRef.doc().set(req.toFirestore());
      _request.value = req;
      return StoreResult(request: request);
    } on FirebaseException catch (e) {
      return StoreResult.error(errorMessage: e.message);
    }
  }

  Future<StoreResult> getRequests({bool myRequests = false}) async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      if (myRequests) {
        final list = await _requestColRef
            .where('user.uid', isEqualTo: uid)
            .get()
            .then((snapshot) => snapshot.docs
                .map((e) => Request.fromFirestore(e, null))
                .toList());
        return StoreResult(requests: list);
      } else {
        final list = await FirebaseFirestore.instance
            .collection('requests')
            .where('user.uid', isNotEqualTo: uid)
            .get()
            .then((snapshot) => snapshot.docs
                .map((e) => Request.fromFirestore(e, null))
                .toList());
        return StoreResult(requests: list);
      }
    } on FirebaseException catch (e) {
      return StoreResult.error(errorMessage: e.message);
    }
  }

  Future<StoreResult> createBloodSourceUser(BloodSourceUser user) async {
    try {
      await _usersColRef.doc(user.uid).set(user.toFirestore());
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
