import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:loomus_app/data/repository/user_repository.dart';

import 'local_storage.dart';

class NotificationsService {
  final UserRepository userRepository;
  final LocalStorage localStorage;

  NotificationsService(this.userRepository, this.localStorage);

  void registerNotification() async {
    final messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      final token = await messaging.getToken();
      final tokenData = await localStorage.getTokenData();
      if (token == null || tokenData == null) return;
      userRepository.editDeviceToken(token, tokenData.refreshToken);
    }
  }
}
