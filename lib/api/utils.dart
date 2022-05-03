import 'package:http/http.dart' as http;
import 'package:statify/connector.dart';

const String _baseUri = 'https://api.spotify.com/v1';

Future<http.Response> apiGet(String endpoint) {
  return http.get(Uri.parse('$_baseUri$endpoint'), headers: {
    'Authorization': 'Bearer ${Connector().token}',
    'Content-Type': 'application/json'
  }).then((response) {
    switch (response.statusCode) {
      case 200:
        return response;
      case 401:
        return Connector().generateToken().then((_) => apiGet(endpoint));
      // case 403:
      //   break;
      // case 429:
      //   break;
      default:
        return response;
    }
  });
}
