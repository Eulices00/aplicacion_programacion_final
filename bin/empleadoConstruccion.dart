import 'package:mysql1/mysql1.dart';
import 'databaseConstruccion.dart';

class Empleado {
int? idempleado;
String? nombreEmpleado;
String? passwordEmpleado;



Empleado();

  Empleado.fromMap(ResultRow map) {
    idempleado = map['idempleado'];
    nombreEmpleado = map['nombre'];
    passwordEmpleado = map['password'];
  }

loginEmpleado() async {
    var conn = await DatabaseC().conexion();
    try {
      var resultado = await conn.query('SELECT * FROM empleados WHERE nombre = ?', [nombreEmpleado]);
      Empleado empleado = Empleado.fromMap(resultado.first);
      if (passwordEmpleado == empleado.passwordEmpleado) {
        return empleado;
      } else
        return false;
    } catch (e) {
      print(e);
      return false;
    } finally {
      await conn.close();
    }
  }


all() async {
    var conn = await DatabaseC().conexion();

    try {
      var resultado = await conn.query('SELECT * FROM empleados');
      List<Empleado> empleados =
          resultado.map((row) => Empleado.fromMap(row)).toList();
      return empleados;
    } catch (e) {
      print(e);
    } finally {
      await conn.close();
    }
  }
}