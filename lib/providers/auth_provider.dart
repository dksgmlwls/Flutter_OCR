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
  Future<void> login(String? id, String? password) async {
    final url = Uri.parse('https://211.107.210.141:3000/users/login/');
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {'Email': id, 'pw': password},
        ),
      );
      if (response.statusCode == 200) {
        final extractedDate = jsonDecode(response.body)['uid'].toString();
        await secureStorage.write(key: "auth", value: extractedDate);
        await secureStorage.write(key: "userEmail", value: id);
        auth = extractedDate;
        notifyListeners();
      } else {
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
  Future<void> signUp(
      String name, String phoneNumber, String email, String password) async {
    final url = Uri.parse('https://211.107.210.141:3000/users/signup/');
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {'email': email, 'pw': password, 'name': name, 'phone': phoneNumber},
        ),
      );
      if (response.statusCode == 200) {
        notifyListeners();
      } else {
        throw Error;
      }
    } catch (error) {
      throw error;
    }
  }

  // 4. 비밀번호 변경
  Future<void> changePassword(
      String currentPassword, String changePassword) async {
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
}
