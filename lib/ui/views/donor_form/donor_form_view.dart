import 'package:blood_source/models/blood_group.dart';
import 'package:blood_source/models/disease_types.dart';
import 'package:blood_source/ui/shared/widgets/app_button.dart';
import 'package:blood_source/ui/shared/widgets/donor_form/donor_form_field.dart';
import 'package:blood_source/ui/shared/widgets/loading_indicator.dart';
import 'package:blood_source/ui/shared/widgets/offline_widget.dart';
import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './donor_form_view_model.dart';

class DonorFormView extends StatelessWidget {
  const DonorFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DonorFormViewModel>.reactive(
      viewModelBuilder: () => DonorFormViewModel(),
      onModelReady: (model) async => await model.init(),
      builder: (context, model, Widget? child) {
        if (model.isBusy || model.isConnected == null) {
          return const LoadingIndicator();
        }

        if (!model.isConnected!) {
          return Scaffold(
            body: OfflineWidget(
              onTap: model.checkConnectivity,
              addPadding: true,
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(title: const Text('Donor Requirement ')),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DonorFormField(
                    showBorder: false,
                    title: 'What is your blood group?',
                    content: DropdownButton<BloodGroup>(
                      value: model.bloodType,
                      borderRadius: BorderRadius.circular(20.r),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.black87,
                      ),
                      onChanged: (value) => model.onBloodGroupChanged(value),
                      underline: Container(height: 1.h, color: Colors.grey),
                      itemHeight: 56.h,
                      items: BloodGroup.values
                          .map<DropdownMenuItem<BloodGroup>>((e) {
                        return DropdownMenuItem<BloodGroup>(
                          value: e,
                          child: Text(e.value.desc),
                        );
                      }).toList(),
                    ),
                  ),
                  25.verticalSpace,
                  DonorFormField(
                    showBorder: false,
                    title: 'What is your age?',
                    content: TextFormField(
                      controller: model.ageController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'e.g. 21',
                        hintStyle: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  25.verticalSpace,
                  DonorFormField(
                    showBorder: false,
                    title: 'What is your weight?',
                    content: TextFormField(
                      controller: model.weightController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'e.g. 45kg',
                        hintStyle: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  25.verticalSpace,
                  DonorFormField(
                    title: 'Do you have any of these diseases?',
                    content: SimpleGroupedCheckbox<Disease>(
                      controller: model.diseaseController,
                      itemsTitle: Disease.values.map((e) => e.value).toList(),
                      values: Disease.values,
                      isLeading: true,
                      onItemSelected: (data) => model.onDiseaseChanged(data),
                    ),
                  ),
                  25.verticalSpace,
                  DonorFormField(
                    title: 'Are you pregnant or breast-feeding?',
                    content: ListView(
                      primary: false,
                      shrinkWrap: true,
                      children: [
                        RadioListTile<bool>(
                          title: const Text('No'),
                          value: false,
                          groupValue: model.pregnantBool,
                          onChanged: (v) => model.onPregnantChanged(v),
                        ),
                        RadioListTile<bool>(
                          title: const Text('Yes'),
                          value: true,
                          groupValue: model.pregnantBool,
                          onChanged: (v) => model.onPregnantChanged(v),
                        )
                      ],
                    ),
                  ),
                  25.verticalSpace,
                  DonorFormField(
                    showBorder: false,
                    title:
                        'Have you gotten a piercing or tattoo in the last 6 months',
                    content: ListView(
                      primary: false,
                      shrinkWrap: true,
                      children: [
                        RadioListTile<bool>(
                          title: const Text('No'),
                          value: false,
                          groupValue: model.piercingBool,
                          onChanged: (v) => model.onPiercingChanged(v),
                        ),
                        RadioListTile<bool>(
                          title: const Text('Yes'),
                          value: true,
                          groupValue: model.piercingBool,
                          onChanged: (v) => model.onPiercingChanged(v),
                        )
                      ],
                    ),
                  ),
                  30.verticalSpace,
                  AppButton(
                      onTap:
                          model.isValidated() ? () => model.onSubmit() : null,
                      text: 'Submit'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
