import 'package:mysql1/mysql1.dart';
import 'databaseConstruccion.dart';

class Jefe {
int? idjefe;
String? nombreJefe;
String? passwordJefe;


Jefe();

  Jefe.fromMap(ResultRow map) {
    idjefe = map['idjefe'];
    nombreJefe = map['nombreJefe'];
    passwordJefe = map['passwordJefe'];
}

loginJefe() async {
    var conn = await DatabaseC().conexion();
    try {
      var resultado = await conn.query('SELECT * FROM jefe WHERE nombre = ?', [nombreJefe]);
      Jefe jefe = Jefe.fromMap(resultado.first);
      if (passwordJefe == jefe.passwordJefe) {
        return jefe;
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