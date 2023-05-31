import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final bool isNotShowPassword;
  final bool emailError;
  final bool passwordError;
  final String errorText;

  const LoginState(
      {required this.isNotShowPassword,
        required this.emailError,
        required this.passwordError,
        required this.errorText});

  const LoginState.initial()
      : this(
      isNotShowPassword: true,
      emailError: false,
      passwordError: false,
      errorText: '');

  LoginState copyWith(
      {bool? isNotShowPassword,
        bool? emailError,
        bool? passwordError,
        String? errorText}) =>
      LoginState(
          isNotShowPassword: isNotShowPassword ?? this.isNotShowPassword,
          emailError: emailError ?? this.emailError,
          passwordError: passwordError ?? this.passwordError,
          errorText: errorText ?? this.errorText);

  @override
  List<Object> get props => [
    isNotShowPassword,
    emailError,
    passwordError,
    errorText,
  ];

  @override
  bool get stringify => true;
}
