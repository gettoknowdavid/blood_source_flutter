import 'package:stacked/stacked.dart';

class NotificationsViewModel extends BaseViewModel {
  Future<void> init() async {}

  final ReactiveValue<List<Notification>?> _notifications =
      ReactiveValue<List<Notification>?>([]);

  List<Notification>? get notifications => _notifications.value;

  Future longUpdateStuff() async {}
}

class Notification {
  Notification(this.message);
  final String message;
}
