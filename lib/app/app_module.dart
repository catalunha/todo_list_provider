import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/app_widget.dart';
import 'package:todo_list_provider/app/core/database/hive/hive_controller.dart';
import 'package:todo_list_provider/app/core/database/sqlite/sqlite_conn_factory.dart';
import 'package:todo_list_provider/app/modules/auth/register/register_controller.dart';
import 'package:todo_list_provider/app/respositories/user/user_repository.dart';
import 'package:todo_list_provider/app/respositories/user/user_repository_abstract.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';
import 'package:todo_list_provider/app/services/user/user_service_abstract.dart';

class AppModule extends StatelessWidget {
  const AppModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => FirebaseAuth.instance,
        ),
        Provider(
          create: (_) {
            HiveController hiveController = HiveController();
            hiveController.initInFlutter();
            return hiveController;
          },
          lazy: false,
        ),
        Provider<UserRepositoryAbstract>(
          create: (context) => UserRepository(
            firebaseAuth: context.read(),
          ),
        ),
        Provider<UserServiceAbstract>(
          create: (context) => UserService(
            userRepository: context.read(),
          ),
        ),
      ],
      child: AppWidget(),
    );
  }
}
