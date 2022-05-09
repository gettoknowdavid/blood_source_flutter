import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/ui/shared/widgets/app_button.dart';
import 'package:blood_source/ui/shared/widgets/app_text_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import './home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (HomeViewModel model) async {
        await model.init();
      },
      builder: (context, model, Widget? child) {
        return Scaffold(
          appBar: AppBar(title: const Text('BloodSource')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppButton(
                  onTap: () => model.signOut(),
                  text: 'Sign Out',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
