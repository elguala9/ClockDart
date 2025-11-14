import 'package:clock_dart/clock_dart.dart';

void main() {
  final clock = NTPClock();
  print('Current time: ${clock.now()}');
}
