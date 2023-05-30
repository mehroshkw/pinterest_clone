import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinterest_clone/ui_screens/auth/sign_up/signup_state.dart';

class SignupBloc extends Cubit<SignupState> {
  SignupBloc():super(const SignupState.initial());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> createAccount(String name, String email, String password, int age, String country) async {
    final user = await _auth.createUserWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
    final firestore = FirebaseFirestore.instance;
    firestore.collection('users').doc(user.user!.uid).set(
        {
          "name": nameController.text,
          "age": ageController.text,
          "country": countryController.text,
          "email": emailController.text,
          "password": passwordController.text});
    if (user != null) {
      return true;
    } else {
      print('error');
      return false;
    }
  }

}
