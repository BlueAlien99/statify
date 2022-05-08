import 'package:http/http.dart' as http;
import 'package:statify/connector.dart';

const String _baseUri = 'https://api.spotify.com/v1';
const int _maxRetries = 1;

Future<http.Response> apiGet(String endpoint, {int retry = _maxRetries}) {
  return http.get(Uri.parse('$_baseUri$endpoint'), headers: {
    'Authorization': 'Bearer ${Connector().token}',
    'Content-Type': 'application/json'
  }).then((response) {
    if (retry <= 0) {
      return response;
    }

    switch (response.statusCode) {
      case 200:
        return response;
      case 400:
      case 401:
        return Connector().generateToken().then((_) => apiGet(endpoint, retry: retry - 1));
      // case 403:
      //   break;
      // case 429:
      //   break;
      default:
        return response;
    }
  });
}
