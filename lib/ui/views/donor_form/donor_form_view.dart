import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import './donor_form_view_model.dart';

class DonorFormView extends StatelessWidget {
  const DonorFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DonorFormViewModel>.reactive(
      viewModelBuilder: () => DonorFormViewModel(),
      onModelReady: (DonorFormViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        DonorFormViewModel model,
        Widget? child,
      ) {
        return const Scaffold(
          body: Center(
            child: Text('DonorFormView'),
          ),
        );
      },
    );
  }
}
