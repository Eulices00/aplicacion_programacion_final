import  'package:mysql1/mysql1.dart';
//bien

class DatabaseC {
  //                                     Propiedades
  final String _host = 'localhost';
  final int _port = 3306;
  final String _user = 'root';
  

  // Métodos
  //async algo que se ejecuta fuera del código
  instalacion() async {
    var settings = ConnectionSettings(
      host: this._host, 
      port: this._port,
      user: this._user,
    
    );
  


  var conn = await MySqlConnection.connect(settings); //conn variable de tipo mysqlconetion
    try{
      await _crearDB(conn);
      await _crearTablaJefe(conn);
      await _crearTablaEmpleados(conn);
      await _crearTablaCita(conn);
      await _crearTablaClientes(conn);
      await conn.close();
    } catch(e){
      print(e);
      await conn.close();
    }

  
  }

  Future<MySqlConnection> conexion() async {
    var settings = ConnectionSettings(
      host: this._host, 
      port: this._port,
      user: this._user,
      db: 'construccion'
    );
      
    return await MySqlConnection.connect(settings);
 
  }

  _crearDB (conn) async{
    await conn.query('CREATE DATABASE IF NOT EXISTS construccion');
    await conn.query('USE construccion');
    print('Conectado a construccion');
  }

  _crearTablaEmpleados(conn) async{
await conn.query('''CREATE TABLE IF NOT EXISTS Empleados(
idempleado INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(20) NOT NULL,
password VARCHAR(20) NOT NULL 
)''');

  }


_crearTablaJefe(conn) async{
  await conn.query('''CREATE TABLE IF NOT EXISTS jefe(
  idjefe INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(20) NOT NULL,
  password VARCHAR(20) NOT NULL
  )''');
  print("tabla jefe ");
}


_crearTablaCita(conn) async{
  await conn.query('''CREATE TABLE IF NOT EXISTS Cita(
idcita INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
fecha DATE NOT NULL,
hora TIME NOT NULL,
cliente VARCHAR(20) NOT NULL,
direccion VARCHAR(70) NOT NULL
)''');
}

_crearTablaClientes(conn) async{
  await conn.query('''CREATE TABLE IF NOT EXISTS Clientes(
    idcliente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    direccion VARCHAR (80) NOT NULL,
    telefono VARCHAR(9) NOT NULL,
    password VARCHAR(20) NOT NULL
  )''');
  print('tabla clientes creada');
}
}