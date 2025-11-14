part of 'clock_dart.dart';

/// Classe di test per NTPClock, usata solo nei test
class TestNTPClock extends NTPClock {
  TestNTPClock({List<String>? ntpServers, int secondsJobRefresh = 600}) : super._(ntpServers: ntpServers, secondsJobRefresh: secondsJobRefresh);
  void startRefreshJob(int secondsJobRefresh) {
    refreshJob(secondsJobRefresh);
  }
}
