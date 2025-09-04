// import 'package:flutter_native_timezone/flutter_native_timezone.dart';
// import 'package:timezone/data/latest_all.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

// Future<void> initTimeZone() async {
//   tz.initializeTimeZones();
//   try {
//     final String name = await FlutterNativeTimezone.getLocalTimezone();
//     tz.setLocalLocation(tz.getLocation(name));
//   } catch (_) {
//     // fallback لو حصل خطأ
//     tz.setLocalLocation(tz.getLocation('UTC'));
//   }
// }
