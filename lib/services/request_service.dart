import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/models/request.dart';
import 'package:blood_source/services/auth_service.dart';
import 'package:blood_source/services/store_service.dart';
import 'package:blood_source/utils/compatible_recipients.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blood_source/models/blood_source_user.dart';
import 'package:stacked/stacked.dart';

class RequestService with ReactiveServiceMixin {
  RequestService() {
    listenToReactiveValues([_request, _compatible]);
  }

  final AuthService _authService = locator<AuthService>();
  final StoreService _storeService = locator<StoreService>();

  BloodSourceUser get _bsUser => _storeService.bsUser!;

  final _requestRef = FirebaseFirestore.instance
      .collection('requests')
      .withConverter<Request>(
          fromFirestore: Request.fromFirestore,
          toFirestore: (_b, _) => _b.toFirestore());

  final ReactiveValue<Request?> _request = ReactiveValue<Request?>(null);
  Request? get request => _request.value;

  final ReactiveValue<bool> _compatible = ReactiveValue<bool>(true);
  bool get compatible => _compatible.value;

  Future<Request> setRequest(Request req) async {
    _request.value = req;
    return req;
  }

  Future<bool> setCompatible(bool value) async {
    _compatible.value = value;
    return value;
  }

  Future<RequestResult> addRequest(Request req) async {
    try {
      await _requestRef.doc().set(req);
      _request.value = req;
      return RequestResult(request: request);
    } on FirebaseException catch (e) {
      return RequestResult.error(errorMessage: e.message);
    }
  }

  Stream<QuerySnapshot<Request?>> getRequests() {
    final uid = _authService.currentUser!.uid;
    return _requestRef.where('user.uid', isNotEqualTo: uid).snapshots();
  }

  Future<RequestResult> getMyRequests() async {
    try {
      final uid = _authService.currentUser!.uid;
      final list = await _requestRef
          .where('user.uid', isEqualTo: uid)
          .get()
          .then((value) => value.docs.map((e) => e.data()).toList());

      return RequestResult(requests: list);
    } on FirebaseException catch (e) {
      return RequestResult.error(errorMessage: e.message);
    }
  }

  Stream<QuerySnapshot<Request?>> getCompatibleRequests() {
    return compatibleRecipients(_bsUser.bloodGroup!, _requestRef);
  }
}

class RequestResult {
  final Request? request;
  final List<Request>? requests;

  final String? errorMessage;

  RequestResult({this.request, this.requests}) : errorMessage = null;

  RequestResult.error({this.errorMessage})
      : request = null,
        requests = null;

  bool get hasError => errorMessage != null && errorMessage!.isNotEmpty;

  bool get isRequestsEmpty => requests == null && requests!.isEmpty;
}
