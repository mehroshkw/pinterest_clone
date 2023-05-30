import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinterest_clone/ui_screens/auth/sign_up/signup_bloc.dart';
import 'package:pinterest_clone/ui_screens/reusable_widgets/app_text_field.dart';
import 'package:pinterest_clone/utils/app_colours.dart';

import '../../../data_handler/snackbar_message.dart';
import '../../../helpers/dilogue_helper.dart';
import '../../../helpers/material_dialogue_content.dart';
import '../../../helpers/snackbar_helper.dart';
import '../../../utils/app_strings.dart';
import '../login/login_screen.dart';

class SignupScreen extends StatelessWidget {
  static const String route = '/signup_screen';

  const SignupScreen({Key? key}) : super(key: key);

  Future<void> _signup(SignupBloc bloc, BuildContext context,
      MaterialDialogHelper dialogHelper) async {
    dialogHelper
      ..injectContext(context)
      ..showProgressDialog(AppText.CREATING_ACCOUNT);
    try {
      final response = await bloc.createAccount;
      dialogHelper.dismissProgress();
      final snackbarHelper = SnackbarHelper.instance..injectContext(context);

      if (response== false) {
        snackbarHelper.showSnackbar(
            snackbar: SnackbarMessage.error(message: "Error Signing Up"));
        return;
      }
      snackbarHelper.showSnackbar(
          snackbar: SnackbarMessage.success(
              message: AppText.SINGUP_SUCCESS));
      Future.delayed(const Duration(seconds: 1)).then((_) =>
          Navigator.pushNamedAndRemoveUntil(
              context, LoginScreen.route, (route) => false));
    } catch (_) {
      dialogHelper.dismissProgress();
      dialogHelper.showMaterialDialogWithContent(
          MaterialDialogContent.networkError(),
              () => _signup(bloc, context, dialogHelper));
    }
  }


  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SignupBloc>();

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(height: kToolbarHeight-20),
            Text("What's your name?", style: TextStyle(
              fontFamily: AppFonts.helveticaBold,
              color: AppColours.colorTextLight,
              fontSize: 16
            )),
            AppTextField(hint: "Name", textInputType: TextInputType.text, isError: false),
            SizedBox(height: 10),
            Text("What's your Email Address?", style: TextStyle(
                fontFamily: AppFonts.helveticaBold,
                color: AppColours.colorTextLight,
                fontSize: 16
            )),
            AppTextField(hint: "Email", textInputType: TextInputType.emailAddress, isError: false),
            SizedBox(height: 10),
            Text("Set your Password", style: TextStyle(
                fontFamily: AppFonts.helveticaBold,
                color: AppColours.colorTextLight,
                fontSize: 16
            )),
            AppTextField(hint: "Password", textInputType: TextInputType.visiblePassword, isError: false),
            SizedBox(height: 10),
            Text("What's your age?", style: TextStyle(
                fontFamily: AppFonts.helveticaBold,
                color: AppColours.colorTextLight,
                fontSize: 16
            )),
            AppTextField(hint: "Age", textInputType: TextInputType.number, isError: false),
            SizedBox(height: 10),
            Text("Where are you from?", style: TextStyle(
                fontFamily: AppFonts.helveticaBold,
                color: AppColours.colorTextLight,
                fontSize: 16
            )),
            AppTextField(hint: "Country", textInputType: TextInputType.text, isError: false),
          ],
        ),
      ),
    );
  }
}
