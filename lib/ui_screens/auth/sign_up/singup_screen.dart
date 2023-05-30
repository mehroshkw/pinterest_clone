import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinterest_clone/extensions/context_extension.dart';
import 'package:pinterest_clone/ui_screens/auth/sign_up/signup_bloc.dart';
import 'package:pinterest_clone/ui_screens/auth/sign_up/signup_state.dart';
import 'package:pinterest_clone/ui_screens/reusable_widgets/app_text_field.dart';
import 'package:pinterest_clone/utils/app_colours.dart';

import '../../../data_handler/snackbar_message.dart';
import '../../../helpers/dilogue_helper.dart';
import '../../../helpers/material_dialogue_content.dart';
import '../../../helpers/snackbar_helper.dart';
import '../../../utils/app_strings.dart';
import '../../reusable_widgets/app_button.dart';
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
          children:  [
            const SizedBox(height: kToolbarHeight-20),
            const Text("What's your name?", style: TextStyle(
              fontFamily: AppFonts.helveticaBold,
              color: AppColours.colorTextLight,
              fontSize: 16
            )),
             AppTextField(
                controller: bloc.nameController,
                hint: "Name", textInputType: TextInputType.text, isError: false),
            const SizedBox(height: 10),
            const Text("What's your Email Address?", style: TextStyle(
                fontFamily: AppFonts.helveticaBold,
                color: AppColours.colorTextLight,
                fontSize: 16
            )),
             AppTextField(
                 controller: bloc.emailController,
                 hint: "Email", textInputType: TextInputType.emailAddress, isError: false),
            const SizedBox(height: 10),
            const Text("Set your Password", style: TextStyle(
                fontFamily: AppFonts.helveticaBold,
                color: AppColours.colorTextLight,
                fontSize: 16
            )),
             AppTextField(
                 controller: bloc.passwordController,
                 hint: "Password", textInputType: TextInputType.visiblePassword, isError: false),
            const SizedBox(height: 10),
            const Text("What's your age?", style: TextStyle(
                fontFamily: AppFonts.helveticaBold,
                color: AppColours.colorTextLight,
                fontSize: 16
            )),
             AppTextField(
                controller: bloc.ageController,
                hint: "Age", textInputType: TextInputType.number, isError: false),
            const SizedBox(height: 10),
            const Text("Where are you from?", style: TextStyle(
                fontFamily: AppFonts.helveticaBold,
                color: AppColours.colorTextLight,
                fontSize: 16
            )),
            BlocBuilder<SignupBloc, SignupState>(
              buildWhen: (previous, current) =>
              previous.nameError != current.nameError,
              builder: (_, state) => AppTextField(
                   controller: bloc.countryController,
                   hint: "Country", textInputType: TextInputType.text,
                 onChanged: (String? value) {
                 if (value == null) return;
                 if (value.isNotEmpty && state.nameError) {
                   bloc.updateNameError(false, '');
                   return;
                 }
               },
                 isError: state.nameError,),
             ),

            const SizedBox(height: 20,),
            BlocBuilder<SignupBloc, SignupState>(
                buildWhen: (previous, current) =>
                previous.errorText != current.errorText,
                builder: (_, state) {
                  if (state.errorText.isEmpty) return const SizedBox();
                  return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 7),
                      margin: const EdgeInsets.only(bottom: 20, top: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColours.colorError)),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.warning_amber_rounded,
                                color: AppColours.colorError),
                            const SizedBox(width: 5),
                            Text(state.errorText,
                                style: const TextStyle(
                                    color: AppColours.colorError,
                                    fontFamily: AppFonts.helveticaRegular,
                                    fontSize: 12))
                          ]));
                }),
            const SizedBox(height: 20,),

            SizedBox(
                height: 40,
                width: 400,
                child: AppButton(
                  textColor: AppColours.colorOnPrimary,
                    color: AppColours.colorPrimary,
                    text: 'Sign Up', onClick: (){
                  context.unfocus();
                  // final password = bloc.passwordController.text;
                  // final confirmPassword =
                  //     bloc.confirmPasswordController.text;
                  // if (bloc.nameController.text.isEmpty) {
                  //   bloc.updateNameError(true, AppText.NAME_EMPTY);
                  //   return;
                  // }
                  // if (bloc.dobController.text.isEmpty) {
                  //   bloc.updateDOBError(true, AppText.DOB_EMPTY);
                  //   return;
                  // }
                  // final email = bloc.emailController.text;
                  // if (email.isEmpty) {
                  //   bloc.updateEmailError(
                  //       true, AppText.EMAIL_FIELD_CANNOT_BE_EMPTY);
                  //   return;
                  // }
                  //
                  // if (bloc.passwordController.text.isEmpty) {
                  //   bloc.updatePasswordError(
                  //       true, AppText.PASSWORD_FIELD_CANNOT_BE_EMPTY);
                  //   return;
                  // }
                  //
                  // if (bloc.confirmPasswordController.text.isEmpty) {
                  //   bloc.updateConfirmPasswordError(true,
                  //       AppText.CONFIRM_PASSWORD_FIELD_CANNOT_BE_EMPTY);
                  //   return;
                  // }
                  // if (password != confirmPassword) {
                  //   bloc.updateConfirmPasswordError(true,
                  //       AppText.PASSWORD_AND_CONFIRM_PASSWORD_NOT_MATCH);
                  //   return;
                  // }
                  _signup(bloc, context, MaterialDialogHelper.instance());
                })),
          ],
        ),
      ),
    );
  }
}
