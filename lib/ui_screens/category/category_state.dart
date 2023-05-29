import 'package:equatable/equatable.dart';

class CategoryState extends Equatable {


  const CategoryState();

  const CategoryState.initial() : this();

  CategoryState copyWith({
    bool? isShowTrim}) => const CategoryState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
