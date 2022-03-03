import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:todo_list_provider/app/respositories/user/user_repository.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';

class UserServiceImpl implements UserService {
  final UserRepository _userRepository;
  UserServiceImpl({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;
  @override
  Future<User?> register(String email, String password) =>
      _userRepository.register(email, password);

  @override
  Future<User?> loginEmail(String email, String password) =>
      _userRepository.loginEmail(email, password);

  @override
  Future<void> forgotPassword(String email) =>
      _userRepository.forgotPassword(email);

  @override
  Future<User?> loginGoogle() => _userRepository.loginGoogle();

  @override
  Future<void> logout() => _userRepository.logout();

  @override
  Future<void> updateDisplayName(String name) =>
      _userRepository.updateDisplayName(name);
}
