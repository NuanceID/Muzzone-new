import 'package:muzzone/data/models/album.dart';
import 'package:muzzone/data/models/links.dart';
import 'package:muzzone/data/models/meta.dart';

class Albums {
  final List<Album> data;
  final Links links;
  final Meta meta;

  Albums({
    this.data = const <Album>[],
    this.links = const Links(),
    this.meta = const Meta(),
  });

  factory Albums.fromJson(Map<String, dynamic> json) {
    var dataFromJson = json['data'] != null ? json['data'] as List : <Album>[];

    return Albums(
        data: dataFromJson.map((e) => Album.fromJson(e)).toList(),
        links: json['links'] != null
            ? Links.fromJson(json['links'])
            : const Links(),
        meta:
            json['meta'] != null ? Meta.fromJson(json['meta']) : const Meta());
  }
}
