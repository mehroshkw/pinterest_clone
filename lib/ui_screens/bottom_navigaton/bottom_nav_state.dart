import 'package:equatable/equatable.dart';

class BottomNavState extends Equatable {
  final int index;
  final bool isVote;
  final bool isSavedSelected;


  const BottomNavState({
    required this.index,
    required this.isVote,
    required this.isSavedSelected,
  });

  const BottomNavState.initial()
      : this(
          index: 0,
          isVote: true,
    isSavedSelected: false,
        );

  BottomNavState copyWith({
    int? index,
    bool? isVote,
    bool? isSavedSelected,
  }) =>
      BottomNavState(
          index: index ?? this.index, isVote: isVote ?? this.isVote,
          isSavedSelected: isSavedSelected ?? this.isSavedSelected);

  @override
  List<Object?> get props => [index, isVote, isSavedSelected];
}
