import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path/path.dart' as p;
import 'package:todo_list_provider/app/core/database/hive/hive_exception.dart';
import 'package:uuid/uuid.dart';

class HiveDatabase {
  String _nameBoxes = 'hiveDatabaseboxes';
  String _folder = 'hiveDatabaseboxes';
  String get folderBoxes => _folder;
  String get nameBoxes => _nameBoxes;

  var _boxes = <String>{};
  Box? _box;

  /// The box and key with the name of all the boxes is equals folder or 'hiveboxes'
  /// Please dont create any box with this name
  ///
  /// First method start is initInDart() or initInFlutter
  // HiveController({required String folder}) : _folder = folder;
  static HiveDatabase? _instance;
  HiveDatabase._();
  factory HiveDatabase() {
    _instance ??= HiveDatabase._();
    return _instance!;
  }
  Future<void> initInDart() async {
    print('+++> HiveDatabase.initInDart');

    var pathFinal = '';
    try {
      var appPath = Directory.current.path;
      pathFinal = p.join(appPath, _folder);
    } catch (e) {
      throw HiveICantOpenDirectoryException();
    }
    try {
      Hive.init(pathFinal);
    } catch (e) {
      throw HiveICantInitException();
    }
    await _getNameOfBoxes();
  }

  Future<void> initInFlutter({String? folder}) async {
    print('+++> HiveDatabase.initInFlutter');
    _folder = folder ?? _folder;
    print('+++> HiveDatabase.initInFlutter 1');
    _nameBoxes = folder ?? _folder;
    print('+++> HiveDatabase.initInFlutter 2');
    try {
      print('+++> HiveDatabase.initInFlutter 3');
      await Hive.initFlutter(_folder);
      print('+++> HiveDatabase.initInFlutter 4');
    } catch (e) {
      print('Erro: initInFlutter ');
      throw HiveICantInitException();
    }
    await _getNameOfBoxes();
  }

  Future<void> _getNameOfBoxes() async {
    print('+++> HiveDatabase._getNameOfBoxes');

    var boxOpen = await Hive.openBox(_nameBoxes);
    if (!boxOpen.isOpen) {
      throw HiveICantOpenTheBoxException(message: 'In _getNameOfBoxes.');
    }
    dynamic boxes;
    try {
      boxes = boxOpen.get(_nameBoxes) ?? {};
    } catch (e) {
      throw HiveICantGetValueException(message: 'In _getNameOfBoxes.');
    }
    _updateNameOfBoxes(boxes);
  }

  _updateNameOfBoxes(dynamic boxes) {
    print('+++> HiveDatabase._updateNameOfBoxes');

    if (boxes.isNotEmpty) {
      _boxes.clear();
      _boxes.addAll(boxes);
    }
  }

  Future<void> closeAll() async {
    print('+++> HiveDatabase.closeAll');

    try {
      await Hive.close();
    } catch (e) {
      throw HiveICantCloseBoxesException();
    }
  }

  Future<void> close(String boxName) async {
    print('+++> HiveDatabase.close');

    await _getBox(boxName);
    try {
      await _box!.close();
    } catch (e) {
      throw HiveICantCloseBoxException();
    }
  }

  Future<void> addBox(String name) async {
    print('+++> HiveDatabase.addBox');
    if (_boxes.add(name)) {
      await _saveBoxInBoxes();
    }
  }

  Future<void> _saveBoxInBoxes() async {
    print('+++> HiveDatabase._saveBoxInBoxes');
    try {
      await _openBox(_nameBoxes);
      _box = Hive.box(_nameBoxes);
    } catch (e) {
      throw HiveICantGetTheBoxException();
    }
    try {
      await _box!.put(_nameBoxes, _boxes.toList());
    } catch (e) {
      throw HiveICantPutValueException();
    }
  }

  Future<void> _openBox(String name) async {
    print('+++> HiveDatabase._openBox');
    try {
      if (!Hive.isBoxOpen(name)) {
        await Hive.openBox(name);
        if (!Hive.isBoxOpen(name)) {
          throw HiveICantOpenTheBoxException(message: 'In _openBox.');
        }
      }
    } catch (e) {
      throw HiveICantOpenTheBoxException(message: 'Erro em _openBox');
    }
  }

  Future<void> _getBox(String name) async {
    print('+++> HiveDatabase._getBox');
    if (_boxes.contains(name)) {
      if (!Hive.isBoxOpen(name)) {
        await _openBox(name);
      }
      _box = Hive.box(name);
    } else {
      throw HiveUnregisteredBoxException();
    }
  }

