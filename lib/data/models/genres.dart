import 'package:muzzone/data/models/genre.dart';
import 'package:muzzone/data/models/links.dart';
import 'package:muzzone/data/models/meta.dart';

class Genres {
  final List<Genre> data;
  final Links links;
  final Meta meta;

  Genres({
    this.data = const <Genre>[],
    this.links = const Links(),
    this.meta = const Meta(),
  });

  factory Genres.fromJson(Map<String, dynamic> json) {
    var dataFromJson = json['data'] != null ? json['data'] as List : <Genre>[];

    return Genres(
        data: dataFromJson.map((e) => Genre.fromJson(e)).toList(),
        links: json['links'] != null
            ? Links.fromJson(json['links'])
            : const Links(),
        meta:
        json['meta'] != null ? Meta.fromJson(json['meta']) : const Meta());
  }
}
