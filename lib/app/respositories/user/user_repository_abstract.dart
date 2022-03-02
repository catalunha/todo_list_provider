import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRepositoryAbstract {
  Future<User?> register(String email, String password);
}
