import 'package:flutter/cupertino.dart';
import 'package:todo_list_provider/app/core/database/hive/hive_controller.dart';

class HiveAdmConn extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final conn = HiveController();
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        conn.closeAll();
        break;
    }

    super.didChangeAppLifecycleState(state);
  }
}
