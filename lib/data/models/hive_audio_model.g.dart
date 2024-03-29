// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_audio_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveAudioModelAdapter extends TypeAdapter<HiveAudioModel> {
  @override
  final int typeId = 0;

  @override
  HiveAudioModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveAudioModel(
      id: fields[0] as String,
      title: fields[1] as String,
      artist: fields[2] as String,
      album: fields[3] as String,
      image: fields[4] as String,
      url: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveAudioModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.artist)
      ..writeByte(3)
      ..write(obj.album)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveAudioModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
