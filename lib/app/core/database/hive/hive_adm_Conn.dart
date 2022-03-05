import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/database/hive/hive_connection_factory.dart';
import 'package:todo_list_provider/app/core/database/hive/hive_database.dart';

class HiveAdmConn extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final conn = HiveConnectionFactory();
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        conn.closeConnection();
        break;
    }

    super.didChangeAppLifecycleState(state);
  }
}
