import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/services/storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blood_source/models/blood_source_user.dart';
import 'package:stacked/stacked.dart';

class StoreService with ReactiveServiceMixin {
  StoreService() {
    listenToReactiveValues([_bloodUser]);
  }

  final ReactiveValue<BloodSourceUser?> _bloodUser =
      ReactiveValue<BloodSourceUser?>(null);
  BloodSourceUser? get bloodUser => _bloodUser.value;

  final StorageService _storageService = locator<StorageService>();

  final _usersColRef = FirebaseFirestore.instance.collection('users');

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

  final String? errorMessage;

  StoreResult({this.bSUser}) : errorMessage = null;

  StoreResult.error({this.errorMessage}) : bSUser = null;

  bool get hasError => errorMessage != null && errorMessage!.isNotEmpty;
}
