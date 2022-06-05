import 'package:blood_source/models/request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stacked/stacked.dart';

class RequestService with ReactiveServiceMixin {
  RequestService() {
    listenToReactiveValues([_request, _compatible]);
  }

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
}