  Future<String> create({
    required String boxName,
    required Map<String, dynamic> data,
    String? fieldId,
  }) async {
    print('+++> HiveDatabase.create');
    await _getBox(boxName);
    String fieldUuid = fieldId ?? 'uuid';

    if (!data.containsKey(fieldUuid)) {
      data.addAll({fieldUuid: Uuid().v4()});
    }
    try {
      await _box!.put(data[fieldUuid], data);
    } catch (e) {
      throw HiveICantPutValueException(message: 'In create.');
    }
    return data[fieldUuid];
  }

  // Future<String> create2({
  //   required String boxName,
  //   required Map<String, dynamic> data,
  //   String? fieldId,
  // }) async {
  //   print('+++> HiveDatabase.create2');
  //   await _getBox(boxName);
  //   String fieldUuid = fieldId ?? 'uuid';
  //   try {
  //     int id = await _box!.add(data);
  //     data.addAll({fieldUuid: id});
  //     await _box!.put(id, data);
  //   } catch (e) {
  //     throw HiveICantPutValueException(message: 'In create.');
  //   }
  //   return data[fieldUuid];
  // }

  Future<void> createAll({
    required String boxName,
    required List<Map<String, dynamic>> data,
    String? fieldId,
  }) async {
    print('+++> HiveDatabase.createAll');
    await _getBox(boxName);
    String fieldUuid = fieldId ?? 'uuid';
    for (var item in data) {
      if (!item.containsKey(fieldUuid)) {
        item.addAll({fieldUuid: Uuid().v4()});
      }
      try {
        await _box!.put(item[fieldUuid], item);
      } catch (e) {
        throw HiveICantPutValueException(message: 'In createAll.');
      }
    }
  }

  Future<Map<String, dynamic>> read(
      {required String boxName, required String id}) async {
    print('+++> HiveDatabase.read');
    await _getBox(boxName);
    var map = <String, dynamic>{};
    dynamic doc;
    if (_box!.isNotEmpty) {
      try {
        doc = _box!.get(id);
      } catch (e) {
        throw HiveICantGetValueException(message: 'In get.');
      }
      if (doc != null) {
        try {
          map = doc.cast<String, dynamic>();
        } catch (e) {
          throw HiveICantCastDataException(message: 'In get.');
        }
      }
    }
    return map;
  }

  Future<List<Map<String, dynamic>>> readAll(
    String boxName,
  ) async {
    print('+++> HiveDatabase.readAll');
    await _getBox(boxName);
    var docs = <Map<String, dynamic>>{};
    dynamic doc;
    if (_box!.isNotEmpty) {
      for (var boxKey in _box!.keys) {
        try {
          doc = _box!.get(boxKey);
        } catch (e) {
          throw HiveICantGetValueException(message: 'In readAll.');
        }
        if (doc != null) {
          var map = <String, dynamic>{};
          try {
            map = doc.cast<String, dynamic>();
          } catch (e) {
            throw HiveICantCastDataException(message: 'In readAll.');
          }
          docs.add(map);
        }
      }
    }
    return docs.toList();
  }

  Future<bool> update({
    required String boxName,
    required Map<String, dynamic> data,
    String? fieldId,
  }) async {
    print('+++> HiveDatabase.update');
    await _getBox(boxName);
    String fieldUuid = fieldId ?? 'uuid';

    if (!data.containsKey(fieldUuid)) {
      return Future.value(false);
    }
    try {
      await _box!.put(data[fieldUuid], data);
    } catch (e) {
      throw HiveICantPutValueException(message: 'In update.');
    }
    return Future.value(true);
  }

  Future<void> delete({required String boxName, required String id}) async {
    print('+++> HiveDatabase.delete');
    try {
      _box!.delete(id);
    } catch (e) {
      throw HiveICantDeleteValueException(message: 'In delete.');
    }
  }

  Future<void> deleteAll(String boxName) async {
    print('+++> HiveDatabase.deleteAll');
    try {
      Hive.deleteBoxFromDisk(boxName);
    } catch (e) {
      throw HiveICantDeleteBoxException(message: 'In deleteAll.');
    }
  }

  Future<List<String>> listOfBoxes() async {
    print('+++> HiveDatabase.listOfBoxes');
    Box box;
    try {
      box = await Hive.openBox(_nameBoxes);
    } catch (e) {
      throw HiveICantOpenTheBoxException();
    }
    var list = <String>[];
    dynamic doc;
    if (box.isNotEmpty) {
      try {
        doc = box.get(_nameBoxes);
      } catch (e) {
        throw HiveICantGetValueException(message: 'In listOfBoxes.');
      }
      if (doc != null) {
        try {
          list = doc.cast<String>();
        } catch (e) {
          throw HiveICantCastDataException(message: 'In listOfBoxes.');
        }
      }
    }
    return list;
  }
}
