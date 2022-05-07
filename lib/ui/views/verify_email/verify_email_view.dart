import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import './verify_email_view_model.dart';

class VerifyEmailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VerifyEmailViewModel>.reactive(
      viewModelBuilder: () => VerifyEmailViewModel(),
      onModelReady: (VerifyEmailViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        VerifyEmailViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          body: Center(
            child: Text(
              'VerifyEmailView',
            ),
          ),
        );
      },
    );
  }
}
