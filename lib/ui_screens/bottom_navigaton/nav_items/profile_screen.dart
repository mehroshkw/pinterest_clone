import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinterest_clone/extensions/context_extension.dart';
import 'package:pinterest_clone/ui_screens/bottom_navigaton/bottom_nav_state.dart';
import 'package:pinterest_clone/ui_screens/image_view/myImages.dart';
import 'package:pinterest_clone/ui_screens/reusable_widgets/app_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/app_colours.dart';
import '../../image_view/image_view_screen.dart';
import '../bottom_nav_bloc.dart';
import 'home_screen.dart';

class ProfileScreen extends StatelessWidget {
  static const String key_title = '/profile';

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    final bloc = context.read<BottomNavBloc>();
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    Widget buildSavedStreamBuilder() {
      return BlocBuilder<BottomNavBloc, BottomNavState>(
        builder: (_, state) => Container(
            height: size.height / 2,
            width: size.width,
            child: StreamBuilder<QuerySnapshot>(
              stream: firestore
                  .collection('savedimages')
                  .where('userEmail',
                      isEqualTo: bloc
                          .userEmail) // Replace 'userEmail' with the actual user's email
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error Loading Saved Images'),
                  );
                } else if (snapshot.hasData) {
                  final documents = snapshot.data!.docs;
                  return GridView.builder(
                    padding: EdgeInsets.zero,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 1.21 / 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 5,
                    ),
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            MyImageViewScreen.route,
                            arguments: documents[index].get('imageUrl'),
                          );
                        },
                        child: ImageWidget(
                          url: documents[index].get('imageUrl'),
                          widget: const Icon(Icons.more_horiz),
                          name: '',
                        ),
                      );
                    },
                  );
                }

                return const SizedBox(); // Return an empty SizedBox as a fallback
              },
            )),
      );
    }

    Widget buildCreatedStreamBuilder() {
      return BlocBuilder<BottomNavBloc, BottomNavState>(
        builder: (_, state) => SizedBox(
            height: size.height / 2,
            width: size.width,
            child: StreamBuilder<QuerySnapshot>(
              stream: firestore
                  .collection('created_pin')
                  .where('email',
                      isEqualTo: bloc
                          .userEmail) // Replace 'userEmail' with the actual user's email
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error Loading Saved Images'),
                  );
                } else if (snapshot.hasData) {
                  final documents = snapshot.data!.docs;
                  return GridView.builder(
                    padding: EdgeInsets.zero,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 1.21 / 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 5,
                    ),
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            MyImageViewScreen.route,
                            arguments: documents[index].get('imageUrl'),
                          );
                        },
                        child: ImageWidget(
                          url: documents[index].get('imageUrl'),
                          widget: const Icon(Icons.more_horiz),
                          name: '',
                        ),
                      );
                    },
                  );
                }

                return const SizedBox(); // Return an empty SizedBox as a fallback
              },
            )),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(
          Icons.poll_outlined,
          color: AppColours.colorBackground,
        ),
        actions: [
          const Icon(
            Icons.share,
            color: AppColours.colorBackground,
          ),
          const SizedBox(
            width: 10,
          ),
          const Icon(
            Icons.more_horiz,
            color: AppColours.colorBackground,
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: (){
              bloc.logoutUser();
            },
            child: const Icon(
              Icons.logout,
              color: AppColours.colorBackground,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: BlocBuilder<BottomNavBloc, BottomNavState>(
        builder: (_, state) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                future: bloc.getUserData(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasData) {
                    final userData = snapshot.data!.data();
                    final userName = userData?['name'] as String?;
                    final imgUrl = userData?['imgUrl'] as String?;
                    // Render the user data
                    return Column(
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              width: 120,
                              height: 120,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppColours.colorPrimary,
                                        width: 1,
                                      )),
                                  child: CachedNetworkImage(
                                    imageUrl: imgUrl!,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          userName!,
                          style: const TextStyle(
                              color: AppColours.onScaffoldColor,
                              fontSize: 18,
                              fontFamily: AppFonts.helveticaBold),
                        ),
                      ],
                    );
                  }
                  return const Center(
                    child: Text('Data not Found'),
                  );
                }),
            const SizedBox(height: 10),

            const SizedBox(
              height: 50,
            ),
            // Add buttons for selecting saved or created
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                  width: 100,
                  child: AppButton(
                    onClick: () {
                      bloc.toggleIsSavedSelected();
                      // state.isSavedSelected = true;
                    },
                    color: AppColours.colorOnPrimary,
                    text: 'Saved',
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 40,
                  width: 100,
                  child: AppButton(
                    onClick: () {
                      bloc.toggleIsSavedSelected();
                      // state.isSavedSelected = true;
                    },
                    color: AppColours.colorOnPrimary,
                    text: 'Created',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Render the corresponding StreamBuilder based on selection
            Expanded(
              child: state.isSavedSelected
                  ? buildSavedStreamBuilder()
                  : buildCreatedStreamBuilder(),
            ),
          ],
        ),
      ),
    );
  }
}
