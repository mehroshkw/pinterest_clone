import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinterest_clone/network_provider/photos_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../network_provider/shared_web_service.dart';
import 'bottom_nav_state.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;



class BottomNavBloc extends Cubit<BottomNavState> {

  BuildContext? textFieldContext;
  Key inputKey = GlobalKey();
  final GlobalKey globalKey = GlobalKey(debugLabel: 'btm_app_bar');
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  List<Photos> photos = [];

  final FirebaseAuth _auth = FirebaseAuth.instance;


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

  XFile? imageFile;

  Future<XFile?> pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    imageFile = pickedImage!;
    print("======================================>$pickedImage");
    return pickedImage;
  }

  Future<String> uploadImage(XFile imageFile) async {
    // Generate a unique filename for the uploaded image
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    // Create a reference to the storage location where the image will be uploaded
    firebase_storage.Reference storageRef = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('images/$fileName');

    // Get the bytes of the image file
    List<int> imageBytes = await imageFile.readAsBytes();

    // Convert the imageBytes to Uint8List
    Uint8List uint8List = Uint8List.fromList(imageBytes);

    // Upload the image bytes to the storage location
    await storageRef.putData(uint8List);

    // Get the download URL of the uploaded image
    String downloadURL = await storageRef.getDownloadURL();

    // Return the download URL
    return downloadURL;
  }
  Future<bool> uploadPin() async {
    final data = {
      "title": titleController.text,
      "email": userEmail,
      "desc": descriptionController.text,
    };

    if (imageFile != null) {
      String imageUrl = await uploadImage(imageFile!);
      data['imageUrl'] = imageUrl;
    }

    try {
      await FirebaseFirestore.instance
          .collection('created_pin')
          .add(data);
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<void> logoutUser() async {
    await _auth.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    // Get.offAll(LoginScreen());
  }

}