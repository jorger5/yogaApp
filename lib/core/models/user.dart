import 'package:equatable/equatable.dart';
import 'package:zen_app/core/utils/constants.dart';

/// [User.empty] represents an unauthenticated user.
class User extends Equatable {
  /// {@macro user}
  const User({
    required this.id,
    this.email,
    this.name = 'No registered name',
    this.photo = placeHolderPhoto,
    this.emailVerified,
  });

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
      id: responseData['id'],
      email: responseData['email'],
      name: responseData['name'],
      photo: responseData['photo'],
      emailVerified: responseData['email_verified'],
    );
  }
  final String? email;
  final String id;
  final String? name;
  final String photo;
  final bool? emailVerified;
  static const empty = User(id: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == User.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [email, id, name, photo];
}
