import 'package:equatable/equatable.dart';

class SignupState extends Equatable {
  final bool isNotShowPassword;
  final bool isNotShowConfirmPassword;
  final bool emailError;
  final bool passwordError;
  final bool countryError;
  final bool nameError;
  final bool ageError;
  final String errorText;

  const SignupState(
      {required this.isNotShowPassword,
        required this.isNotShowConfirmPassword,
        required this.nameError,
        required this.ageError,
        required this.emailError,
        required this.passwordError,
        required this.countryError,
        required this.errorText});

  const SignupState.initial()
      : this(
      isNotShowPassword: true,
      isNotShowConfirmPassword: true,
      emailError: false,
      passwordError: false,
      ageError: false,
      nameError: false,
      countryError: false,
      errorText: '');

  SignupState copyWith(
      {bool? isNotShowPassword,
        bool? isNotShowConfirmPassword,
        bool? emailError,
        bool? nameError,
        bool? ageError,
        DateTime? dateFromDate,
        bool? passwordError,
        bool? countryError,
        String? errorText}) =>
      SignupState(
          isNotShowPassword: isNotShowPassword ?? this.isNotShowPassword,
          emailError: emailError ?? this.emailError,
          passwordError: passwordError ?? this.passwordError,
          countryError:
          countryError ?? this.countryError,
          isNotShowConfirmPassword:
          isNotShowConfirmPassword ?? this.isNotShowConfirmPassword,
          nameError: nameError ?? this.nameError,
          ageError: ageError ?? this.ageError,
          errorText: errorText ?? this.errorText);

  @override
  List<Object> get props => [
    isNotShowPassword,
    isNotShowConfirmPassword,
    emailError,
    passwordError,
    nameError,
    ageError,
    errorText,
    countryError
  ];

  @override
  bool get stringify => true;
}
