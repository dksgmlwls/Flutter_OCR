import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthProvider with ChangeNotifier {
  static final secureStorage = FlutterSecureStorage();
  String? auth;
  String? email;

  bool get isAuth {
    checkAuthenticate();
    return auth != null;
  }

  String get isEmail {
    return email!;
  }

  // 1. 로그인
  Future<void> login(String? email, String? password) async {
    final url = Uri.parse('http://211.107.210.141:3000/users/login');
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {'email': email, 'password': password},
        ),
      );
      if (response.statusCode == 201) {
        final extractedDate = jsonDecode(response.body)['uid'].toString();
        await secureStorage.write(key: "auth", value: extractedDate);
        await secureStorage.write(key: "email", value: email);
        auth = extractedDate;
        notifyListeners();
      } else if(response.statusCode == 301) {
        print("로그인-301에러 // 모든 항목을 기입하지 않음");
        throw Error;
      } else if(response.statusCode == 302) {
        print("로그인-302에러 // 가입되지 않은 이메일");
        throw Error;
      } else if(response.statusCode == 303) {
        print("로그인-303에러 // 비밀번호 틀림");
        throw Error;
      } else if(response.statusCode == 401) {
        print("로그인-401에러 // 쿼리 에러");
        throw Error;
      }
    } catch (error) {
      throw error;
    }
  }

  // 2. 로그아웃
  Future<void> logout() async {
    auth = null;
    await secureStorage.delete(key: "auth");
    notifyListeners();
  }

  // 3. 회원가입
  Future<void> signUp(String email, String password, String name, String phoneNumber) async {
    final url = Uri.parse('http://211.107.210.141:3000/users/signup');
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {'email': email, 'password': password, 'name': name, 'phone': phoneNumber},

        ),
      );
      if (response.statusCode == 201) {
        notifyListeners();
      } else if(response.statusCode == 301) {
        print("로그인-301에러 // 모든 항목을 기입하지 않음");
        throw Error;
      } else if(response.statusCode == 302) {
        print("로그인-302에러 // 이메일 중복");
        throw Error;
      } else if(response.statusCode == 401) {
        print("로그인-401에러 // 쿼리 에러");
        throw Error;
      }
    } catch (error) {
      throw error;
    }
  }

  // 4. 비밀번호 변경
  Future<void> changePassword(String currentPassword, String changePassword) async {
    final url = Uri.parse('http://192.168.0.7:4000/api/User/modify/pw');
    final uid = await secureStorage.read(key: 'auth');
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'uid': int.parse(uid),
            'pw': currentPassword,
            'new': changePassword
          },
        ),
      );
      if (response.statusCode == 200) {
        notifyListeners();
      } else {
        throw Exception;
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> findId(String phoneNumber) async {
    final url = Uri.parse('http://192.168.0.7:4000/api/User/find/id');
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {'phone': phoneNumber},
        ),
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final email = responseData['id'];
        await FlutterSecureStorage().write(key: "email", value: email);
      } else {
        throw Exception;
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> findPassword(String email) async {
    final url = Uri.parse('http://192.168.0.7:4000/api/User/find/pw');
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {'email': email},
        ),
      );
      if (response.statusCode == 200) {
      } else {
        throw Exception;
      }
    } catch (error) {
      throw error;
    }
  }

  // 4. 로그인 여부 확인
  Future<void> checkAuthenticate() async {
    auth = await secureStorage.read(key: "auth");
  }

  // 5. 사진전송
  Future<void> sendImage(String path) async {
    final url = Uri.parse('https://211.107.210.141:3000/ocrs/uploadimg');
    try {
      final response = await http.post(
        url,
        body: {'img' : path},
      );
      if (response.statusCode == 201) {
        notifyListeners();
      } else if(response.statusCode == 301) {
        print("이미지 업로드 실패 // 이미지가 없음");
        throw Error;
      }
    } catch (error) {
      throw error;
    }
  }
}

