import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gofoods/model/input/signupinput.dart';
import 'package:gofoods/services/api_v1.dart';
import 'package:gofoods/utils/const.dart';

class AuthService {
  const AuthService();

  ///
  /// Send login request
  Future<SignUpInput?> signUpRequest(SignUpInput input) async {
    print(input.toMap());
    final response = await ApiV1Service.postRequest(
      '/consumer/register',
      data: input.toMap(),
    );
    if ((response.statusCode ?? 400) > 300) {
      return null;
    }
    // print(response.statusCode);
    // print(response.toString());
    await saveCookie(response);
    return SignUpInput.fromMap(response.data['user']);
  }

  /// Save cookies after sign in/up
  Future<void> saveCookie(Response response) async {
    List<Cookie> cookies = [Cookie("token", response.data['token'])];
    final cj = await ApiV1Service.getCookieJar();
    await cj.saveFromResponse(Uri.parse(constant.apiUrl), cookies);
  }

  ///
  Future<void> signOut() async {
    await clearCookies();
    await FirebaseAuth.instance.signOut();
  }

  /// Clear cookies before log out
  Future<void> clearCookies() async {
    final cj = await ApiV1Service.getCookieJar();
    await cj.deleteAll();
  }

  /// Send sign in request
  ///
  Future<SignUpInput?> signInRequest(SignUpInput input) async {
    print(input.phoneNumber);
    print(input.password);
    final response = await ApiV1Service.postRequest(
      '/consumer/login',
      data: {
        'phoneNumber': input.phoneNumber,
        'password': input.password,
      },
    );
    if ((response.statusCode ?? 400) > 300) {
      return null;
    }
    // print(response.toString());
    await saveCookie(response);
    return SignUpInput.fromMap(response.data['user']);
  }

  ///password change request
  ///
  Future<bool> PasswordChangeRequest(
      String oldPassword, String newPassword, String confirmPassword) async {
    final response = await ApiV1Service.putRequest(
      '/password/update',
      data: {
        'oldPassword': oldPassword,
        'newPassword': newPassword,
        'confirmPassword': confirmPassword,
      },
    );
    if ((response.statusCode ?? 400) > 300) {
      return false;
    }
    return true;
  }

  ///password change request
  ///
  Future<bool> ForgotPasswordChangeRequest(
      String newPassword, String confirmPassword, String phoneNumber) async {
    // print(newPassword + " " + confirmPassword + " " + phoneNumber);
    final response = await ApiV1Service.putRequest(
      '/password/reset',
      data: {
        'newPassword': newPassword,
        'confirmPassword': confirmPassword,
        'phoneNumber': phoneNumber,
      },
    );
    if ((response.statusCode ?? 400) > 300) {
      return false;
    }
    return true;
  }
}
