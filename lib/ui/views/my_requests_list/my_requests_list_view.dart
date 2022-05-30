import 'package:blood_source/models/blood_group.dart';
import 'package:blood_source/ui/shared/widgets/app_back_button.dart';
import 'package:blood_source/ui/shared/widgets/empty_widget.dart';
import 'package:blood_source/ui/shared/widgets/loading_indicator.dart';
import 'package:blood_source/utils/date_formatter.dart';
import 'package:flutter/material.dart';
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
        if (model.isBusy) {
          return const LoadingIndicator();
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('My Requests'),
            leading: const AppBackButton(),
            elevation: 0,
          ),
          body: model.myRequests!.isEmpty
              ? const EmptyWidget()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      20.verticalSpace,
                      ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: model.myRequests!.length,
                        itemBuilder: (context, i) {
                          final request = model.myRequests![i];
                          BloodGroup bloodGroup = request.bloodGroup;

                          return ListTile(
                            title: Text(bloodGroup.value.desc),
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
                            trailing: Container(
                              padding: EdgeInsets.all(7.r),
                              decoration: BoxDecoration(
                                color: request.requestGranted
                                    ? Colors.green
                                    : Colors.red,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                request.requestGranted ? 'GRANTED' : 'PENDING',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
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
