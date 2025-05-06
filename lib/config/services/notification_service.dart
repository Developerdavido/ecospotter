
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

const String signUpNotificationChannelId = "sign_up_notification_channel_id";
const String signUpNotificationChannel = "sign_up_notification_channel";

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  //initialize the notification plugin
  Future<void> init() async {
    //Initialize native android notification
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    //Initialize native Ios notification
    const DarwinInitializationSettings darwinInitializationSettings =
    DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true);

    const InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: darwinInitializationSettings);


    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    tz.initializeTimeZones();
  }
  //create a notification when user first signs up for the app

  void showNotification(int notificationId,
      {String? title, String? body}) async {
    //for android notification details
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
        signUpNotificationChannelId, signUpNotificationChannel,
        channelDescription:
        "This should show notifications for sign up when user signs up for the first time",
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');

    const DarwinNotificationDetails darwinNotificationDetails =
    DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      badgeNumber: null,
    );
    const NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        notificationId, title, body, notificationDetails);
  }

  /* create a scheduled notification to remind user every week about certain
  *  events and that they should apply
  * */

  void createScheduleNotification(int notificationId, {String? title, String? body, Duration? duration}) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(notificationId, title,
        body,
        tz.TZDateTime.now(tz.local).add(duration!),
        const NotificationDetails(
            android: AndroidNotificationDetails("CHANNEL_ID", "CHANNEL_NAME",
                channelDescription: "CHANNEL_DESCRIPTION"),
            iOS: DarwinNotificationDetails(
                presentAlert: true,
                presentSound: true,
                presentBadge: true
            )
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
  }
}