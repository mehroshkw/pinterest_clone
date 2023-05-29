import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import '../image_view/image_view_state.dart';
import 'package:http/http.dart' as http;



class ImageFullViewBloc extends Cubit<ImageViewState> {


  ImageFullViewBloc():super(const ImageViewState.initial());

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
}
