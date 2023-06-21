import 'package:muzzone/data/models/meta_links.dart';

class Meta {
  final int currentPage;
  final int from;
  final int lastPage;
  final List<MetaLinks> links;
  final String path;
  final int perPage;
  final int to;
  final int total;

  const Meta(
      {this.currentPage = -1,
      this.from = -1,
      this.lastPage = -1,
      this.links = const <MetaLinks>[],
      this.path = '',
      this.perPage = -1,
      this.to = -1,
      this.total = -1});

  factory Meta.fromJson(Map<String, dynamic> json) {
    var linksFromJson =
        json['links'] != null ? json['links'] as List : <MetaLinks>[];

    return Meta(
        currentPage: json['current_page'] ?? -1,
        from: json['from'] ?? -1,
        lastPage: json['last_page'] ?? -1,
        links: linksFromJson.map((e) => MetaLinks.fromJson(e)).toList(),
        path: json['path'] ?? '',
        perPage: json['per_page'] ?? -1,
        to: json['to'] ?? -1,
        total: json['total'] ?? -1);
  }
}
