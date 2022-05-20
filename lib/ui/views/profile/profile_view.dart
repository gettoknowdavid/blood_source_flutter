import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import './profile_view_model.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      onModelReady: (ProfileViewModel model) async => await model.init(),
      builder: (context, model, Widget? child) {
        return Scaffold(
          body: Center(
            child: Text(
              'ProfileView',
            ),
          ),
        );
      },
    );
  }
}
