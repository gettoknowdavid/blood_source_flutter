import 'package:blood_source/ui/shared/widgets/app_back_button.dart';
import 'package:blood_source/ui/shared/widgets/app_text_button.dart';
import 'package:blood_source/ui/shared/widgets/empty_widget.dart';
import 'package:blood_source/ui/shared/widgets/loading_indicator.dart';
import 'package:blood_source/ui/shared/widgets/offline_widget.dart';
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
        if (model.isBusy ||
            model.isConnected == null ||
            model.fetchingCompatible ||
            model.fetchingRequests) {
          return const LoadingIndicator();
        }

        final requests = model.compatible
            ? model.fetchedCompatibleRequests.compatibleRequests
            : model.fetchedRequests.requests;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Requests'),
            leading: const AppBackButton(),
            elevation: 0,
            actions: [
              if (!model.isConnected!)
                const SizedBox()
              else
                AppTextButton(
                  onTap: model.onCompatibilityChanged,
                  text: model.compatible ? 'Show All' : 'Show Compatible',
                  fontSize: 16.sp,
                  color: Colors.white,
                  padding: EdgeInsets.only(right: 18.r),
                )
            ],
          ),
          body: !model.isConnected!
              ? OfflineWidget(onTap: model.checkConnectivity, addPadding: true)
              : Container(
                  child: requests!.isEmpty
                      ? const EmptyWidget(message: 'There are no requests.')
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              20.verticalSpace,
                              ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                itemCount: requests.length,
                                itemBuilder: (context, i) {
                                  return RequestListItem(request: requests[i]);
                                },
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
