import 'package:mysql1/mysql1.dart';
import 'databaseConstruccion.dart';


class Inventario{

 String? material;
 int cantidad = 0;
 double precio = 0 ;


 Inventario();
 Inventario.fromMap(ResultRow map){
   material = map ['material'];
   cantidad = map ['cantidad'];  
   precio = map ['precio'];
   
  }

 

  insertarMaterial() async {
    var conn = await DatabaseC().conexion();
    try {
      await conn.query('INSERT INTO Inventario (material, cantidad, precio) VALUES (?,?,?)',[material, cantidad, precio]);
      print('Material guardado correctamente');
    } catch (e) {
      print(e);
    } finally {
      await conn.close();
    }
  }

  allInventario() async {
    var conn = await DatabaseC().conexion();

    try {
      var resultado = await conn.query('SELECT * FROM Inventario');
      List<Inventario> inventario = resultado.map((row) => Inventario.fromMap(row)).toList();
      return inventario;
    } catch (e) {
      print(e);
    } finally {
      await conn.close();
    }
  }

  cambiarCantidad() async {
    var conn = await DatabaseC().conexion();
    try {
      await conn.query('INSERT INTO Inventario (cantidad) VALUES (?)',[ cantidad]);
      print('Cantidad cambiado correctamente');
    } catch (e) {
      print(e);
    } finally {
      await conn.close();
    }
  }
}