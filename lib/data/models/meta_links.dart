class MetaLinks {
  final String url;
  final String label;
  final bool active;

  const MetaLinks({
    this.url = '',
    this.label = '',
    this.active = false,
  });

  factory MetaLinks.fromJson(Map<String, dynamic> json) {
    return MetaLinks(
        url: json['url'] ?? '',
        label: json['label'] ?? '',
        active: json['active'] ?? false,);
  }
}
