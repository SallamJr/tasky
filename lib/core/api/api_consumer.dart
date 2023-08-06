import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class BaseApiConsumer {
  Future<http.StreamedResponse> get(
    String path, {
    String? token,
  });

  Future<http.StreamedResponse> post(
    String path, {
    Map<String, dynamic>? body,
    String? token,
    bool attachment = false,
    String? attachmentKey,
    String? attachmentPath,
  });

  Future<http.StreamedResponse> put(
    String path, {
    Map<String, dynamic>? body,
    String? token,
  });

  Future<http.StreamedResponse> delete(
    String path, {
    String? token,
  });
}

class ApiConsumer implements BaseApiConsumer {
  @override
  Future<http.StreamedResponse> get(String path, {String? token}) async {
    late Map<String, String> headers;
    if (token != null) {
      headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
    } else {
      headers = {'Content-Type': 'application/json'};
    }
    var request = http.Request('GET', Uri.parse(path));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    return response;
  }

  @override
  Future<http.StreamedResponse> post(
    String path, {
    Map<String, dynamic>? body,
    String? token,
    bool attachment = false,
    String? attachmentKey,
    String? attachmentPath,
  }) async {
    late Map<String, String> headers;
    if (token != null) {
      headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
    } else {
      headers = {'Content-Type': 'application/json'};
    }

    if (attachment) {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(path),
      );

      final Map<String, String> map =
          Map.castFrom<String, dynamic, String, String>(body!);

      request.fields.addAll(map);

      request.files.add(
        await http.MultipartFile.fromPath(attachmentKey!, attachmentPath!),
      );

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      return response;
    } else {
      var request = http.Request('POST', Uri.parse(path));
      request.body = json.encode(body);

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      return response;
    }
  }

  @override
  Future<http.StreamedResponse> put(String path,
      {Map<String, dynamic>? body, String? token}) async {
    late Map<String, String> headers;
    if (token != null) {
      headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
    } else {
      headers = {'Content-Type': 'application/json'};
    }
    var request = http.Request('PUT', Uri.parse(path));
    request.body = json.encode(body);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    return response;
  }

  @override
  Future<http.StreamedResponse> delete(String path, {String? token}) async {
    late Map<String, String> headers;
    if (token != null) {
      headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
    } else {
      headers = {'Content-Type': 'application/json'};
    }
    var request = http.Request('DELETE', Uri.parse(path));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    return response;
  }
}
