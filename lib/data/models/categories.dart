import 'package:muzzone/data/models/category.dart';
import 'package:muzzone/data/models/links.dart';
import 'package:muzzone/data/models/meta.dart';

class Categories {
  final List<Category> data;
  final Links links;
  final Meta meta;

  Categories({
    this.data = const <Category>[],
    this.links = const Links(),
    this.meta = const Meta(),
  });

  factory Categories.fromJson(Map<String, dynamic> json) {
    var dataFromJson = json['data'] != null ? json['data'] as List : <Category>[];

    return Categories(
        data: dataFromJson.map((e) => Category.fromJson(e)).toList(),
        links: json['links'] != null
            ? Links.fromJson(json['links'])
            : const Links(),
        meta:
            json['meta'] != null ? Meta.fromJson(json['meta']) : const Meta());
  }
}
