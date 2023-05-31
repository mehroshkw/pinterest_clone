import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinterest_clone/extensions/context_extension.dart';
import 'package:pinterest_clone/ui_screens/bottom_navigaton/bottom_nav_bloc.dart';
import 'package:pinterest_clone/ui_screens/bottom_navigaton/bottom_nav_state.dart';

import '../../../data_handler/snackbar_message.dart';
import '../../../helpers/dilogue_helper.dart';
import '../../../helpers/material_dialogue_content.dart';
import '../../../helpers/snackbar_helper.dart';
import '../../../utils/app_colours.dart';
import '../../../utils/app_strings.dart';
import '../../reusable_widgets/app_button.dart';
import '../../reusable_widgets/app_text_field.dart';

class AddScreen extends StatelessWidget {
  static const String key_title = '/add';

  const AddScreen({Key? key}) : super(key: key);

  Future<void> upload(BottomNavBloc bloc, BuildContext context,
      MaterialDialogHelper dialogHelper) async {
    dialogHelper
      ..injectContext(context)
      ..showProgressDialog("Uploading...");
    try {
      final response = await bloc.uploadPin();
      dialogHelper.dismissProgress();
      final snackbarHelper = SnackbarHelper.instance..injectContext(context);

      if (response == false) {
        snackbarHelper.showSnackbar(
            snackbar: SnackbarMessage.error(message: "Error Uploading"));
        return;
      }
      snackbarHelper.showSnackbar(
          snackbar: SnackbarMessage.success(message: "Pin Uploaded Successfully!"));

    } catch (_) {
      dialogHelper.dismissProgress();
      dialogHelper.showMaterialDialogWithContent(
          MaterialDialogContent.networkError(),
              () => upload(bloc, context, dialogHelper));
    }
  }


  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    final bloc = context.read<BottomNavBloc>();

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50,),
        BlocBuilder<BottomNavBloc, BottomNavState>(
            builder: (_, state) => GestureDetector(
              onTap: () {
                final image = bloc.pickImage();
              },
              child: Container(
                height: 300,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  image: bloc.imageFile == null
                      ? null
                      : DecorationImage(
                    image: FileImage(File(bloc.imageFile!.path)),
                    fit: BoxFit.cover,
                  ),
                ),
                child: bloc.imageFile == null
                    ? const Icon(Icons.add, size: 50)
                    : null,
              ),
              ),
            ),
            const SizedBox(height: 20,),
            const Text("Title",
                style: TextStyle(
                    fontFamily: AppFonts.helveticaBold,
                    color: AppColours.colorTextLight,
                    fontSize: 10)),
            BlocBuilder<BottomNavBloc, BottomNavState>(
              builder: (_, state) => AppTextField(
                  controller: bloc.titleController,
                  hint: "Give Your Pin a Title",
                  textInputType: TextInputType.text,
                  isError: false),
            ),
            const SizedBox(height: 10,),
            const Text("Description",
                style: TextStyle(
                    fontFamily: AppFonts.helveticaBold,
                    color: AppColours.colorTextLight,
                    fontSize: 10)),
            BlocBuilder<BottomNavBloc, BottomNavState>(
              builder: (_, state) => AppTextField(
                  controller: bloc.descriptionController,
                  hint: "Give Your Pin a Description",
                  textInputType: TextInputType.text,
                  isError: false),
            ),
            SizedBox(
                height: 40,
                width: 400,
                child: AppButton(
                    textColor: AppColours.colorOnPrimary,
                    color: AppColours.colorPrimary,
                    text: 'Upload',
                    onClick: () {
                      context.unfocus();
                      upload(bloc, context, MaterialDialogHelper.instance());
                    })),
          ],
        ),
      ),

    );
  }
}
