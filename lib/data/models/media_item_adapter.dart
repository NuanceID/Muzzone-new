import 'package:audio_service/audio_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MediaItemAdapter extends TypeAdapter<MediaItem> {
  @override
  final typeId = 5;

  @override
  MediaItem read(BinaryReader reader) {
    return MediaItem(
        id: reader.readString(),
        title: reader.readString(),
        album: reader.read(),
        artist: reader.read(),
        artUri: Uri.parse(reader.readString()));
  }

  @override
  void write(BinaryWriter writer, MediaItem obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.title);
    writer.write(obj.album);
    writer.write(obj.artist);
    writer.writeString(obj.artUri.toString());
  }
}
