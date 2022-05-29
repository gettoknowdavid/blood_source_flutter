import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import './request_list_view_model.dart';

class RequestListView extends StatelessWidget {
  const RequestListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RequestListViewModel>.reactive(
      viewModelBuilder: () => RequestListViewModel(),
      onModelReady: (RequestListViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        RequestListViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          body: Center(
            child: Text(
              'RequestListView',
            ),
          ),
        );
      },
    );
  }
}
