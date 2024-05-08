import 'package:mysql1/mysql1.dart';
import 'databaseConstruccion.dart';


class Inventario{

int? idmaterial;
 String? material;
 int cantidad = 0;
 double precio = 0 ;


 Inventario();
 Inventario.fromMap(ResultRow map){
  idmaterial = map ['idmaterial'];
   material = map ['material'];
   cantidad = map ['cantidad'];  
   precio = map ['precio'];
   
  }

 

  insertarMaterial() async {
    var conn = await DatabaseC().conexion();
    try {
      await conn.query('INSERT INTO Materiales (idmaterial,material, cantidad, precio) VALUES (?,?,?,?)',[idmaterial,material, cantidad, precio]);
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
      var resultado = await conn.query('SELECT * FROM Materiales');
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
      await conn.query(' UPDATE  Materiales SET cantidad = (?)    WHERE idmaterial = (?)',[cantidad,idmaterial]);
      print('Cantidad cambiada correctamente');
    } catch (e) {
      print(e);
    } finally {
      await conn.close();
    }
  }
}