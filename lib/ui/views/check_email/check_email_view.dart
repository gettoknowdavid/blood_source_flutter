import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import './check_email_view_model.dart';

class CheckEmailView extends StatelessWidget {
  const CheckEmailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CheckEmailViewModel>.reactive(
      viewModelBuilder: () => CheckEmailViewModel(),
      onModelReady: (CheckEmailViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        CheckEmailViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          body: Center(
            child: Text(
              'CheckEmailView',
            ),
          ),
        );
      },
    );
  }
}
