import 'package:directus_api_manager/directus_api_manager.dart';

@DirectusCollection()
@CollectionMetadata(endpointName: "Posts")
class PostDirectusModel extends DirectusItem {
  PostDirectusModel.newItem(
      {required String user,
      required String date_published,
      required String description})
      : super.newItem() {
    setValue(user, forKey: "user");
    setValue(datePublished, forKey: "date_published");
    setValue(description, forKey: "description");
  }

  PostDirectusModel(Map<String, dynamic> rawReceivedData)
      : super(rawReceivedData);

  String get user => getValue(forKey: "user");

  String get datePublished => getValue(forKey: "date_published");

  String get description => getValue(forKey: "description");
}
