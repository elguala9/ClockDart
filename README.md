# clock_dart

Orologio per Dart con supporto NTP

`clock_dart` è una libreria che fornisce una semplice interfaccia per ottenere l'orario corrente, sia dal sistema locale che da server NTP affidabili. Supporta il pattern singleton, la configurazione dei server NTP e l'aggiornamento automatico.

## Funzionalità
- Orologio di sistema (`SystemClock`)
- Orologio sincronizzato via NTP (`NTPClock`)
- Supporto a più server NTP (NTP Pool, NIST, Cloudflare, Google)
- Singleton per ogni implementazione
- Aggiornamento automatico dell'orario
- Facile da testare

## Installazione
Aggiungi al tuo `pubspec.yaml`:
```yaml
dependencies:
  clock_dart: ^1.0.0
```
Esegui:
```sh
dart pub get
```

## Utilizzo
```dart
import 'package:clock_dart/clock_dart.dart';

void main() async {
  final clock = NTPClock();
  await clock.refresh(); // Sincronizza con NTP
  print('Orario corrente: ${clock.now()}');
}
```

## Licenza
LGPL-3.0

## Contributi
Pull request e segnalazioni sono benvenute!

## Repository
[https://github.com/elguala9/ClockDart](https://github.com/elguala9/ClockDart)
