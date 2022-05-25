import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import './edit_profile_view_model.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditProfileViewModel>.reactive(
      viewModelBuilder: () => EditProfileViewModel(),
      onModelReady: (model) async => await model.init(),
      builder: (context, model, Widget? child) {
        return  Scaffold(
          body: Center(
            child: Text(
              'EditProfileView',
            ),
          ),
        );
      },
    );
  }
}
