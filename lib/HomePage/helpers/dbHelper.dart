import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:untitled/HomePage/helpers/apiHelper.dart';
import 'package:untitled/HomePage/model/model.dart';

class DBHelper {
  DBHelper._();

  static final DBHelper dbHelper = DBHelper._();

  Database? db;

  initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE productTable(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, categoryName TEXT, price INTEGER, averageRating INTEGER, image BLOB);");
    });
  }

  insertData() async {
    await initDB();

    List<Products?>? data = await ApiHelper.apiHelper.fetchData();

    for (int i = 0; i < data!.length; i++) {
      String query =
          "INSERT INTO productTable(name, categoryName, averageRating, image, price) VALUES (?, ?, ?, ?, ?)";

      List args = [
        data[i]!.name,
        data[i]!.categoryName,
        data[i]!.averageRating,
        data[i]!.image,
        data[i]!.price,
      ];

      await db?.rawInsert(query, args);
    }
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    await initDB();
    await insertData();

    String query = "SELECT * FROM productTable";

    List<Map<String, dynamic>> allData = await db!.rawQuery(query);

    // List<ProductsDB> data = allData.map((e) => ProductsDB.fromMap(e)).toList();

    print("=========================================");
    print(allData);
    print("=========================================");

    return allData;
  }

  Future<int> deleteData({required int id}) async {
    await initDB();

    String query = "DELETE FROM productTable WHERE id = ?;";
    List args = [id];

    int item = await db!.rawDelete(query, args);

    return item;
  }

  Future<int> updateData({String? name, required int id}) async {
    String query = "UPDATE productTable SET name = ? WHERE id = ?;";
    List args = [name, id];

    int item = await db!.rawUpdate(query, args);
    return item;
  }
}
