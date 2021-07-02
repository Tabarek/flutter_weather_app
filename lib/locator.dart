import 'package:get_it/get_it.dart';
import 'package:weather/api/api_call.dart';

/// Simple Service Locator for Dart and Flutter projects.
/// It can be used instead of InheritedWidget or Provider
/// to access objects.
GetIt locator = GetIt.instance;

void setupLocator() {
  ///[registerLazySingleton] removed when it unnecessary anymore
  /// and load when it necessary
  locator.registerLazySingleton<ApiCalls>(() => ApiCalls());
}
