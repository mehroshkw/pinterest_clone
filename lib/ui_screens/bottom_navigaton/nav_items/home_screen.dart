import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinterest_clone/extensions/context_extension.dart';
import 'package:pinterest_clone/utils/app_colours.dart';
import '../../image_view/image_view_screen.dart';
import '../bottom_nav_bloc.dart';

class HomeScreen extends StatelessWidget {
  static const String key_title = '/home';

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    final bloc = context.read<BottomNavBloc>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              alignment: Alignment.centerLeft,
              child: const Text(
                "All",
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: AppFonts.NHaasGrotesk_bold,
                    color: AppColours.onScaffoldColor),
              )),
          const Padding(
            padding: EdgeInsets.only(left: 4.0, right: 0, bottom: 8),
            child: Divider(
              color: AppColours.onScaffoldColor,
              endIndent: 310,
              thickness: 4,
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: bloc.getApi(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return
                        //   GridView.custom(
                        //   padding: EdgeInsets.zero,
                        //   gridDelegate: SliverWovenGridDelegate.count(
                        //     crossAxisCount: 2,
                        //     mainAxisSpacing: 20,
                        //     crossAxisSpacing: 0,
                        //     pattern: [
                        //       const WovenGridTile(0.6),
                        //       const WovenGridTile(
                        //         5.05 / 7.7,
                        //         crossAxisRatio: 1.0,
                        //         alignment: AlignmentDirectional.centerEnd,
                        //       ),
                        //     ],
                        //   ),
                        //   childrenDelegate: SliverChildBuilderDelegate(
                        //     childCount: snapshot.data!.photos!.length,
                        //         (context, index) => ImageWidget(
                        //             url: "${snapshot.data!.photos![index]!.src!.portrait}", widget: null, name: 'name',
                        //         ),
                        //   ),
                        // );

                        GridView.builder(
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    childAspectRatio: 1.21/2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 5),
                            itemCount: snapshot.data!.photos!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: (){
                                  Navigator.pushNamed(context, ImageViewScreen.route, arguments:snapshot.data!.photos![index]!);
                                },
                                child: ImageWidget(
                                    url: '${snapshot.data!.photos![index]!.src!.portrait}',
                                    widget:const Icon(Icons.more_horiz),
                                    name: '${snapshot.data!.photos![index]!.photographer}'),
                              );
                            });
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }

  List<String> imageUrls = [
    'https://i.pinimg.com/564x/9a/4b/8b/9a4b8b6d4369ef5e5bbc9bc3451de664.jpg',
    'https://wallpaper.dog/large/20469482.jpg',
    'https://i.pinimg.com/564x/9a/4b/8b/9a4b8b6d4369ef5e5bbc9bc3451de664.jpg',
    'https://wallpaper.dog/large/20469482.jpg',
    'https://i.pinimg.com/564x/9a/4b/8b/9a4b8b6d4369ef5e5bbc9bc3451de664.jpg',
    'https://i.pinimg.com/564x/9a/4b/8b/9a4b8b6d4369ef5e5bbc9bc3451de664.jpg',
    'https://wallpaper.dog/large/20469482.jpg',
    'https://i.pinimg.com/564x/9a/4b/8b/9a4b8b6d4369ef5e5bbc9bc3451de664.jpg',
    'https://wallpaper.dog/large/20469482.jpg',
  ];
}

class ImageWidget extends StatelessWidget {
  final String url;
  final String name;
  final Widget? widget;

  ImageWidget({required this.url, required this.widget, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              url,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                      fontFamily: AppFonts.helveticaRegular, fontSize: 14),
                ),
                Container(
                  child: widget,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
