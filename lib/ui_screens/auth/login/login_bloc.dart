import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinterest_clone/ui_screens/auth/login/login_state.dart';
import 'package:pinterest_clone/ui_screens/auth/sign_up/signup_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Cubit<LoginState> {
  LoginBloc() : super(const LoginState.initial());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void togglePassword() =>
      emit(state.copyWith(isNotShowPassword: !state.isNotShowPassword));

  void updateEmailError(bool value, String errorText) =>
      emit(state.copyWith(emailError: value, errorText: errorText));

  void updatePasswordError(bool value, String errorText) =>
      emit(state.copyWith(passwordError: value, errorText: errorText));

  Future<bool> login(String email, String password) async {
    try {
      final authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password);
      if (authResult.user != null) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString("email", emailController.text.toString());
        return true;
      } else {
        print('Login failed');
        return false;
      }
    } catch (error) {
      print('Error during login: $error');
      return false;
    }
  }
}
