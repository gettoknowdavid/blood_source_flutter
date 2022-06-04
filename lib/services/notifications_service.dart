import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:stacked/stacked.dart';

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

class NotificationsService with ReactiveServiceMixin {
  NotificationsService() {
    listenToReactiveValues([onNotification]);
  }

  final ReactiveValue<String?> onNotification = ReactiveValue<String?>('');
  String? get onNotificationValue => onNotification.value;

  static final _fln = FlutterLocalNotificationsPlugin();

  static const _details = NotificationDetails(
    android: AndroidNotificationDetails(
      'channel id',
      'channel name',
      channelDescription: 'channel description',
      importance: Importance.max,
    ),
    iOS: IOSNotificationDetails(),
  );

  Future init({bool scheduled = false}) async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOS = IOSInitializationSettings();
    const settings = InitializationSettings(android: android, iOS: iOS);

    await _fln.initialize(settings, onSelectNotification: (payload) async {});
  }

  Future show({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    await _fln.show(id, title, body, _details, payload: payload);
  }

  void onClickedNotification(String? payload) {}
}
