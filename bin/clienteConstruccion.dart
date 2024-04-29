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
  //para buscarlo-----en la tabla
  nombrecliente = map['nombre'];
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

  
  insertarCliente() async {
    var conn = await DatabaseC().conexion();
    try {
      await conn.query('INSERT INTO clientes (nombre, direccion, telefono, password) VALUES (?,?,?,?)',[nombrecliente, direccion, telefono, password]);
      print('Cliente insertado correctamente');
    } catch (e) {
      print(e);
    } finally {
      await conn.close();
    }
  }

  all2() async {
    var conn = await DatabaseC().conexion();

    try {
      var resultado = await conn.query('SELECT * FROM clientes');
      List<Cliente> clientes = resultado.map((row) => Cliente.fromMap(row)).toList();
      return clientes;
    } catch (e) {
      print(e);
    } finally {
      await conn.close();
    }
  }
}

 