import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tinder_flutter_app/network/api_endpoints.dart';

//singleton class
class ApiClient {
  String host;
  static final ApiClient _apiClient = ApiClient._internal();

  ApiClient._internal() {
    host = ApiEndpoints.hostUrl;
  }

  factory ApiClient() {
    return _apiClient;
  }

  dynamic get(String path) async {
    final response = await http.get(getParsedUrl(path));
    return json.decode(response.body);
  }

  Uri getParsedUrl(String path) {
    return Uri.parse('$host$path');
  }
}
