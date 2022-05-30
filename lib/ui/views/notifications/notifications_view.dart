import 'package:blood_source/ui/shared/widgets/empty_widget.dart';
import 'package:blood_source/ui/shared/widgets/loading_indicator.dart';
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
        if (model.isBusy) {
          return const LoadingIndicator();
        }

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Notifications'),
          ),
          body: model.notifications == null
              ? const EmptyWidget()
              : const Center(child: Text('NotificationsView')),
        );
      },
    );
  }
}
