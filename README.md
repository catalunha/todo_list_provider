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

# Ver dados do hive
* Iniciar Android Studio
* Abrir projeto em desenvolvimento
* Clicar no icone Device File Explorer (geralmente fica na parte inferior canto direito )
* Abrir caminho
    * /data/data/[seu org].todo_list_provider/app_flutter/hiveBaseBoxes


