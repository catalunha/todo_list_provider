import 'package:firebase_auth/firebase_auth.dart';

abstract class UserServiceAbstract {
  Future<User?> register(String email, String password);
}
