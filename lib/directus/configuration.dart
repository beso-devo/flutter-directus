import 'package:directus_api_manager/directus_api_manager.dart';
import 'package:directus_test/di/injection_container.dart';
import 'package:injectable/injectable.dart';
import 'models/user_directus_model.dart';

@LazySingleton()
class DirectusConfiguration {
  final apiManager = DirectusApiManager(baseURL: "http://192.168.1.144:8055/");
}

class DirectusFunctions {
  Future loginUser(DirectusApiManager directusAPI) async {
    // Authenticate
    final loginResult =
        await directusAPI.loginDirectusUser("admin@example.com", "root");

    /// Only Admins
    final user = await directusAPI
        .getDirectusUser('9c4bc763-41c5-4b98-a87e-ac53d19969ba');
    print(user!.fullName);

    /// **** ///

    if (loginResult.type == DirectusLoginResultType.success) {
      print(loginResult.type.name);
      await directusAPI.currentDirectusUser().then((value) {
        print("${value!.fullName} - ${value.id}");
      });

      print("User logged in");
    } else if (loginResult.type == DirectusLoginResultType.invalidCredentials) {
      print("Please verify entered credentials");
    } else if (loginResult.type == DirectusLoginResultType.invalidOTP) {
      print("You need to provide a valid OneTimePassword code");
    } else if (loginResult.type == DirectusLoginResultType.error) {
      print("An unknown error occured");
      final additionalMessage = loginResult.message;
      if (additionalMessage != null) {
        print("More information : $additionalMessage");
      }
    }
  }

  Future<List<T>> fetchAllFromCollection<T extends DirectusItem>(
      DirectusApiManager directusAPI) async {
    final list = await directusAPI.findListOfItems<T>();
    List<T> data = [];
    for (final item in list) {
      data.add(item);
    }
    final id = list.first.id;
    if (id == null) {
      return [];
    }
    return data;
  }

  Future<DirectusItem?> createNewCollectionItem<T extends DirectusItem>(
      DirectusApiManager directusAPI, DirectusItem directusItem) async {
    final creationResult =
        await directusAPI.createNewItem(objectToCreate: directusItem);
    if (creationResult.isSuccess) {
      print("Item created!");
      final createdItem = creationResult.createdItem;
      if (createdItem != null) {
        return createdItem;
      } else {
        return null;
      }
    } else {
      final error = creationResult.error;
      if (error != null) {
        print("Error while creating createdItem : $error");
        return null;
      }
      return null;
    }
  }

  Future<DirectusItem?> fetchCollectionItemById<T extends DirectusItem>(
      DirectusApiManager directusAPI, String itemId) async {
    final T? fetchedItem = await directusAPI.getSpecificItem(id: itemId);
    if (fetchedItem != null) {
      return fetchedItem;
    } else {
      return null;
    }
  }

  Future<DirectusItem?> updateCollectionItem<T extends DirectusItem>(
          DirectusApiManager directusAPI, DirectusItem updatedItem) async =>
      await directusAPI.updateItem(objectToUpdate: updatedItem);

  cLL() async {
    await fetchAllFromCollection<UserDirectusModel>(
        getIt<DirectusConfiguration>().apiManager);
  }
}
