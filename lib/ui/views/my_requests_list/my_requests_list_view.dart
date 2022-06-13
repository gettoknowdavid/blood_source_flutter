import 'package:blood_source/models/blood_group.dart';
import 'package:blood_source/models/request.dart';
import 'package:blood_source/ui/shared/widgets/app_back_button.dart';
import 'package:blood_source/ui/shared/widgets/empty_widget.dart';
import 'package:blood_source/ui/shared/widgets/loading_indicator.dart';
import 'package:blood_source/ui/shared/widgets/offline_widget.dart';
import 'package:blood_source/utils/date_formatter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
        if (model.isBusy || !model.dataReady || model.isConnected == null) {
          return const LoadingIndicator();
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('My Requests'),
            leading: const AppBackButton(),
            elevation: 0,
          ),
          body: !model.isConnected!
              ? OfflineWidget(onTap: model.checkConnectivity, addPadding: true)
              : Container(
                  child: model.data!.docs.isEmpty
                      ? const EmptyWidget(
                          message:
                              'It seems you haven\'t made any requests yet.',
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              20.verticalSpace,
                              ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                itemCount: model.data!.docs.length,
                                itemBuilder: (context, i) {
                                  List<QueryDocumentSnapshot<Request>>
                                      requests = model.data!.docs;
                                  final request = requests[i].data();

                                  return _MyRequestsListItem(
                                    request: request,
                                    onDelete: () {
                                      requests.removeAt(i);
                                      model.notifyListeners();
                                      model.deleteRequest(request.uid);
                                    },
                                  );
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

class _MyRequestsListItem extends StatelessWidget {
  const _MyRequestsListItem({
    Key? key,
    required this.request,
    required this.onDelete,
  }) : super(key: key);

  final Request request;
  final void Function()? onDelete;

  @override
  Widget build(BuildContext context) {
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
          onPressed: onDelete,
          icon: const Icon(
            PhosphorIcons.trash,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
