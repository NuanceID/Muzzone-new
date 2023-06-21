import 'package:hive_flutter/hive_flutter.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  final String phoneNumber;
  @HiveField(1)
  final String token;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String registerDate;

  User({
    required this.phoneNumber,
    required this.token,
    required this.name,
    required this.registerDate
  });
}
