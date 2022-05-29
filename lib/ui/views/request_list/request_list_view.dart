import 'package:blood_source/common/image_resources.dart';
import 'package:blood_source/models/blood_group.dart';
import 'package:blood_source/ui/shared/widgets/app_back_button.dart';
import 'package:blood_source/ui/shared/widgets/loading_indicator.dart';
import 'package:blood_source/utils/date_formatter.dart';
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
            title: const Text('My Requests'),
            leading: const AppBackButton(),
            elevation: 0,
          ),
          body: model.requests!.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0).r,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(ImageResources.empty),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'It\'s lonely here. It seems you haven\'t made any requests yet.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18.r,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        60.verticalSpace,
                      ],
                    ),
                  ),
                )
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

                          return ListTile(
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
