import 'package:blood_source/models/blood_group.dart';
import 'package:blood_source/models/request.dart';
import 'package:blood_source/ui/shared/widgets/app_back_button.dart';
import 'package:blood_source/ui/shared/widgets/empty_widget.dart';
import 'package:blood_source/ui/shared/widgets/loading_indicator.dart';
import 'package:blood_source/ui/shared/widgets/offline_widget.dart';
import 'package:blood_source/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './my_requests_list_view_model.dart';

class MyRequestsListView extends StatelessWidget {
  const MyRequestsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyRequestsListViewModel>.reactive(
      viewModelBuilder: () => MyRequestsListViewModel(),
      onModelReady: (model) async => await model.init(),
      builder: (context, model, Widget? child) {
        if (model.isBusy || model.isConnected == null) {
          return const LoadingIndicator();
        }

        List<Request> requests = model.data!.myRequests!;

        return Scaffold(
          appBar: AppBar(
            title: const Text('My Requests'),
            leading: const AppBackButton(),
            elevation: 0,
          ),
          body: !model.isConnected!
              ? OfflineWidget(onTap: model.checkConnectivity, addPadding: true)
              : requests.isEmpty
                  ? const EmptyWidget(message: 'You have not request yet.')
                  : RefreshIndicator(
                      onRefresh: model.initialise,
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: requests.length,
                        itemBuilder: (context, i) {
                          return _MyRequestsItem(request: requests[i]);
                        },
                      ),
                    ),
        );
      },
    );
  }
}

class _MyRequestsItem extends ViewModelWidget<MyRequestsListViewModel> {
  const _MyRequestsItem({Key? key, required this.request}) : super(key: key);

  final Request request;

  @override
  Widget build(BuildContext context, MyRequestsListViewModel viewModel) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.r),
      child: ListTile(
        title: Text(request.bloodGroup.value.desc),
        isThreeLine: true,
        subtitle: Text(
          dateFormatter(
            request.timeAdded!.toIso8601String(),
          ),
          style: const TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: IconButton(
          onPressed: () => viewModel.delete(request),
          icon: const Icon(
            PhosphorIcons.trash,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
