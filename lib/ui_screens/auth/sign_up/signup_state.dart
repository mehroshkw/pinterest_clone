import 'package:equatable/equatable.dart';

class SignupState extends Equatable {


  const SignupState();

  const SignupState.initial() : this();

  SignupState copyWith({
    bool? isShowTrim}) => const SignupState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}