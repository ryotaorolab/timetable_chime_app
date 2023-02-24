import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:just_audio/just_audio.dart';

// import 'package:audio_session/audio_session.dart';
import 'package:wondertime/Start.dart';
import 'Start3.dart';

void main() async {
  _setupTimeZone();
  // runApp(TimerApp());
  runApp(new MaterialApp(
    home: new Start(),
  ));
}

// タイムゾーンを設定する
Future<void> _setupTimeZone() async {
  tz.initializeTimeZones();
  var tokyo = tz.getLocation('Asia/Tokyo');
  tz.setLocalLocation(tokyo);
}

/// タイマーアプリ
class TimerApp extends StatelessWidget {
  const TimerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '授業ピコーん',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TimerPage(title: 'Life cycle Event Sample Timer'),
    );
  }
}

/// タイマーページ
class TimerPage extends StatefulWidget {
  TimerPage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _TimerPageState createState() => _TimerPageState();
}

/// タイマーページの状態を管理するクラス
class _TimerPageState extends State<TimerPage> with WidgetsBindingObserver {
  var now = DateTime.now(); //日付(曜日) 時刻

  // 初期化処理
  @override
  void initState() {
    // FlutterBackgroundService.initialize(_DateTimenow);
    // FlutterBackgroundService.in
    setState(_DateTimenow);
    nowDateTime_str = DateFormat('(E) hh:mm').format(now);
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _init();
    //音源再生の初期設定
    _setupSession();
    _cancelNotification();
    _requestPermissions();
  }

