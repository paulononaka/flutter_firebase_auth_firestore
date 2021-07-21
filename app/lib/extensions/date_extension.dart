import 'package:intl/intl.dart';
import 'string_extension.dart';

extension DateTimeExtension on DateTime {
  String get mMMMdyyyy => DateFormat('MMMM d yyyy').format(this).capitalizedString;
}
