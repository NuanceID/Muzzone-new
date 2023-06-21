part of 'edit_photo_bloc.dart';

class EditPhotoEvent {}

class DeletePhotoEvent extends EditPhotoEvent {}

class PickImage extends EditPhotoEvent {
  final File image;

  PickImage(this.image);
}

class SaveImagePermanently extends EditPhotoEvent {
  final String imagePath;

  SaveImagePermanently(this.imagePath);
}

class FinalPickImage extends EditPhotoEvent {
  final ImageSource source;

  FinalPickImage(this.source);
}

class CancelPhotoEdition extends EditPhotoEvent {}

class SavePhotoEdition extends EditPhotoEvent {}
