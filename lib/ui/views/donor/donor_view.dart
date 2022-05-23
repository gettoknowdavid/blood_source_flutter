import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import './donor_view_model.dart';

class DonorView extends StatelessWidget {
  const DonorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DonorViewModel>.reactive(
      viewModelBuilder: () => DonorViewModel(),
      onModelReady: (model) async => await model.init(),
      builder: (context, model, Widget? child) {
        return Scaffold(
          appBar: AppBar(),
          body: const Center(
            child: Text('DonorView'),
          ),
        );
      },
    );
  }
}
