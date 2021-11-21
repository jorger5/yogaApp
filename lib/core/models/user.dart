import 'package:equatable/equatable.dart';
import 'package:zen_app/core/utils/constants.dart';

/// [User.empty] represents an unauthenticated user.
class User extends Equatable {
  /// {@macro user}
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
    this.emailVerified,
  });

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
      id: responseData['id'],
      email: responseData['email'],
      name: responseData['name'],
      firstName: responseData['firstName'],
      lastName: responseData['lastName'],
      userName: responseData['userName'],
      niceName: responseData['niceName'],
      loggedIn: responseData['loggedIn'],
      photo: responseData['photo'],
      emailVerified: responseData['email_verified'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'niceName': niceName,
      'loggedIn': loggedIn,
      'photo': photo,
      'email_verified': emailVerified,
    };
  }

  final String? email;

  final String id, name, photo, lastName, firstName, userName, niceName;
  final bool? emailVerified;
  final bool loggedIn;
  static const empty = User(id: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == User.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [email, id, name, photo];
}
