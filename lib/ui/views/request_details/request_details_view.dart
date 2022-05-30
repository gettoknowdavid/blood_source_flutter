import 'package:blood_source/models/request.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import './request_details_view_model.dart';

class RequestDetailsView extends StatelessWidget {
  const RequestDetailsView({Key? key, required this.request}) : super(key: key);
  final Request request;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RequestDetailsViewModel>.reactive(
      viewModelBuilder: () => RequestDetailsViewModel(),
      onModelReady: (RequestDetailsViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        RequestDetailsViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          body: Center(
            child: Text(
              'RequestDetailsView',
            ),
          ),
        );
      },
    );
  }
}
