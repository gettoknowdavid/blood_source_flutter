import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import './donate_view_model.dart';

class DonateView extends StatelessWidget {
  const DonateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DonateViewModel>.reactive(
      viewModelBuilder: () => DonateViewModel(),
      onModelReady: (DonateViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        DonateViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          body: Center(
            child: Text(
              'DonateView',
            ),
          ),
        );
      },
    );
  }
}
