import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class DonorFormViewModel extends BaseViewModel {
  Future<void> init() async {}

  final GlobalKey<FormState> _donorFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> get donorFormKey => _donorFormKey;
}
