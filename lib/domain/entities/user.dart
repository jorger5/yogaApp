import 'package:equatable/equatable.dart';
import 'package:zen_app/core/utils/constants.dart';

class User extends Equatable {
  final String? email;

  final String id, name, photo, lastName, firstName, userName, niceName;
  final bool emailVerified, loggedIn;

  const User({
    required this.id,
    this.loggedIn = false,
    this.email,
    this.name = 'No registered name',
    this.firstName = 'No registered first name',
    this.lastName = 'No registered last name',
    this.userName = 'No registered user name',
    this.niceName = 'No registered nice name',
    this.photo = placeHolderPhoto,
    this.emailVerified = false,
  });

  @override
  List<Object> get props {
    return [
      id,
      name,
      photo,
      lastName,
      firstName,
      userName,
      niceName,
      email ?? 'no email',
      emailVerified,
      loggedIn,
    ];
  }

  static const empty = User(id: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == User.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != User.empty;
}
