import 'package:mysql1/mysql1.dart';
import 'databaseConstruccion.dart';


class Inventario{

String? material;
int? cantidad;
double? precio;

Inventario();
Inventario.fromMap(ResultRow map){
material = map ['material'];
cantidad = map ['cantidad'];
precio = map ['precio'];

}

 

 insertarMaterial() async {
    var conn = await DatabaseC().conexion();
    try {
      await conn.query('INSERT INTO inventario (material, cantidad, precio,) VALUES (?,?,?)',[material, cantidad, precio]);
      print('Material insertado correctamente');
    } catch (e) {
      print(e);
    } finally {
      await conn.close();
    }
  }
}