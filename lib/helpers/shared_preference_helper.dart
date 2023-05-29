import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? _sharedPreferences;

@immutable
class SharedPreferenceHelper {
  static const String _USER = 'SharedPreferenceHelper._user';
  static const String _EMPLOYEE = 'SharedPreferenceHelper._employee';
  static const String _LANGUAGE = 'language';

  static const SharedPreferenceHelper _instance = SharedPreferenceHelper._();

  const SharedPreferenceHelper._();

  factory SharedPreferenceHelper() => _instance;

  static Future<void> initializeSharedPreferences() async => _sharedPreferences = await SharedPreferences.getInstance();

  bool get isUserLoggedIn => _sharedPreferences?.containsKey(_USER) ?? false;
  bool get isEmployeeLoggedIn => _sharedPreferences?.containsKey(_EMPLOYEE) ?? false;
  //
  // Future<LoginResponse?> get user async {
  //   final userSerialization = _sharedPreferences?.getString(_USER);
  //   if (userSerialization == null) return null;
  //   try {
  //     return LoginResponse.fromJson(json.decode(userSerialization));
  //   } catch (_) {
  //     return null;
  //   }
  // }
  //
  // void setLanguage({bool? isLanguage}) {
  //   _sharedPreferences?.setBool(_LANGUAGE, isLanguage ?? true);
  // }
  //
  // bool get getLanguage {return _sharedPreferences?.getBool(_LANGUAGE) ?? true;
  // }
  //
  // Future<LoginResponse?> get employee async {
  //   final employeeSerialization = _sharedPreferences?.getString(_EMPLOYEE);
  //   if (employeeSerialization == null) return null;
  //   try {
  //     return LoginResponse.fromJson(json.decode(employeeSerialization));
  //   } catch (_) {
  //     return null;
  //   }
  // }
  //
  // Future<void> insertUser(LoginResponse user) async {
  //   final userSerialization = json.encode(user.toJson());
  //   _sharedPreferences?.setString(_USER, userSerialization);
  // }
  //
  // Future<void> insertEmployee(LoginResponse employee) async {
  //   final employeeSerialization = json.encode(employee.toJson());
  //   _sharedPreferences?.setString(_EMPLOYEE, employeeSerialization);
  // }
  //
  // Future<void> clear() async => _sharedPreferences?.clear();
}