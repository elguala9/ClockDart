import 'dart:async';
import 'package:meta/meta.dart';

import 'package:ntp/ntp.dart';
import 'i_clock_dart.dart';
import 'ntp_servers.dart';

part 'clock_dart_test_impl.dart';

/// Implementation of the Clock interface using NTP
class NTPClock implements Clock {
  static final NTPClock instance = NTPClock._(secondsJobRefresh: 600);
  int? _offset;
  final List<String> ntpServers;

  NTPClock._({required int secondsJobRefresh, List<String>? ntpServers})
      : ntpServers = ntpServers ?? NtpServers.allServers {
    refreshJob(secondsJobRefresh);
  }

  factory NTPClock({int secondsJobRefresh = 600, List<String>? ntpServers}) {
    if (ntpServers == null || ntpServers == NtpServers.allServers) {
      return instance;
    } else {
      // Se vuoi una lista custom, crea una nuova istanza
      return NTPClock._(secondsJobRefresh: secondsJobRefresh, ntpServers: ntpServers);
    }
  }

  @protected
  void refreshJob(int secondsJobRefresh){
    Timer.periodic(Duration(seconds: secondsJobRefresh), (timer) {
      refresh();
      // Puoi anche fermare il timer con timer.cancel();
    });
  }

  @override
  DateTime now() {
    if (_offset == null) {
      // If not refreshed yet, return system time
      return DateTime.now();
    }
    // Return current time adjusted by NTP offset
    return DateTime.now().add(Duration(milliseconds: _offset!));
  }

  @override
  Future<void> refresh() async {
    // Try each server until one succeeds
    for (final server in ntpServers) {
      try {
        _offset = await NTP.getNtpOffset(
          localTime: DateTime.now(),
          lookUpAddress: server,
        );
        return; // Success, exit early
      } catch (e) {
        // Try next server
        continue;
      }
    }
    // All servers failed, keep using system time
    _offset = 0;
  }
}

/// Implementation of the Clock interface using system time
class SystemClock implements Clock {
  static const SystemClock instance = SystemClock._();
  const SystemClock._();

  factory SystemClock() => instance;

  @override
  DateTime now() => DateTime.now();

  @override
  void refresh() {
    // System clock doesn't need refresh - it's always current
  }
}