  //通知処理　ここから
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _init() async {
    await _configureLocalTimeZone();
    await _initializeNotification();
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName!));
  }

  Future<void> _initializeNotification() async {
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_notification');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _cancelNotification() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> _requestPermissions() async {
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    NotificationAddTimeEvent();
  }

  Future<void> _registerMessage({
    required int month,
    required int day,
    required int hour,
    required int minutes,
    required message,
    required int notificationid,
  }) async {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      month,
      day,
      hour,
      minutes,
    );
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      notificationid,
      '授業時間のお知らせ',
      message,
      scheduledDate,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'channel id',
          'channel name',
          importance: Importance.max,
          priority: Priority.high,
          ongoing: false,
          styleInformation: BigTextStyleInformation(message),
          icon: 'ic_notification',
        ),
        iOS: const DarwinNotificationDetails(
          badgeNumber: 1,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> _registerMessageTest({
    required int hour,
    required int minutes,
    required int second,
    required message,
  }) async {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minutes,
      second,
    );
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      21,
      '通知テスト',
      message,
      scheduledDate,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'channel id',
          'channel name',
          importance: Importance.max,
          priority: Priority.high,
          ongoing: false,
          styleInformation: BigTextStyleInformation(message),
          icon: 'ic_notification',
        ),
        iOS: const DarwinNotificationDetails(
          badgeNumber: 1,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  //通知処理　ここまで

  late AudioPlayer _player;
  double _currentSliderValue = 1.0;

  //音源再生の処理
  Future<void> _setupSession() async {
    _player = AudioPlayer();
    await _loadAudioFile();
  }

  Future<void> _loadAudioFile() async {
    await _player.setAsset('assets/audio/chimeaudio.mp3'); // アセット(ローカル)のファイル
  }

  Future<void> Classchimeaudios() async {
    // 再生終了状態の場合、新たなオーディオファイルを定義し再生できる状態にする
    if (_player.processingState == ProcessingState.completed) {
      await _loadAudioFile();
    }

    await _player.setSpeed(_currentSliderValue); // 再生速度を指定
    await _player.play();
  }

  /// ライフサイクルが変更された際に呼び出される関数をoverrideして、変更を検知
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // バックグラウンドに遷移した時
      setState(_DateTimenow);
    } else if (state == AppLifecycleState.resumed) {
      // フォアグラウンドに復帰した時
      // setState(_handleOnResumed);
      setState(_DateTimenow);
      //通知処理
      FlutterAppBadger.removeBadge();
    }
  }

  String nowDateTime_str = "";

  _DateTimenow() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        now = DateTime.now();
        nowDateTime_str = DateFormat('(E) hh:mm').format(now);
      });
      CloseClassAnnounce();
    });
  }

  List<bool> AnnounceOnlyOnce = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  String WeekofDay = "";
  String is_ClassOpening = "";
  String MyClassStatus = "";

  bool NotificationSwitch = true;

  Future<void> CloseClassAnnounce() async {
    String TodayWeekofDay = DateFormat('E').format(now);

    //開講曜日の確認
    if (TodayWeekofDay == "Wed" ||
        TodayWeekofDay == "Thu" ||
        TodayWeekofDay == "Fri") {
      //平日なら
      is_ClassOpening = "平日開講";
    } else if (TodayWeekofDay == "Sat" || TodayWeekofDay == "Sun") {
      //土日なら
      is_ClassOpening = "土日開講";
    } else {
      is_ClassOpening = "休み";
    }

    WeekofDay = TodayWeekofDay;

    //アプリをずっと起動している場合の知らせる処理
    if (is_ClassOpening == "平日開講") {
      MyClassStatus = "平日授業";
      if (nowDateTime_str == "(" + WeekofDay + ") 05:20" &&
          AnnounceOnlyOnce[0] == false) {
        Classchimeaudios();
        AnnounceOnlyOnce[0] = true;
      }
      if (nowDateTime_str == "(" + WeekofDay + ") 07:10" &&
          AnnounceOnlyOnce[1] == false) {
        Classchimeaudios();
        AnnounceOnlyOnce[1] = true;
      }
      if (nowDateTime_str == "(" + WeekofDay + ") 09:00" &&
          AnnounceOnlyOnce[2] == false) {
        Classchimeaudios();
        AnnounceOnlyOnce[2] = true;
      }
    }
    if (is_ClassOpening == "土日開講") {
      MyClassStatus = "土日時間割";
      if (nowDateTime_str == "(" + WeekofDay + ") 11:30" &&
          AnnounceOnlyOnce[3] == false) {
        Classchimeaudios();
        AnnounceOnlyOnce[3] = true;
      }
      if (nowDateTime_str == "(" + WeekofDay + ") 01:20" &&
          AnnounceOnlyOnce[4] == false) {
        Classchimeaudios();
        AnnounceOnlyOnce[4] = true;
      }
      if (nowDateTime_str == "(" + WeekofDay + ") 04:10" &&
          AnnounceOnlyOnce[5] == false) {
        Classchimeaudios();
        AnnounceOnlyOnce[5] = true;
      }
      if (nowDateTime_str == "(" + WeekofDay + ") 06:00" &&
          AnnounceOnlyOnce[6] == false) {
        Classchimeaudios();
        AnnounceOnlyOnce[6] = true;
      }
    }
    if (is_ClassOpening == "休み") {
      MyClassStatus = "お休みです";

      //Debug用
      // if(nowDateTime_str == "(" + WeekofDay + ") 11:11" && AnnounceOnlyOnce[7] == false) {
      //   print("Hello");
      //   // _notificationId = _scheduleLocalNotification(_time.difference(DateTime.utc(0, 0, 0)));
      //   AnnounceOnlyOnce[7] = true;
      //   await Classchimeaudios();
      // }
    }
  }

  void NotificationAddTimeEvent() {
    //日付の取得
    int TodayMonth = int.parse(DateFormat('MM').format(now));
    int TodayYear = int.parse(DateFormat('dd').format(now));

    if (is_ClassOpening == "平日開講") {
      //平日開講の時刻をすべて通知に登録する
      if (NotificationSwitch == false) {
        _registerMessage(
            month: TodayMonth,
            day: TodayYear,
            hour: 15,
            minutes: 50,
            message: "1コマ目の授業が始まりました！",
            notificationid: 0);
        _registerMessage(
            month: TodayMonth,
            day: TodayYear,
            hour: 17,
            minutes: 10,
            message: "授業残り10分前です！FBに取り組みましょう！",
            notificationid: 1);
        _registerMessage(
            month: TodayMonth,
            day: TodayYear,
            hour: 17,
            minutes: 20,
            message: "授業終了です！",
            notificationid: 2);
        _registerMessage(
            month: TodayMonth,
            day: TodayYear,
            hour: 17,
            minutes: 40,
            message: "2コマ目の授業が始まりました！",
            notificationid: 3);
        _registerMessage(
            month: TodayMonth,
            day: TodayYear,
            hour: 19,
            minutes: 00,
            message: "授業残り10分前です！FBに取り組みましょう！",
            notificationid: 4);
        _registerMessage(
            month: TodayMonth,
            day: TodayYear,
            hour: 19,
            minutes: 10,
            message: "授業終了です！",
            notificationid: 5);
        _registerMessage(
            month: TodayMonth,
            day: TodayYear,
            hour: 19,
            minutes: 30,
            message: "3コマ目の授業が始まりました！",
            notificationid: 6);
        _registerMessage(
            month: TodayMonth,
            day: TodayYear,
            hour: 20,
            minutes: 50,
            message: "授業残り10分前です！FBに取り組みましょう！",
            notificationid: 7);
        _registerMessage(
            month: TodayMonth,
            day: TodayYear,
            hour: 21,
            minutes: 00,
            message: "授業終了です！",
            notificationid: 8);
      }
    }
    if (is_ClassOpening == "土日開講") {
      if (NotificationSwitch == false) {
        _registerMessage(
            month: TodayMonth,
            day: TodayYear,
            hour: 10,
            minutes: 00,
            message: "授業が始まりました！",
            notificationid: 9);
        _registerMessage(
            month: TodayMonth,
            day: TodayYear,
            hour: 11,
            minutes: 20,
            message: "授業残り10分前です！FBに取り組みましょう！",
            notificationid: 10);
        _registerMessage(
            month: TodayMonth,
            day: TodayYear,
            hour: 11,
            minutes: 30,
            message: "授業終了です！",
            notificationid: 11);
        _registerMessage(
            month: TodayMonth,
            day: TodayYear,
            hour: 11,
            minutes: 50,
            message: "授業が始まりました！",
            notificationid: 12);
        _registerMessage(
            month: TodayMonth,
            day: TodayYear,
            hour: 13,
            minutes: 10,
            message: "授業残り10分前です！FBに取り組みましょう！",
            notificationid: 13);
        _registerMessage(
            month: TodayMonth,
            day: TodayYear,
            hour: 13,
            minutes: 20,
            message: "授業終了です！",
            notificationid: 14);
        _registerMessage(
            month: TodayMonth,
            day: TodayYear,
            hour: 14,
            minutes: 40,
            message: "授業が始まりました！",
            notificationid: 15);
        _registerMessage(
            month: TodayMonth,
            day: TodayYear,
            hour: 16,
            minutes: 00,
            message: "授業残り10分前です！FBに取り組みましょう！",
            notificationid: 16);
        _registerMessage(
            month: TodayMonth,
            day: TodayYear,
            hour: 16,
            minutes: 10,
            message: "授業終了です！",
            notificationid: 17);
        _registerMessage(
            month: TodayMonth,
            day: TodayYear,
            hour: 16,
            minutes: 30,
            message: "授業が始まりました！",
            notificationid: 18);
        _registerMessage(
            month: TodayMonth,
            day: TodayYear,
            hour: 17,
            minutes: 50,
            message: "授業残り10分前です！FBに取り組みましょう！",
            notificationid: 19);
        _registerMessage(
            month: TodayMonth,
            day: TodayYear,
            hour: 18,
            minutes: 00,
            message: "授業終了です！",
            notificationid: 20);
      }
    }
  }

  String NotificationSwitchText = "通知をオンにする";

  void NotificationSwitchControll() {
    setState(() {
      if (NotificationSwitch == false) {
        _cancelNotification(); //await
        NotificationSwitchText = '通知をオンにする';
        NotificationSwitch = true;
      } else {
        NotificationSwitchText = '通知をオフにする';
        NotificationSwitch = false;
        NotificationAddTimeEvent();
        // showDialog関数を呼び出す
        showDialog(
          context: context,
          builder: (context) {
            // AlertDialogをビルドする
            return AlertDialog(
              title: Text('通知をオンにしました'),
              content: Text('今日の授業開始時間と終了する10分前、授業終了時間になったら通知を出す設定にしました。通知を出すには、アプリを終了または別のアプリ'
                  'に切り替える必要があります。'),
              actions: [
                TextButton(
                  onPressed: () {
                    // ダイアログを閉じる
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    });
  }

  int notificationtestmessagenum = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(flex: 4),
          //タイマーの時刻表示
          Text(
            MyClassStatus,
            style: Theme.of(context).textTheme.headline4,
          ),
          Text(
            nowDateTime_str,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // FloatingActionButton(
              //   child: Text("Start"),
              // ),
            ],
          ),
          ElevatedButton(
            onPressed: () async {
              // final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
              // await _registerMessage(
              //   hour: now.hour,
              //   minutes: now.minute + 1,
              //   message: 'Hello, world!',
              // );
              NotificationSwitchControll();
            },
            child: Text(NotificationSwitchText),
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              elevation: 0,
              onPrimary: Colors.blue,
            )
          ),
          Text(
              "通知をオンにするボタンを押すと、通知が来るようになります。バイトを始める前にアプリを起動して、通知をオンにするというボタンを押してください。",
              textAlign: TextAlign.center),
          Spacer(flex: 1),
          ElevatedButton(
            onPressed: () async {
              if (notificationtestmessagenum == 3) {
                notificationtestmessagenum = 0;
              }
              String notificationmessagelocal = "";
              notificationtestmessagenum += 1;
              if (notificationtestmessagenum == 1) {
                notificationmessagelocal = "1コマ目の授業が始まりました！";
              } else if (notificationtestmessagenum == 2) {
                notificationmessagelocal = "授業残り10分前です！FBに取り組みましょう！";
              } else if (notificationtestmessagenum == 3) {
                notificationmessagelocal = "授業終了です！";
              }
              final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
              print(now.hour);
              await _registerMessageTest(
                hour: now.hour,
                minutes: now.minute,
                second: now.second + 10,
                message: notificationmessagelocal,
              );
            },
            child: const Text('【テスト】通知を10秒後に送る'),
          ),

          // ElevatedButton(onPressed: () async{ await Classchimeaudios();}, child: const Text("音を鳴らす"),)
          SizedBox(height: 15),
          ElevatedButton(
              onPressed: () {
                Classchimeaudios();
                print(NotificationSwitch);
              },
              child: const Text("【テスト】チャイムを再生")),
          Spacer(flex: 1),
          Text('機能', style: TextStyle(fontWeight: FontWeight.bold)),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Start3()));
              },
              child: const Text("使い方をみる")),
          Spacer(flex: 3),
          Text("Made by よっち"),
          Spacer(flex: 1),
        ],
      ),
    );
  }
}
