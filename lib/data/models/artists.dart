import 'package:muzzone/data/models/artist.dart';
import 'package:muzzone/data/models/links.dart';
import 'package:muzzone/data/models/meta.dart';

class Artists {
  final List<Artist> data;
  final Links links;
  final Meta meta;

  Artists({
    this.data = const <Artist>[],
    this.links = const Links(),
    this.meta = const Meta(),
  });

  factory Artists.fromJson(Map<String, dynamic> json) {
    var dataFromJson = json['data'] != null ? json['data'] as List : <Artist>[];

    return Artists(
        data: dataFromJson.map((e) => Artist.fromJson(e)).toList(),
        links: json['links'] != null
            ? Links.fromJson(json['links'])
            : const Links(),
        meta:
            json['meta'] != null ? Meta.fromJson(json['meta']) : const Meta());
  }
}
