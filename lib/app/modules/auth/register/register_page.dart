import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/core/validators/validators.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_field.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_logo.dart';
import 'package:todo_list_provider/app/modules/auth/register/register_controller.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailTec = TextEditingController();
  final _passwordTec = TextEditingController();
  final _confirmPasswordTec = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<RegisterController>().addListener(() {
      final controller = context.read<RegisterController>();
      var error = controller.error;
      var success = controller.success;
      if (success) {
        Navigator.of(context).pop();
      } else if (error != null && error.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error),
          backgroundColor: Colors.red,
        ));
      }
    });
  }

  @override
  void dispose() {
    _emailTec.dispose();
    _passwordTec.dispose();
    _confirmPasswordTec.dispose();
    context.read<RegisterController>().removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Todo List',
                style: TextStyle(fontSize: 10, color: context.primaryColor),
              ),
              Text(
                'Cadastro',
                style: TextStyle(fontSize: 15, color: context.primaryColor),
              )
            ]),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: ClipOval(
                child: Container(
              color: context.primaryColor.withAlpha(20),
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.arrow_back,
                size: 20,
                color: context.primaryColor,
              ),
            ))),
      ),
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.width * .5,
            child: const FittedBox(
              child: TodoListLogo(),
              fit: BoxFit.fitHeight,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 20,
            ),
            child: Form(
              key: _formKey,
              child: Column(children: [
                TodoListField(
                  label: 'E-mail',
                  controller: _emailTec,
                  validator: Validatorless.multiple([
                    Validatorless.email('Informe um email válido aqui.'),
                    Validatorless.required('Campo obrigatorio'),
                  ]),
                ),
                const SizedBox(height: 10),
                TodoListField(
                  label: 'Senha',
                  obscureText: true,
                  controller: _passwordTec,
                  validator: Validatorless.multiple([
                    Validatorless.min(6, 'Informe mais de 6 caracteres'),
                    Validatorless.required('Campo obrigatorio'),
                  ]),
                ),
                const SizedBox(height: 10),
                TodoListField(
                  label: 'Repita sua senha',
                  obscureText: true,
                  controller: _confirmPasswordTec,
                  validator: Validatorless.multiple([
                    Validatorless.min(6, 'Informe mais de 6 caracteres'),
                    Validatorless.required('Campo obrigatorio'),
                    Validators.compare(_passwordTec, 'Senhas diferentes'),
                  ]),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      final formValid =
                          _formKey.currentState?.validate() ?? false;
                      if (formValid) {
                        context
                            .read<RegisterController>()
                            .registerUser(_emailTec.text, _passwordTec.text);
                      }
                    },
                    child: const Text('Registrar-me'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }
}
