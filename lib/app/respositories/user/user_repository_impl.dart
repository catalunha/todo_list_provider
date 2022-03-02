import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:todo_list_provider/app/exception/auth_exception.dart';

import 'package:todo_list_provider/app/respositories/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  FirebaseAuth _firebaseAuth;
  UserRepositoryImpl({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;
  @override
  Future<User?> register(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e, s) {
      // print(e);
      // print(s);
      // if (e.code == 'email-already-exists') {
      if (e.code == 'email-already-in-use') {
        final loginTypes =
            await _firebaseAuth.fetchSignInMethodsForEmail(email);

        if (loginTypes.contains('password')) {
          throw AuthException(message: 'E-mail ja utilizado.');
        } else {
          throw AuthException(
              message:
                  'Você esta cadastrado pelo Google. Então, entre pelo Google !!!');
        }
      } else {
        throw AuthException(message: e.message ?? 'Erro ao registrar usuário.');
      }
    }
  }

  @override
  Future<User?> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on PlatformException catch (e, s) {
      // print(e);
      // print(s);
      throw AuthException(
          message: e.message ?? 'Erro de PlatformException ao realizar login');
    } on FirebaseAuthException catch (e, s) {
      // print(e);
      // print(s);

      if (e.code == 'invalid-email') {
        throw AuthException(message: 'Email não válido');
      }
      if (e.code == 'user-disabled') {
        throw AuthException(
            message: 'Usuario desabilitado para o email consultado');
      }
      if (e.code == 'user-not') {
        throw AuthException(
            message: 'Não há usuário correspondente a este email');
      }
      if (e.code == 'wrong-password') {
        throw AuthException(message: 'Senha inválida para este email');
      }

      throw AuthException(
          message:
              'Erro desconhecido no FirebaseAuthException ao realizar login');
    }
  }
}
