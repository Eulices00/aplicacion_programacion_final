import 'package:mysql1/mysql1.dart';
import 'databaseConstruccion.dart';


class Cliente{

int? idcliente;
String? direccion;
String? telefono;
String? nombrecliente;
String? password;





Cliente();
Cliente.fromMap(ResultRow map){
  idcliente = map['idcliente'];
  direccion = map['direccion'];
  telefono = map['telefono'];
  nombrecliente = map['nombrecliente'];
  password = map ['password'];
}


loginCliente() async {
    var conn = await DatabaseC().conexion();
    try {
      var resultado = await conn.query('SELECT * FROM clientes WHERE nombre = ?', [nombrecliente]);
      Cliente cliente = Cliente.fromMap(resultado.first);
      if (password == cliente.password) {
        return cliente;
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

 