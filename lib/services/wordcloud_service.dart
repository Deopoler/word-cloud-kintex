import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

class WordCloudService {
  static const String baseURL = "https://word-cloud-kintex-api.onrender.com/";
  static String? location;

  static Future<Uint8List> getWordCloudImage(imageByte, albumNum) async {
    try {
      // var formData = FormData.fromMap(
      //     {'file': MultipartFile.fromBytes(imageByte), 'album': albumNum});

      // final response = await Dio().post(baseURL,
      //     data: formData, options: Options(responseType: ResponseType.bytes));

      final uri = Uri.parse(baseURL);
      var request = http.MultipartRequest('POST', uri);
      final httpImage =
          http.MultipartFile.fromBytes('file', imageByte, filename: 'file.png');
      request.files.add(httpImage);
      request.fields['album'] = albumNum.toString();
      final streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        try {
          var map = jsonDecode(response.body) as Map;
          print(map['error']);
          throw Exception(map['error']);
        } on FormatException {
          print('success');
          return response.bodyBytes;
        }
      } else {
        throw Exception("Status Code is not 200");
      }
    } catch (error) {
      print(error);
      throw Exception(error);
    }
  }
}
