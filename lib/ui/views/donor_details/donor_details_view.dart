import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:blood_source/models/blood_source_user.dart';

import './donor_details_view_model.dart';

class DonorDetailsView extends StatelessWidget {
  const DonorDetailsView({Key? key, required this.donor}) : super(key: key);
  final BloodSourceUser donor;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DonorDetailsViewModel>.reactive(
      viewModelBuilder: () => DonorDetailsViewModel(),
      onModelReady: (model) async => await model.init(donor),
      builder: (context, model, Widget? child) {
        return Scaffold(
          body: Center(
            child: Text(donor.uid!),
          ),
        );
      },
    );
  }
}
