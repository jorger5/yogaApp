import 'package:zen_app/core/utils/constants.dart';
import 'package:zen_app/domain/entities/user.dart';

/// [UserModel] extends User and has json Methods
class UserModel extends User {
  const UserModel({
    required String id,
    bool? emailVerified,
    bool? loggedIn,
    String? email,
    String? name,
    String? firstName,
    String? lastName,
    String? userName,
    String? niceName,
    String? photo,
  }) : super(
          id: id,
          loggedIn: loggedIn ?? false,
          email: email ?? '',
          name: name ?? '',
          firstName: firstName ?? '',
          lastName: lastName ?? '',
          userName: userName ?? '',
          niceName: niceName ?? '',
          photo: photo ?? placeHolderPhoto,
          emailVerified: emailVerified ?? false,
        );

  factory UserModel.fromJson(Map<String, dynamic> responseData) {
    return UserModel(
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
}
