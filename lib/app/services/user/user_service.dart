import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:todo_list_provider/app/respositories/user/user_repository.dart';
import 'package:todo_list_provider/app/services/user/user_service_abstract.dart';

class UserService implements UserServiceAbstract {
  final UserRepository _userRepository;
  UserService({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;
  @override
  Future<User?> register(String email, String password) =>
      _userRepository.register(email, password);
}
