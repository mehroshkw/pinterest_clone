import 'package:equatable/equatable.dart';

class ImageViewState extends Equatable {
final bool isFavourite;

  const ImageViewState({required this.isFavourite});

  const ImageViewState.initial()
      : this(
    isFavourite: false
  );

  ImageViewState copyWith({
    bool? isFavourite
  }) => ImageViewState(
      isFavourite: isFavourite ?? this.isFavourite
  );

  @override
  // TODO: implement props
  List<Object?> get props => [isFavourite];
}
