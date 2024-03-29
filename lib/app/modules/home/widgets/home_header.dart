import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/auth/auth_provider.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Selector<AuthProvider, String>(
        selector: (context, authProvider) {
          return authProvider.user?.displayName ?? 'Sem nome';
        },
        builder: (_, value, __) {
          return Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              'Olá, $value!',
              style: context.textTheme.headline5
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
    );
  }
}
