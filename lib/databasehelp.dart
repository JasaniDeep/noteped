import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class databasehelp{
  Database? n_database;
  Future<Database?> getData()
  async {,.
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'note_book.db');
// open the database
    n_database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE note_book (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, note TEXT,)');
        });
  //  await deleteDatabase(path);
    return n_database;
  }
}