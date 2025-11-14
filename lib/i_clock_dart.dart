/// Implementations of [Clock] should use the singleton pattern.
/// Example:
///   static final instance = MyClock._();
///   MyClock._();
/// This ensures only one instance exists in the app.
abstract interface class Clock {
  const Clock();
  // retrieve the current time
  DateTime now();
  // refresh from the server or other source
  void refresh();
}
