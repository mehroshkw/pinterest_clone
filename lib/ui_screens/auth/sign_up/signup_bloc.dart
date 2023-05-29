import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinterest_clone/ui_screens/auth/sign_up/signup_state.dart';

class SignupBloc extends Cubit<SignupState> {
  SignupBloc():super(const SignupState.initial());


}
