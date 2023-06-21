import 'package:hive/hive.dart';

part 'hive_audio_model.g.dart';

@HiveType(typeId: 0)
class HiveAudioModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String artist;

  @HiveField(3)
  String album;

  @HiveField(4)
  String image;

  @HiveField(5)
  String url;

  HiveAudioModel({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.image,
    required this.url,
  });
}
