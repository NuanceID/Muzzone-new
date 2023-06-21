class Links {
  final String first;
  final String last;
  final String prev;
  final String next;

  const Links({
    this.first = '',
    this.last = '',
    this.prev = '',
    this.next = '',
  });

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
        first: json['first'] ?? '',
        last: json['last'] ?? '',
        prev: json['prev'] ?? '',
        next: json['next'] ?? '');
  }
}
