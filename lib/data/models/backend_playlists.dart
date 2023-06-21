import 'package:muzzone/data/models/backend_playlist.dart';
import 'package:muzzone/data/models/links.dart';
import 'package:muzzone/data/models/meta.dart';

class BackendPlaylists {
  final List<BackendPlaylist> data;
  final Links links;
  final Meta meta;

  BackendPlaylists({
    this.data = const <BackendPlaylist>[],
    this.links = const Links(),
    this.meta = const Meta(),
  });

  factory BackendPlaylists.fromJson(Map<String, dynamic> json) {
    var dataFromJson =
        json['data'] != null ? json['data'] as List : <BackendPlaylist>[];

    return BackendPlaylists(
        data: dataFromJson.map((e) => BackendPlaylist.fromJson(e)).toList(),
        links: json['links'] != null
            ? Links.fromJson(json['links'])
            : const Links(),
        meta:
            json['meta'] != null ? Meta.fromJson(json['meta']) : const Meta());
  }
}
