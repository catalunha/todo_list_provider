import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/database/hive/hive_adm_Conn.dart';
import 'package:todo_list_provider/app/core/database/hive/hive_controller.dart';
import 'package:todo_list_provider/app/modules/splash/splash_page.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final hiveAdmconn = HiveAdmConn();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addObserver(hiveAdmconn);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(hiveAdmconn);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List Provider',
      home: SplashPage(),
    );
  }
}
