import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/files.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../data_handler/snackbar_message.dart';
import '../../helpers/snackbar_helper.dart';
import 'image_view_state.dart';
import 'package:http/http.dart' as http;



class ImageViewBloc extends Cubit<ImageViewState> {


  ImageViewBloc():super(const ImageViewState.initial());

  saveImg(String imgPath) async {
    final savedirectory = await getTemporaryDirectory();
    String imgurl = imgPath.toString();
    final imgpath = "${savedirectory.path}/image.png";
    await Dio().downloadUri(Uri.parse(imgurl), imgpath);
    GallerySaver.saveImage(imgpath).whenComplete(() {
      // print("Image Saved to Gallery");
      Fluttertoast.showToast(
          msg: "Image Saved To Gallery",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  Future<void> setWallpaperFromFile(String imgPath) async {
    bool result;
    var file = await DefaultCacheManager().getSingleFile(
        imgPath);
    try {
      result = (await WallpaperManager.setWallpaperFromFile(
          file.path, WallpaperManager.HOME_SCREEN));
      Fluttertoast.showToast(
          msg: "Wallpaper Applied to Home",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    } on PlatformException {
      result = false;
    }
    // if (!mounted) return ;
  }

  Future<void> shareImageFromUrl(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      final bytes = response.bodyBytes;
      // Share the image data
      await Share.share('Check out this amazing snap shared from my Pinterest clone! \n$imageUrl',
        subject: 'Check out this amazing snap',);
    } catch (e) {
      print('Error sharing image: $e');
    }
  }
  void toggleFavourite() {
    emit(state.copyWith(isFavourite:  !state.isFavourite));
  }

  Future<void> saveImagetoFS(String userEmail, String imageUrl, BuildContext context) async {
    final firestore = FirebaseFirestore.instance;
    try {
      await firestore.collection('savedimages').add({
        'userEmail': userEmail,
        'imageUrl': imageUrl,
        'timestamp': FieldValue.serverTimestamp(),
      });
      final snackbarHelper = SnackbarHelper.instance..injectContext(context);
      snackbarHelper.showSnackbar(
          snackbar: SnackbarMessage.success(message: "Image Saved Successfully"));
    } catch (error) {
      final snackbarHelper = SnackbarHelper.instance..injectContext(context);
      snackbarHelper.showSnackbar(
          snackbar: SnackbarMessage.error(message: "Error Saving Image"));
    }
  }
}
