import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import './forgot_password_view_model.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ForgotPasswordViewModel>.reactive(
      viewModelBuilder: () => ForgotPasswordViewModel(),
      onModelReady: (model) async => await model.init(),
      builder: (context, model, Widget? child) {
        return Scaffold(
          body: Center(
            child: Text('ForgotPasswordView'),
          ),
        );
      },
    );
  }
}
