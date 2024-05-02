import 'package:directus_test/directus/models/user_directus_model.dart';
import 'package:flutter/foundation.dart';

import 'di/injection_container.dart';
import 'directus/configuration.dart';
import 'main.reflectable.dart';

Future<void> main() async {
  initializeReflectable();
  await setupInjectors();
  final directus = getIt<DirectusConfiguration>();
  DirectusFunctions directusFunctions = DirectusFunctions();
  await directusFunctions.loginUser(directus.apiManager);
  final result = await directusFunctions
      .fetchAllFromCollection<UserDirectusModel>(directus.apiManager);
  for (var element in result) {
    if (kDebugMode) {
      print(element.id);
    }
  }
}
