import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinterest_clone/extensions/context_extension.dart';
import '../../utils/app_colours.dart';
import 'img_full_view_bloc.dart';

class ImageFullViewScreen extends StatelessWidget {
  static const String route = '/img_full_view';

  final String imgPath;
  const ImageFullViewScreen({Key? key, required this.imgPath}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    final bloc = context.read<ImageFullViewBloc>();
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: imgPath,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: CachedNetworkImage(
                imageUrl: imgPath,
                placeholder: (context, url) => Container(
                  color: const Color(0xff7b7474),
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: size.width,
            height: size.height*0.15,
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: (){
                      bloc.shareImageFromUrl(imgPath);
                      // Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: AppColours.colorTextLight,
                        fixedSize: const Size(30,30)
                    ),
                    child: const Icon(Icons.share, size: 20,)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
