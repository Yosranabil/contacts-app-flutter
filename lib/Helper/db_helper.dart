import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task6/Helper/constants.dart';
import 'package:task6/Model/User_model.dart';

class DataBaseHelper {

  Database? db;

  Future open() async{

    String path=join(await getDatabasesPath(),"note.db"); // path to store your table,note is name of the table

    db= await openDatabase(path,version: 1,onCreate:(db, version)async { // version is used when you want to add updates to table (increment it to update its version)
      //on create is called first time only as long as you are in the same version
      await db.execute('''
      CREATE TABLE $tableName(
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnName TEXT NOT NULL,
      $columnNumber TEXT NOT NULL,
      $columnMail TEXT NOT NULL)
     ''');

    }, );

  }

  Future insertContact(ContactModel contactModel)async{
    await open();
    return await db!.insert(tableName,contactModel.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future updateContact(ContactModel contact)async {
    await open();
    return await db!.update(tableName,contact.toMap(),where:'$columnId=?',whereArgs: [contact.id]);
  }

  Future<List<ContactModel>> getAllContacts() async {
    await open();
    List<Map<String,dynamic>> maps = await db!.query(tableName);
    return maps.isNotEmpty? maps.map((e) =>ContactModel.fromMap(e)).toList():[];
  }

  Future deleteContact(int index)async {
    await open();
    return await db!.delete(
        tableName, where: '$columnId=?', whereArgs: [index]);
  }
}