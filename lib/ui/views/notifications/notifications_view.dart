import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import './notifications_view_model.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NotificationsViewModel>.reactive(
      viewModelBuilder: () => NotificationsViewModel(),
      onModelReady: (NotificationsViewModel model) async => await model.init(),
      builder: (context, model, Widget? child) {
        return Scaffold(
          body: Center(
            child: Text(
              'NotificationsView',
            ),
          ),
        );
      },
    );
  }
}
