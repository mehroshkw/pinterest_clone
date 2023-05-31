import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinterest_clone/extensions/context_extension.dart';
import 'package:pinterest_clone/helpers/snackbar_helper.dart';
import 'package:pinterest_clone/ui_screens/auth/login/login_bloc.dart';
import 'package:pinterest_clone/ui_screens/auth/login/login_state.dart';
import 'package:pinterest_clone/ui_screens/bottom_navigaton/bottom_nav_screen.dart';

import '../../../data_handler/snackbar_message.dart';
import '../../../helpers/dilogue_helper.dart';
import '../../../helpers/material_dialogue_content.dart';
import '../../../utils/app_colours.dart';
import '../../reusable_widgets/app_button.dart';
import '../../reusable_widgets/app_text_field.dart';

class LoginScreen extends StatelessWidget {
  static const String route = '/login_screen';

  const LoginScreen({Key? key}) : super(key: key);
  Future<void> _login(LoginBloc bloc, BuildContext context,
      MaterialDialogHelper dialogHelper) async {
    dialogHelper
      ..injectContext(context)
      ..showProgressDialog("Logging in...");
    try {
      final response = await bloc.login(
          bloc.emailController.text,
          bloc.passwordController.text);
      dialogHelper.dismissProgress();
      final snackbarHelper = SnackbarHelper.instance..injectContext(context);

      if (response == false) {
        snackbarHelper.showSnackbar(
            snackbar: SnackbarMessage.error(message: "Error Signing Up"));
        return;
      }
      snackbarHelper.showSnackbar(
          snackbar: SnackbarMessage.success(message: "Logged in Successfully"));
      Future.delayed(const Duration(seconds: 1)).then((_) =>
          Navigator.pushNamedAndRemoveUntil(
              context, BottomNavScreen.route, (route) => false));
    } catch (_) {
      dialogHelper.dismissProgress();
      dialogHelper.showMaterialDialogWithContent(
          MaterialDialogContent.networkError(),
              () => _login(bloc, context, dialogHelper));
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: kToolbarHeight - 20),
            const Center(
              child: Image(image: AssetImage("assets/pinterest-logo.png"),height: 80,
                width: 80,),
            ),
            const SizedBox(height: 30),
            const Text("What's your Email Address?",
                style: TextStyle(
                    fontFamily: AppFonts.helveticaBold,
                    color: AppColours.colorTextLight,
                    fontSize: 16)),
            BlocBuilder<LoginBloc, LoginState>(
              buildWhen: (previous, current) =>
              previous.emailError != current.emailError,
              builder: (_, state) => AppTextField(
                controller: bloc.emailController,
                hint: "Email",
                textInputType: TextInputType.text,
                onChanged: (String? value) {
                  if (value == null) return;
                  if (value.isNotEmpty && state.emailError) {
                    bloc.updateEmailError(false, '');
                    return;
                  }
                },
                isError: state.emailError,
              ),
            ),
            const SizedBox(height: 10),
            const Text("Enter your Password",
                style: TextStyle(
                    fontFamily: AppFonts.helveticaBold,
                    color: AppColours.colorTextLight,
                    fontSize: 16)),
            BlocBuilder<LoginBloc, LoginState>(
              buildWhen: (previous, current) =>
              previous.passwordError != current.passwordError,
              builder: (_, state) => AppTextField(
                  controller: bloc.passwordController,
                  hint: "Password",
                  textInputType: TextInputType.visiblePassword,
                  onChanged: (String? value) {
                    if (value == null) return;
                    if (value.isNotEmpty && state.passwordError) {
                      bloc.updatePasswordError(false, '');
                      return;
                    }
                  },
                  isError: state.passwordError),
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<LoginBloc, LoginState>(
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
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                height: 40,
                width: 400,
                child: AppButton(
                    textColor: AppColours.colorOnPrimary,
                    color: AppColours.colorPrimary,
                    text: 'Login',
                    onClick: () {
                      context.unfocus();
                      if (bloc.emailController.text.isEmpty) {
                        bloc.updateEmailError(true, "Email is empty");
                        return;
                      }
                      if (bloc.passwordController.text.isEmpty) {
                        bloc.updatePasswordError(true, "Password is Empty");
                        return;
                      }
                      _login(bloc, context, MaterialDialogHelper.instance());
                    })),
          ],
        ),
      ),
    );
  }
}