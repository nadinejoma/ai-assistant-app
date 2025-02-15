import 'package:appwrite/appwrite.dart';
import '../helper/global.dart';
import 'dart:developer';
class AppWrite {
  static final  _client = Client();
  static final _database = Databases(_client);
static void init(){

_client.setProject('674c16e2003beb7106cf');
}

  static Future<String> getApiKey() async {
    try {
      final d = await _database.getDocument(
          databaseId: 'MyDatabase',
          collectionId: 'ApiKey',
          documentId: 'geminikey');

      apiKey = d.data['apiKey'];
      log(apiKey);
      return apiKey;
    } catch (e) {
      log('$e');
      return '';
    }
  }

}