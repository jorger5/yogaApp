import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/subjects.dart';
import 'package:zen_app/data/user/models/user_model.dart';

import 'package:zen_app/domain/auth/failures/auth_failure.dart';
import 'package:zen_app/domain/entities/user.dart';

class UserRepository {
  final _user = BehaviorSubject<User>();

  final userCollection = FirebaseFirestore.instance.collection('users');

  Stream<User> get user => _user.stream;

  Function(User) get addToStream => _user.sink.add;

  Future<void> getUser({id}) async {
    try {
      final userDoc = await userCollection.doc(id).get();
      if (userDoc.exists) {
        final user = UserModel.fromJson(userDoc.data()!);
        addToStream(user);
      }
    } catch (e) {
      print(e);
      throw NoUserFound();
    }
  }

  /// Actualizar o registrar un usuario en Firestore
  Future<bool> updateOrRegister({required UserModel user}) async {
    try {
      await userCollection.doc(user.id).set(user.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> addUser(User user) async {
    try {
      final String id = userCollection.doc().id;
      await userCollection.add({
        'id': id,
        'firebaseID': user.id,
        'email': user.email,
        'name': user.name,
        'email_verified': false,
        'photo': user.photo,
      });
    } catch (e) {
      print(e);
      throw ErrorRegisteringUser();
    }
  }

  void dispose() {
    _user.close();
  }
}
