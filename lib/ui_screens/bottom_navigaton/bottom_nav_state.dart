import 'package:equatable/equatable.dart';

class BottomNavState extends Equatable {
  final int index;
  final bool isVote;


  const BottomNavState({
    required this.index,
    required this.isVote,
  });

  const BottomNavState.initial()
      : this(
          index: 0,
          isVote: true,
        );

  BottomNavState copyWith({
    int? index,
    bool? isVote}) =>
      BottomNavState(
          index: index ?? this.index, isVote: isVote ?? this.isVote);

  @override
  List<Object?> get props => [index, isVote];
}
