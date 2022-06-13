import 'package:animations/animations.dart';
import 'package:blood_source/ui/shared/widgets/app_bottom_nav.dart';
import 'package:blood_source/ui/shared/widgets/loading_indicator.dart';
import 'package:blood_source/ui/shared/widgets/offline_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import './app_layout_view_model.dart';

class AppLayoutView extends StatelessWidget {
  const AppLayoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppLayoutViewModel>.reactive(
      viewModelBuilder: () => AppLayoutViewModel(),
      onModelReady: (model) async => await model.init(),
      builder: (context, model, Widget? child) {
        if (model.isBusy || model.isConnected == null) {
          return const LoadingIndicator();
        }

        return !model.isConnected!
            ? Scaffold(
                body: OfflineWidget(
                  onTap: model.checkConnectivity,
                  addPadding: true,
                ),
              )
            : Scaffold(
                body: PageTransitionSwitcher(
                  duration: const Duration(milliseconds: 300),
                  reverse: model.reverse,
                  transitionBuilder: (child, animation, secondaryAnimation) {
                    return SharedAxisTransition(
                      child: child,
                      animation: animation,
                      secondaryAnimation: secondaryAnimation,
                      transitionType: SharedAxisTransitionType.horizontal,
                    );
                  },
                  child: model.getView(model.currentIndex),
                ),
                bottomNavigationBar: const AppBottomNav(),
              );
      },
    );
  }
}
