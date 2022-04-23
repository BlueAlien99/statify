import 'package:http/http.dart' as http;
import 'package:statify/connector.dart';

const String _baseUri = 'https://api.spotify.com/v1';

Future<http.Response> apiGet(String endpoint) {
  return http.get(Uri.parse('$_baseUri$endpoint'), headers: {
    'Authorization': 'Bearer ${Connector().token}',
    'Content-Type': 'application/json'
  });
}
