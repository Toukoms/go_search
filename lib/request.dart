import 'package:http/http.dart' as http;
import 'dart:convert';

http.Client client = http.Client();

String host = "172.20.10.1";
String port = "3000";

Future<Map?> searchIntoWiki(label) async {
  if (label != '') {
    Uri url = Uri.http('$host:$port', '/api/v1/wiki/$label');

    http.Response _response = await client.post(url);
    // print(_response.body);
    Map valueMap = json.decode(_response.body);
    // print(valueMap);
    return valueMap;
  }
  return null;
}

Future<Map?> searchIntoGoogle(label) async {
  if (label != '') {
    Uri url = Uri.http('$host:$port', '/api/v1/google/$label');

    http.Response _response = await client.post(url);
    // print(_response.body);
    Map valueMap = json.decode(_response.body);
    // print(valueMap);
    return valueMap;
  }
  return null;
}
