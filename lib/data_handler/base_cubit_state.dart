import 'package:equatable/equatable.dart';
import 'package:pinterest_clone/data_handler/snackbar_message.dart';

abstract class BaseCubitState extends Equatable {
  final SnackbarMessage snackbarMessage;

  const BaseCubitState(this.snackbarMessage);

  @override
  List<Object> get props => [snackbarMessage];
}
