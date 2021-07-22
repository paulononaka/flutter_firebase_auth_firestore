import 'package:intl/intl.dart';
import 'string_extension.dart';

extension DateTimeExtension on DateTime {
  String get mMMMdyyyy => DateFormat('MMMM d yyyy').format(this).capitalizedString;
  String get mMMMdyyyyHHmma => DateFormat('MMMM d yyyy – HH:mm a').format(this).capitalizedString;
}
