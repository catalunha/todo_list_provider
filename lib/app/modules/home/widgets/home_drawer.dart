import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/auth/auth_provider.dart';
import 'package:todo_list_provider/app/core/ui/messages.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';

class HomeDrawer extends StatelessWidget {
  final nameVN = ValueNotifier<String>('');
  HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Drawer(
          child: ListView(
        children: [
          DrawerHeader(
            decoration:
                BoxDecoration(color: context.primaryColor.withAlpha(70)),
            child: Row(
              children: [
                Selector<AuthProvider, String>(
                  selector: (buildContext, authProvider) {
                    return authProvider.user?.photoURL ??
                        'https://www.mktdeafiliados.com.br/wp-content/uploads/2015/02/Como-criar-uma-campanha-com-links-diretos.jpg';
                  },
                  builder: (_, value, __) {
                    return CircleAvatar(
                        backgroundImage: NetworkImage(value), radius: 30);
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Selector<AuthProvider, String>(
                      selector: (buildContext, authProvider) {
                        return authProvider.user?.displayName ??
                            'Nao informado';
                      },
                      builder: (_, value, __) {
                        return Text(
                          value,
                          style: context.textTheme.subtitle2,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text('Alterar nome'),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: Text('Alterar nome'),
                      content: TextField(
                        onChanged: (value) => nameVN.value = value,
                      ),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(
                              'Cancelar',
                              style: TextStyle(color: Colors.red),
                            )),
                        TextButton(
                            onPressed: () async {
                              if (nameVN.value.isEmpty) {
                                Messages.of(context)
                                    .showError('Nome obrigatorio');
                              } else {
                                Loader.show(context);
                                await context
                                    .read<UserService>()
                                    .updateDisplayName(nameVN.value);
                                Loader.hide();
                                Navigator.of(context).pop();
                              }
                            },
                            child: Text('Alterar')),
                      ],
                    );
                  });
            },
          ),
          ListTile(
            onTap: () => context.read<AuthProvider>().logout(),
            title: Text('Sair'),
          )
        ],
      )),
    );
  }
}
