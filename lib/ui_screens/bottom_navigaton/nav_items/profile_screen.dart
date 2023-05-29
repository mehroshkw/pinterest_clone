import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinterest_clone/extensions/context_extension.dart';
import '../bottom_nav_bloc.dart';

class ProfileScreen extends StatelessWidget {
  static const String key_title = '/profile';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    final bloc = context.read<BottomNavBloc>();

    return Scaffold(
   body:Column(
     children: [
       
     ],
   )
    );
  }
}

