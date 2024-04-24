import 'package:mysql1/mysql1.dart';
import 'databaseConstruccion.dart';

class Empleado {
int? _idempleado;
String? _nombreEmpleado;
String? _passwordEmpleado;

String? get nombreEmpleado {
    return _nombreEmpleado;
  }

int? get idempleado{
    return _idempleado;
  }

  set nombreEmpleado(String? texto) {
    _nombreEmpleado = texto;
  }

  String? get passwordEmpleado {
    return _passwordEmpleado;
  }

  set passwordEmpleado(String? texto) {
    _passwordEmpleado = texto;
  }


Empleado();

  Empleado.fromMap(ResultRow map) {
    _idempleado = map['idempleado'];
    _nombreEmpleado = map['nombreEmpleado'];
    _passwordEmpleado = map['passwordEmpleado'];
  }

loginEmpleado() async {
    var conn = await DatabaseC().conexion();
    try {
      var resultado = await conn.query('SELECT * FROM Empleados WHERE nombre = ?', [_nombreEmpleado]);
      Empleado empleado = Empleado.fromMap(resultado.first);
      if (_passwordEmpleado == empleado.passwordEmpleado) {
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

}