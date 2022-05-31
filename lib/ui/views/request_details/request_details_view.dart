import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/models/request.dart';
import 'package:blood_source/ui/shared/widgets/app_back_button.dart';
import 'package:blood_source/ui/shared/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './request_details_view_model.dart';

class RequestDetailsView extends StatelessWidget {
  const RequestDetailsView({Key? key, required this.request}) : super(key: key);
  final Request request;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RequestDetailsViewModel>.reactive(
      viewModelBuilder: () => RequestDetailsViewModel(),
      onModelReady: (model) async => await model.init(request),
      builder: (context, model, Widget? child) {
        if (model.isBusy) {
          return const LoadingIndicator();
        }

        return Scaffold(
          appBar: AppBar(
            leading: const AppBackButton(color: AppColors.primary),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(18, 32, 18, 32).r,
            child: Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 0.18 * 1.sw,
                    backgroundColor: AppColors.swatch.shade100,
                    child: CircleAvatar(
                      radius: 0.17 * 1.sw,
                      foregroundColor: AppColors.primary,
                      foregroundImage: NetworkImage(request.user.avatar),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
