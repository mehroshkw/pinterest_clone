import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinterest_clone/extensions/context_extension.dart';
import 'package:pinterest_clone/ui_screens/category/category_bloc.dart';

import '../bottom_navigaton/nav_items/home_screen.dart';
import '../image_view/image_view_screen.dart';

class CategoryScreen extends StatelessWidget {
  static const String route = '/category_screen';

  String category;
  CategoryScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    final bloc = context.read<CategoryBloc>();

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Expanded(
            child: FutureBuilder(
                future: bloc.getCatApi(category),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
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
}
