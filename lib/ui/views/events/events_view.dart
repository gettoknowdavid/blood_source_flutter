import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import './events_view_model.dart';

class EventsView extends StatelessWidget {
  const EventsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EventsViewModel>.reactive(
      viewModelBuilder: () => EventsViewModel(),
      onModelReady: (EventsViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        EventsViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          appBar: AppBar(title: const Text('Events')),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: const [
                  Text('EventsView'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
