import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRepository {
  Future<User?> register(String email, String password);
  Future<User?> loginEmail(String email, String password);
  Future<User?> loginGoogle();
  Future<void> logout();
  Future<void> forgotPassword(String email);
  Future<void> updateDisplayName(String name);
}
