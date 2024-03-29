import 'package:http/http.dart' as http;

class ProjectNetworkManager {
  ProjectNetworkManager._() {
    _client = http.Client();
  }
  late final http.Client _client;

  static ProjectNetworkManager instance = ProjectNetworkManager._();

  http.Client get service => _client;
}
