# clock_dart

Orologio Dart con supporto NTP e singleton.

## Installazione

Aggiungi al tuo `pubspec.yaml`:
```yaml
dependencies:
  clock_dart: ^1.0.0
```

## Utilizzo

```dart
import 'package:clock_dart/clock_dart.dart';

void main() {
  final clock = NTPClock();
  print('Current time: [32m${clock.now()}[0m');
}
```

## Licenza
LGPL-3.0
