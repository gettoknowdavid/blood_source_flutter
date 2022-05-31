import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import './donor_details_view_model.dart';

class DonorDetailsView extends StatelessWidget {
  const DonorDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DonorDetailsViewModel>.reactive(
      viewModelBuilder: () => DonorDetailsViewModel(),
      onModelReady: (DonorDetailsViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        DonorDetailsViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          body: Center(
            child: Text(
              'DonorDetailsView',
            ),
          ),
        );
      },
    );
  }
}
