
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; //쿠퍼티노 위젯
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import '../home_page.dart';

//late List<dynamic> array = List.filled(30, "",growable: true);
late List<String> array = List.filled(35, "",growable: true);
late List<String> array_graph = List.filled(8, "", growable: true);


receiveresult(){
  print(array);
  return array;
}
//
// receiveresult_graph(){
//   print("서버에서 그래프 가져올 함수임");
//   print(array_graph);
//   print("서버에서 그래프 가져왔나잉?????/");
//   return array_graph;
// }


submit_uploadimg_front(dynamic file) async {
  String filename = "no";
  try {
    //print("임신사 이미지 전송 함");
    Response res = await uploadimg_front(file.path);

    switch(res.statusCode){
      case 200:
        final jsonbody = res.data;       // ex) {"result":[335,"1111-11-11","2022_08_10_14_57_16.jpg"]}
        filename = jsonbody['result'][37]; // ex) "2022_08_10_14_57_16.jpg"
        array = jsonbody['result'];
        print("array is ?");
        print(array);
        print("임신사 이미지 전송 함");
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

submit_uploadimg_back(dynamic file) async {
  String filename = "no";
  try {
    // print("분만사 이미지 전송 함");
    Response res = await uploading_back(file.path);

    switch(res.statusCode){
      case 200:
        final jsonbody = res.data;       // ex) {"result":[335,"1111-11-11","2022_08_10_14_57_16.jpg"]}
        filename = jsonbody['result'][37]; // ex) "2022_08_10_14_57_16.jpg"
        array = jsonbody['result'];
        print("array is ?");
        print(array);
        print("분만사 이미지 전송 함");
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

uploadimg_front(String imagePath) async {
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
        'http://211.107.210.141:4000/ocrs/uploadimg/front/',
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

uploading_back(String imagePath) async {
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
        'http://211.107.210.141:3001/ocrs/uploadimg/back',
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