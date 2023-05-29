import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinterest_clone/extensions/context_extension.dart';
import 'package:pinterest_clone/network_provider/photos_model.dart';
import 'package:pinterest_clone/ui_screens/image_view/image_view_bloc.dart';
import 'package:pinterest_clone/ui_screens/image_view/image_view_state.dart';
import 'package:pinterest_clone/ui_screens/img_full_screen_view/img_full_screen_view.dart';
import 'package:pinterest_clone/utils/app_colours.dart';


class ImageViewScreen extends StatelessWidget {
  static const String route = '/image_view';
  final Photo photo;

  const ImageViewScreen({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    // final photo  = imgPath as Photo;
    final size = context.screenSize;
    final bloc = context.read<ImageViewBloc>();
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Hero(
                tag: photo,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height/1.3,
                  width: MediaQuery.of(context).size.width,
                  child: CachedNetworkImage(
                          imageUrl: photo.src!.portrait!,
                          placeholder: (context, url) => Container(
                            color: const Color(0xfff5f8fd),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            backgroundColor: AppColours.colorTextLight.withOpacity(0.5),
                            fixedSize: const Size(30,30)
                        ),
                        child: const Icon(Icons.arrow_back_ios_new_rounded, size: 20,)),
                    IconButton(onPressed: (){
                      _showModalBottomSheet(context);
                    }, icon: const Icon(Icons.more_horiz, size: 30, color: AppColours.colorOnPrimary,))
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              height: size.height,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children:  [
                      CircleAvatar(
                        backgroundColor: AppColours.colorTextLight.withOpacity(0.4),
                      child:CachedNetworkImage(
                        imageUrl: photo.url!,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                          ),
                        ),
                        placeholder: (context, url) => const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => const Icon(Icons.error_outline, color: AppColours.colorError, ),
                      ),
                      ),
                      Padding(padding: const EdgeInsets.all(8.0),
                      child: Text(
                        photo.photographer! ?? "photographer name",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                       Expanded(child: BlocBuilder<ImageViewBloc, ImageViewState>(builder: (_, state) =>
                        IconButton(
                            onPressed: (){
                              bloc.toggleFavourite();
                            },
                            icon: Icon(state.isFavourite? Icons.favorite : Icons.favorite_border, color: state.isFavourite ? AppColours.colorPrimary : AppColours.onScaffoldColor,)),
                      )),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, ImageFullViewScreen.route, arguments:photo.src!.portrait! );
                            //Navigator.pop(context);
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width / 5,
                              height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: AppColours.colorTextLight.withOpacity(0.1)
                              ),
                              child: const Text(
                                "View",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ))),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: InkWell(
                            onTap: () {
                              bloc.saveImg(photo.src!.portrait!);
                              //Navigator.pop(context);
                            },
                            child: Container(
                                width: MediaQuery.of(context).size.width / 5,
                                height: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border:
                                  Border.all(color: Colors.white24, width: 1),
                                  borderRadius: BorderRadius.circular(40),
                                  color: AppColours.colorPrimary,
                                ),
                                child: const Text(
                                  "Save",
                                  style: TextStyle(
                                      color: AppColours.scaffoldColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ))),
                      ),
                      Expanded(child: IconButton(onPressed: () async {
                        final filePath = photo.src!.portrait!;
                        print('Sharing file: $filePath');
                        bloc.shareImageFromUrl(filePath);
                      }, icon: const Icon(Icons.share)))
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );

  }
  void _showModalBottomSheet(context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      context: context,
      builder: (BuildContext) {
        return SizedBox(
          height: 300,
          child: Wrap(
            children: [
              ListTile(
                leading: IconButton(onPressed: ()=>Navigator.pop(context),
                    padding: const EdgeInsets.all(1.0),
                    constraints: const BoxConstraints(
                      minWidth: 0,
                      minHeight: 0,
                    ),
                    icon: const Icon(Icons.close, size: 30, color: AppColours.onScaffoldColor,)),
                title: const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text('Options',
                  style: TextStyle(
                    fontFamily: AppColours.helveticaRegular,
                    fontSize: 16,
                    color: Colors.black
                  ),
                  ),
                ),
                enabled: false,
                onTap: () => {},
                splashColor: Colors.transparent,
              ),
              ListTile(
                title: const Text('Copy link',
                style: TextStyle(
                  fontFamily: AppColours.NHaasGroteskMedium,
                  fontSize: 18
                ),
                ),
                onTap: () => {},
              ),
              ListTile(
                title: const Text('Download image',
                  style: TextStyle(
                      fontFamily: AppColours.NHaasGroteskMedium,
                      fontSize: 18
                  ),
                ),
                onTap: () => {
                ImageViewBloc().saveImg(photo.src!.portrait!)
                },
              ),
              ListTile(
                title: const Text('Set Pin as Wallpaper',
                  style: TextStyle(
                      fontFamily: AppColours.NHaasGroteskMedium,
                      fontSize: 18
                  ),
                ),
                onTap: () => {
                  ImageViewBloc().setWallpaperFromFile(photo.src!.portrait!),
                  Fluttertoast.showToast(
                      msg: "Wallpaper Applied to Home Screen",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      textColor: Colors.white,
                      fontSize: 16.0),
                },
              ),
              ListTile(
                title: const Text('Report Pin',
                  style: TextStyle(
                      fontFamily: AppColours.NHaasGroteskMedium,
                      fontSize: 18
                  ),
                ),
                subtitle: const Text("This goes against Pinterest's Community"),
                onTap: () => {},
              ),
            ],
          ),
        );
      },
    );
  }


}
