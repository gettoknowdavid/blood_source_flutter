import 'package:blood_source/ui/shared/widgets/app_back_button.dart';
import 'package:blood_source/ui/shared/widgets/empty_widget.dart';
import 'package:blood_source/ui/shared/widgets/loading_indicator.dart';
import 'package:blood_source/ui/shared/widgets/request_list/request_list_item.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './request_list_view_model.dart';

class RequestListView extends StatelessWidget {
  const RequestListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RequestListViewModel>.reactive(
      viewModelBuilder: () => RequestListViewModel(),
      onModelReady: (model) async => await model.init(),
      builder: (context, model, Widget? child) {
        if (model.isBusy) {
          return const LoadingIndicator();
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Available Requests'),
            leading: const AppBackButton(),
            elevation: 0,
          ),
          body: model.requests!.isEmpty
              ? const EmptyWidget()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      20.verticalSpace,
                      ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: model.requests!.length,
                        itemBuilder: (context, i) {
                          final request = model.requests![i];

                          return RequestListItem(
                            key: Key(i.toString()),
                            request: request,
                          );
                        },
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
