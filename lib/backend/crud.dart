import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

import '../main.dart';

class Crud {
  static getRequest(String url) async {
    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        "Content-Type": "application/json",
        "Accept": "/",
        "Authorization": "Bearer ${userModel.token}"
      });
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return responseBody;
      } else {
        print("response error ${response.body}");
        MainFunctions.somethingWentWrongSnackBar(
            "response error ${response.statusCode}");

        return null;
      }
    } catch (e) {
      // print("catch error f apii $e");
      // MainFunctions.somethingWentWrongSnackBar( );

      return null;
    }
  }

  static postRequest(String url, Map data) async {
    try {
      http.Response response =
          await http.post(Uri.parse(url), body: json.encode(data), headers: {
        "Content-Type": "application/json",
        "Accept": "*/*",
        "Authorization": "Bearer ${userModel.token}"
      });
      var responseBody = jsonDecode(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return responseBody;
      } else {
        return responseBody;
      }
    } catch (e) {
      Get.back();

      MainFunctions.somethingWentWrongSnackBar("$e");
      e.printError();

      print("api errrror");

      return null;
    }
  }

  static postRequestWithFile(String url, Map data, File image) async {
    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));
      request.headers.addAll({
        "Content-Type": "application/json",
        "Accept": "*/*",
        "Authorization": "Bearer ${userModel.token}"
      });
      var length = await image.length();
      var stream = http.ByteStream(image.openRead());

      var multipartFile = http.MultipartFile("image", stream, length,
          filename: basename(image.path));
      request.files.add(multipartFile);
      var myRequest = await request.send();
      http.Response response = await http.Response.fromStream(myRequest);

      var responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return responseBody;
      } else {
        return responseBody;
      }
    } catch (e) {
      Get.back();

      MainFunctions.somethingWentWrongSnackBar("$e");
      print(e.toString());

      print("api errrror");

      return null;
    }
  }

  static postRequestWithFileWithData(
      String url, Map<String, String> data, File file) async {
    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));
      request.headers.addAll({
        "Content-Type": "application/json",
        "Accept": "*/*",
        "Authorization": "Bearer ${userModel.token}"
      });
      var length = await file.length();
      var stream = http.ByteStream(file.openRead());

      var multipartFile = http.MultipartFile("file", stream, length,
          filename: basename(file.path));
      request.files.add(multipartFile);
      request.fields['_method'] = 'put';

      var myRequest = await request.send();
      http.Response response = await http.Response.fromStream(myRequest);

      var responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return responseBody;
      } else {
        return responseBody;
      }
    } catch (e) {
      Get.back();

      MainFunctions.somethingWentWrongSnackBar("$e");
      e.printError();
      print("api errrror");

      return null;
    }
  }

  static postRequestAuth(String url, Map data) async {
    try {
      http.Response response =
          await http.post(Uri.parse(url), body: json.encode(data), headers: {
        "Content-Type": "application/json",
        "Accept": "*/*",
        "Authorization": "Bearer ${userModel.token}"
      });

      var responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return responseBody;
      } else {
        return responseBody;
      }
    } catch (e) {
      Get.back();

      MainFunctions.somethingWentWrongSnackBar("$e");
      print(e.toString());

      print("api errrror");

      return null;
    }
  }

  static putRequest(String url, Map data) async {
    try {
      http.Response response =
          await http.put(Uri.parse(url), body: json.encode(data), headers: {
        "Content-Type": "application/json",
        "Accept": "*/*",
        "Authorization": "Bearer ${userModel.token}"
      });
      print(response.body);
      var responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return responseBody;
      } else {
        return responseBody;
      }
    } catch (e) {
      MainFunctions.somethingWentWrongSnackBar("$e");
      print("errrror");

      return null;
    }
  }

  static deleteRequest(String url) async {
    try {
      http.Response response = await http.delete(Uri.parse(url), headers: {
        "Content-Type": "application/json",
        "Accept": "*/*",
        "Authorization": "Bearer ${userModel.token}"
      });
      var responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return responseBody;
      } else {
        return responseBody;
      }
    } catch (e) {
      print(e);
      MainFunctions.somethingWentWrongSnackBar("$e");
      print("errrror");

      return null;
    }
  }
}
