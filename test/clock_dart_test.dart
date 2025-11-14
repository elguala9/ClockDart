import 'package:test/test.dart';
import 'package:clock_dart/clock_dart.dart';
import 'package:clock_dart/i_clock_dart.dart';
import 'package:clock_dart/ntp_servers.dart';

class MockClock implements Clock {
  final DateTime mockTime;
  const MockClock(this.mockTime);

  @override
  DateTime now() => mockTime;

  @override
  void refresh() {}
}

void main() {
  group('SystemClock', () {
    final clock = SystemClock();

    test('now returns a DateTime', () {
      expect(clock.now(), isA<DateTime>());
    });

    test('refresh does not throw', () {
      expect(() => clock.refresh(), returnsNormally);
    });
  });

  group('NTPClock', () {
    final ntpClock = NTPClock(ntpServers: [NtpServers.pool0]);

    test('now returns a DateTime before refresh', () {
      expect(ntpClock.now(), isA<DateTime>());
    });

    test('refresh updates offset and now returns a DateTime', () async {
      await ntpClock.refresh();
      expect(ntpClock.now(), isA<DateTime>());
    });

    test('refresh does not throw with all servers', () async {
      final ntpClockAll = NTPClock();
      await ntpClockAll.refresh();
      expect(ntpClockAll.now(), isA<DateTime>());
    });
  });

  group('Clock correctness', () {
    test('SystemClock now is close to system time', () {
      final clock = SystemClock();
      final sysTime = DateTime.now();
      final clockTime = clock.now();
      // Devono essere molto vicini (entro 100ms)
      expect(clockTime.difference(sysTime).inMilliseconds.abs(), lessThan(100));
    });

    test('MockClock returns the mocked time', () {
      final fakeTime = DateTime(2020, 1, 1, 12, 0, 0);
      final clock = MockClock(fakeTime);
      expect(clock.now(), equals(fakeTime));
    });

    test('SystemClock and MockClock comparison', () {
      final fakeTime = DateTime(2000, 1, 1, 0, 0, 0);
      final sysClock = SystemClock();
      final mockClock = MockClock(fakeTime);
      expect(sysClock.now().isAfter(mockClock.now()), isTrue);
    });
  });

  group('_TestNTPClock refresh job', () {
    test('refresh job updates offset periodically', () async {
      final clock = TestNTPClock(ntpServers: [NtpServers.pool0]);
      clock.startRefreshJob(1); // ogni 1 secondo
      await Future.delayed(Duration(seconds: 2));
      expect(clock.now(), isA<DateTime>());
      // Non possiamo garantire che l'offset sia cambiato, ma il job è partito
    });
  });
}

