part of 'edit_photo_bloc.dart';

class EditPhotoState {
  final String photo;
  final File? image;

  EditPhotoState({
    required this.photo,
    this.image,
  });

  EditPhotoState copyWith({
    String? photo,
    File? image,
  }) {
    return EditPhotoState(
      photo: photo ?? this.photo,
      image: image,
    );
  }
}

class EditPhotoInitial extends EditPhotoState {
  EditPhotoInitial({
    required super.photo,
    super.image,
  });
}
