import 'package:blood_source/ui/views/sign_in/sign_in_view.dart';
import 'package:blood_source/ui/views/verify_email/verify_email_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import './main_scaffold_view_model.dart';

class MainScaffoldView extends StatelessWidget {
  const MainScaffoldView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainScaffoldViewModel>.reactive(
      viewModelBuilder: () => MainScaffoldViewModel(),
      onModelReady: (model) async => await model.init(),
      builder: (context, model, Widget? child) {
        if (model.data != null) {
          return const VerifyEmailView();
        } else {
          return const SignInView();
        }
      },
    );
  }
}
