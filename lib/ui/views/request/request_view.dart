import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import './request_view_model.dart';

class RequestView extends StatelessWidget {
  const RequestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RequestViewModel>.reactive(
      viewModelBuilder: () => RequestViewModel(),
      onModelReady: (RequestViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        RequestViewModel model,
        Widget? child,
      ) {
        return const Scaffold(
          body: Center(
            child: Text(
              'RequestView',
            ),
          ),
        );
      },
    );
  }
}
