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
      await _requestRef
          .doc(req.uid)
          .set(req)
          .timeout(const Duration(seconds: 10));
      _request.value = req;
      return RequestResult(request: request);
    } on FirebaseException catch (e) {
      return RequestResult.error(errorMessage: e.message);
    }
  }

  Future<void> deleteRequest(String uid) async {
    return await _requestRef.doc(uid).delete();
  }

  Stream<QuerySnapshot<Request?>> getRequests() {
    final uid = _authService.currentUser!.uid;
    return _requestRef
        .where('user.uid', isNotEqualTo: uid)
        .snapshots()
        .timeout(const Duration(seconds: 10));
  }

  Stream<QuerySnapshot<Request>> getMyRequests() {
    final uid = _authService.currentUser!.uid;
    return _requestRef
        .where('user.uid', isEqualTo: uid)
        .snapshots()
        .timeout(const Duration(seconds: 10));
  }

  RequestResult getCompatibleRequests() {
    try {
      final r = compatibleRecipients(_bsUser.bloodGroup!, _requestRef)
          .timeout(const Duration(seconds: 12));
      return RequestResult(compatibleStream: r);
    } on Exception catch (_) {
      return RequestResult.error(
        errorMessage: 'Connection timed out! Check your connection.',
      );
    }
  }
}

class RequestResult {
  final Request? request;
  final List<Request>? requests;
  final Stream<QuerySnapshot<Request>>? compatibleStream;
  final Stream<QuerySnapshot<Request>>? requestsStream;
  final Stream<QuerySnapshot<Request>>? myRequestsStream;

  final String? errorMessage;

  RequestResult({
    this.request,
    this.requests,
    this.compatibleStream,
    this.myRequestsStream,
    this.requestsStream,
  }) : errorMessage = null;

  RequestResult.error({this.errorMessage})
      : request = null,
        requests = null,
        compatibleStream = null,
        myRequestsStream = null,
        requestsStream = null;

  bool get hasError => errorMessage != null && errorMessage!.isNotEmpty;

  bool get isRequestsEmpty => requests == null && requests!.isEmpty;
}
