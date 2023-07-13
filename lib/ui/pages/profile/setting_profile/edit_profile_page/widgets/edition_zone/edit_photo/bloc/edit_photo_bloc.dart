import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../../../../../data/local_data_store/local_data_store.dart';

part 'edit_photo_event.dart';
part 'edit_photo_state.dart';

final LocalDataStore _store = LocalDataStore();

class EditPhotoBloc extends Bloc<EditPhotoEvent, EditPhotoState> {
  EditPhotoBloc()
      : super(EditPhotoInitial(
          photo: _store.getAvatarImagePath(),
          image: _store.getAvatarImagePath() != ''
              ? File(_store.getAvatarImagePath())
              : null,
        )) {
    on<DeletePhotoEvent>(_onDeletePhoto);
    on<PickImage>(_onPickImage);
    on<SaveImagePermanently>(_onSaveImagePermanently);
    on<FinalPickImage>(_onFinalPickImage);
    on<CancelPhotoEdition>(_onCancelEdition);
    on<SavePhotoEdition>(_onSaveEdition);
  }

  FutureOr<void> _onDeletePhoto(
      DeletePhotoEvent event, Emitter<EditPhotoState> emit) {
    // _store.setAvatarImagePath('');
    emit(state.copyWith(image: null));
  }

  FutureOr<void> _onPickImage(
      PickImage event, Emitter<EditPhotoState> emit) async {
    emit(state.copyWith(image: event.image));
  }

  FutureOr<void> _onSaveImagePermanently(
      SaveImagePermanently event, Emitter<EditPhotoState> emit) async {
    final directory = await getApplicationDocumentsDirectory();
    //final name = basename(event.imagePath);
    //final image = File('${directory.path}/$name');

    // _store.setAvatarImagePath(image.path);
    //emit(state.copyWith(image: await File(event.imagePath).copy(image.path)));
  }

  FutureOr<void> _onFinalPickImage(
      FinalPickImage event, Emitter<EditPhotoState> emit) async {
    try {
      final image = await ImagePicker().pickImage(source: event.source);
      if (image == null) return;
      add(SaveImagePermanently(image.path));
      final imagePermanent = state.image!;
      add(PickImage(imagePermanent));
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed pick image $e');
      }
    }
  }

  FutureOr<void> _onCancelEdition(
      CancelPhotoEdition event, Emitter<EditPhotoState> emit) {
    emit(state.copyWith(
        image: _store.getAvatarImagePath() != ''
            ? File(_store.getAvatarImagePath())
            : null));
  }

  FutureOr<void> _onSaveEdition(
      SavePhotoEdition event, Emitter<EditPhotoState> emit) {
    if (state.image != null) {
      _store.setAvatarImagePath(state.image!.path);
    }
  }
}
