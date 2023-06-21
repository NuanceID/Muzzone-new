import 'package:muzzone/data/models/links.dart';
import 'package:muzzone/data/models/meta.dart';
import 'package:muzzone/data/models/track.dart';

class Tracks {
  final List<Track> data;
  final Links links;
  final Meta meta;

  Tracks({
    this.data = const <Track>[],
    this.links = const Links(),
    this.meta = const Meta(),
  });

  factory Tracks.fromJson(Map<String, dynamic> json) {
    var dataFromJson = json['data'] != null ? json['data'] as List : <Track>[];

    return Tracks(
        data: dataFromJson.map((e) => Track.fromJson(e)).toList(),
        links: json['links'] != null
            ? Links.fromJson(json['links'])
            : const Links(),
        meta:
            json['meta'] != null ? Meta.fromJson(json['meta']) : const Meta());
  }
}
