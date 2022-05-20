import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import './app_layout_view_model.dart';

class AppLayoutView extends StatelessWidget {
  const AppLayoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppLayoutViewModel>.reactive(
      viewModelBuilder: () => AppLayoutViewModel(),
      builder: (context, model, Widget? child) {
        return Scaffold(
          body: Center(
            child: Text(
              'AppLayoutView',
            ),
          ),
        );
      },
    );
  }
}
