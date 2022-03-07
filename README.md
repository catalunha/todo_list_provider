# Introdução

Este TodoList é um dos projetos da Academia do Flutter, http://academiadoflutter.com.br/.

Parece simples mas tras muito aprendizado interessante.

A versão do curso usa banco de dados sqflite. 

Contudo alterei para Hive para realizar alguns testes de uso também para web. 

# HiveBase

Criei uma classe de uso do Hive: lib/app/core/database/hive/hive_database.dart

E estou querendo amplia-la, talvez para um package, para conter wheres e outros no padrao do firebase.
```
HiveBase.instance
  .box('users')
  .where('age', isGreaterThan: 20)
  .get()
  .then(...);
```

# Como executar localmente
Crie um projeto no firebase com Authenticação via email e google.

Crie uma aplicação Android. Registre o SHA1 para permitir login via google.

Copie o arquivo de config para:
/android/app/google-services.json

Creio que seja só isto :-)

# Ver boxes do hive
* Iniciar Android Studio
* Abrir projeto em desenvolvimento
* Clicar no icone Device File Explorer (geralmente fica na parte inferior canto direito )
* Abrir caminho
    * /data/data/[seu org].todo_list_provider/app_flutter/hiveBaseBoxes


