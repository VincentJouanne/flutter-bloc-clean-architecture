// coverage:ignore-file
import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    this.email,
    this.name,
    this.photo,
  });

  final String? email;

  final String id;

  final String? name;

  final String? photo;

  static const empty = User(id: '');

  static const fake = User(
    id: 'id1',
    name: 'Flutter',
    photo: 'https://flutter.svg',
  );

  bool get isEmpty => this == User.empty;

  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [email, id, name, photo];
}
