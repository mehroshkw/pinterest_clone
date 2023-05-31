import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinterest_clone/ui_screens/auth/sign_up/signup_state.dart';

class SignupBloc extends Cubit<SignupState> {
  SignupBloc() : super(const SignupState.initial());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void togglePassword() =>
      emit(state.copyWith(isNotShowPassword: !state.isNotShowPassword));

  void toggleConfirmPassword() => emit(state.copyWith(
      isNotShowConfirmPassword: !state.isNotShowConfirmPassword));

  void updateNameError(bool value, String errorText) =>
      emit(state.copyWith(nameError: value, errorText: errorText));

  void updateAgeError(bool value, String errorText) =>
      emit(state.copyWith(ageError: value, errorText: errorText));

  void updateEmailError(bool value, String errorText) =>
      emit(state.copyWith(emailError: value, errorText: errorText));

  void updatePasswordError(bool value, String errorText) =>
      emit(state.copyWith(passwordError: value, errorText: errorText));

  void updateCountryError(bool value, String errorText) =>
      emit(state.copyWith(countryError: value, errorText: errorText));

  Future<bool> createAccount(String name, String email, String password,
      String age, String country) async {
    final user = await _auth.createUserWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
    final firestore = FirebaseFirestore.instance;
    firestore.collection('users').doc(user.user!.uid).set({
      "name": nameController.text,
      "age": ageController.text,
      "country": countryController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "imgUrl": ""
    });
    if (user != null) {
      return true;
    } else {
      print('error');
      return false;
    }
  }
}
