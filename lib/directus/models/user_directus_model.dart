import 'package:directus_api_manager/directus_api_manager.dart';

@DirectusCollection()
@CollectionMetadata(endpointName: "users")
class UserDirectusModel extends DirectusItem {
  UserDirectusModel.newItem({required String email, required String status})
      : super.newItem() {
    setValue(email, forKey: "email");
    setValue(status, forKey: "status");
  }

  UserDirectusModel(Map<String, dynamic> rawReceivedData)
      : super(rawReceivedData);

  String get email => getValue(forKey: "email");

  String get status => getValue(forKey: "status");
}
