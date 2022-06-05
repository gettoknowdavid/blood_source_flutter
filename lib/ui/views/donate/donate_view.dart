import 'package:blood_source/ui/shared/widgets/app_back_button.dart';
import 'package:blood_source/ui/shared/widgets/donate/contact_button_item.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:blood_source/models/blood_source_user.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './donate_view_model.dart';

class DonateView extends StatelessWidget {
  const DonateView({Key? key, required this.donor}) : super(key: key);
  final BloodSourceUser donor;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DonateViewModel>.reactive(
      viewModelBuilder: () => DonateViewModel(),
      onModelReady: (DonateViewModel model) async => await model.init(),
      builder: (context, model, Widget? child) {
        return Scaffold(
          appBar: AppBar(leading: const AppBackButton()),
          body: Center(
            child: SizedBox(
              height: 0.6 * 1.sh,
              child: GridView.builder(
                primary: false,
                padding: EdgeInsets.symmetric(
                  horizontal: 32.w,
                  vertical: 30.h,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 9 / 11,
                  crossAxisSpacing: 20.h,
                  mainAxisSpacing: 20.h,
                ),
                itemCount: model.buttons.length,
                itemBuilder: (BuildContext context, i) {
                  return ContactButtonItem(
                    model: model.buttons[i],
                    onTap: () => model.getAction(
                      model.buttons[i].contactType,
                      donor,
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
