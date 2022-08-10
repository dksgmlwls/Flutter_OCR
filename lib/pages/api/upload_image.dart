import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; //쿠퍼티노 위젯
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import '../home_page.dart';
submit_uploadimg(dynamic file) async {
  String filename = "no";
  try {
    print("try to _sssssubmit!!");
    Response res = await uploadimg(file.path);

    switch(res.statusCode){
      case 200:
        final jsonbody = res.data;       // ex) {"result":[335,"1111-11-11","2022_08_10_14_57_16.jpg"]}
        filename = jsonbody['result'][2]; // ex) "2022_08_10_14_57_16.jpg"
        Image.network('http://211.107.210.141:3000/'+filename);
        break;
      case 201:
        break;
      case 202:
        break;
      default:
        break;
    }

    return filename;
  } catch (error) {
    print("error");
    return filename;
  }
}
uploadimg(String imagePath) async {
  Dio dio = new Dio();
  try {
    dio.options.contentType = 'multipart/form-data';
    dio.options.maxRedirects.isFinite;
    String fileName = imagePath.split('/').last;

    print(fileName);
    FormData _formData = FormData.fromMap({
      "Image" : await MultipartFile.fromFile(imagePath,
          filename: fileName, contentType:MediaType("image","jpg")),
    });
    Response response = await dio.post(
        'http://211.107.210.141:3000/ocrs/uploadimg/',
        data:_formData
    );
    print(response);

    final jsonBody = response.data;
    return response;
  } catch (e) {
    Exception(e);
  } finally {
    dio.close();
  }
  // return 0;

}