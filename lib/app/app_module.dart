import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/app_widget.dart';
import 'package:todo_list_provider/app/core/database/hive/hive_controller.dart';
import 'package:todo_list_provider/app/core/database/sqlite/sqlite_conn_factory.dart';

class AppModule extends StatelessWidget {
  const AppModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) {
            HiveController hiveController = HiveController();
            hiveController.initInFlutter();
            return hiveController;
          },
          lazy: false,
        )
      ],
      child: AppWidget(),
    );
  }
}
