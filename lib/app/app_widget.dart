import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo_list_provider/app/core/database/hive/hive_adm_Conn.dart';
import 'package:todo_list_provider/app/core/navigator/todo_list_navigator.dart';
import 'package:todo_list_provider/app/core/ui/todo_list_ui_config.dart';
import 'package:todo_list_provider/app/modules/auth/auth_module.dart';
import 'package:todo_list_provider/app/modules/home/home_module.dart';
import 'package:todo_list_provider/app/modules/splash/splash_page.dart';
import 'package:todo_list_provider/app/modules/tasks/tasks_module.dart';

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
      theme: TodoListUiConfig.theme(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('pt', 'BR'),
      ],
      navigatorKey: TodoListNavigator.navigatorKey,
      routes: {
        ...AuthModule().routers,
        ...HomeModule().routers,
        ...TasksModule().routers,
      },
      home: SplashPage(),
    );
  }
}
