import 'dart:io';
import 'package:objectdb/objectdb.dart';
import 'package:path_provider/path_provider.dart';
import 'package:objectdb/src/objectdb_storage_filesystem.dart';

class MeetingsDB {
  getPath() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = documentDirectory.path + '/meetings.db';
    return path;
  }

  add(item) async {
    final db = ObjectDB(FileSystemStorage(await getPath()) );
    db.insert(item);
    db.cleanup();
    await db.close();
  }

  remove(map) async {
    final db = ObjectDB(FileSystemStorage(await getPath()));
    // db.open();
    db.remove(map);
    db.cleanup();
    await db.close();
  }

  listAll() async {
    final db = ObjectDB(FileSystemStorage(await getPath()));
    List<Map> val = await db.find({});
    db.cleanup();
    await db.close();
    return val;
  }
}
