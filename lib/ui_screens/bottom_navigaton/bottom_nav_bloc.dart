import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinterest_clone/network_provider/photos_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data_handler/meta_data.dart';
import '../../network_provider/shared_web_service.dart';
import '../../utils/app_strings.dart';
import 'bottom_nav_state.dart';
import 'package:http/http.dart' as http;




class BottomNavBloc extends Cubit<BottomNavState> {

  BuildContext? textFieldContext;
  Key inputKey = GlobalKey();
  final GlobalKey globalKey = GlobalKey(debugLabel: 'btm_app_bar');
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController genreController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  List<Photos> photos = [];

  final SharedWebService _sharedWebService = SharedWebService.instance();
String? userEmail ="";

  BottomNavBloc() :super(const BottomNavState.initial()){
    getEmailfromSharedPref();
  }


  void updateIndex(int index) {
    emit(state.copyWith(index: index));
  }

  void toggleVote() {
    emit(state.copyWith(isVote: !state.isVote));
  }

  void toggleNotify() {
    emit(state.copyWith(isVote: !state.isVote));
  }

  void toggleIsSavedSelected() {
    emit(state.copyWith(isSavedSelected: !state.isSavedSelected));
  }

  getEmailfromSharedPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userEmail= preferences.getString('email');
  }


  Future<Photos?> getApi() async {
    final response = await http.get(
        Uri.parse("https://api.pexels.com/v1/search?query=all&per_page=100"),
        headers: {
          "Authorization": "563492ad6f917000010000012876927f901846cd8b5d658bbe09bcda"
        });
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return Photos.fromJson(data);
    } else {
      print("Error occured during api call");
      return Photos.fromJson(data);
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() {
    return FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: userEmail)
        .limit(1)
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> snapshot) {
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first;
      } else {
        throw Exception('User not found');
      }
    });
  }

}