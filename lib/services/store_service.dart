import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/models/request.dart';
import 'package:blood_source/services/storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blood_source/models/blood_source_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:logger/logger.dart';

class StoreService with ReactiveServiceMixin {
  StoreService() {
    listenToReactiveValues([_bloodUser, _request]);
  }

  Logger logger = Logger();

  final ReactiveValue<Request?> _request = ReactiveValue<Request?>(null);
  Request? get request => _request.value;

  final ReactiveValue<List<Request>?> _requests =
      ReactiveValue<List<Request>?>(null);
  List<Request>? get requests => _requests.value;

  final ReactiveValue<BloodSourceUser?> _bloodUser =
      ReactiveValue<BloodSourceUser?>(null);
  BloodSourceUser? get bloodUser => _bloodUser.value;

  final StorageService _storageService = locator<StorageService>();

  final _usersColRef = FirebaseFirestore.instance.collection('users');
  final _requestColRef = FirebaseFirestore.instance.collection('requests');

  Future<StoreResult> addRequest(Request req) async {
    try {
      await _requestColRef.doc().set(req.toFirestore());
      _request.value = req;
      return StoreResult(request: request);
    } on FirebaseException catch (e) {
      return StoreResult.error(errorMessage: e.message);
    }
  }

  Future<StoreResult> getRequests() async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      // final queryMap = await _requestColRef
      //     .where('user', isEqualTo: uid)
      //     .orderBy('timeAdded', descending: true)
      //     .get();
      // final List<Request> list =
      //     queryMap.docs.map((e) => Request.fromFirestore(e, null)).toList();
      // _requests.value = list;
      List<Request>? list = [];
      _requestColRef
          .where('user', isEqualTo: uid)
          .orderBy('timeAdded', descending: true)
          .snapshots()
          .listen((event) {
        list = event.docs.map((e) => Request.fromFirestore(e, null)).toList();
        _requests.value = list;
      });
      return StoreResult(requests: list);
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

  final String? errorMessage;

  StoreResult({this.bSUser, this.request, this.requests}) : errorMessage = null;

  StoreResult.error({this.errorMessage})
      : bSUser = null,
        request = null,
        requests = null;

  bool get hasError => errorMessage != null && errorMessage!.isNotEmpty;
}
