import'dart:io';
import 'jefeConstruccio.dart';
import 'clienteConstruccion.dart';
import 'empleadoConstruccion.dart';

class App{

menuInicialconstruccion(){
int? opcion;
String? respuesta;
do{
  stdout.writeln('''
1.Iniciar sesión como jefe.
2.Iniciar sesión como empleado.
3.Iniciar sesión como cliente.
4.Crear cuenta.
''');
respuesta = stdin.readLineSync() ?? 'error';
opcion = int.tryParse(respuesta);
}while(opcion == null || opcion != 1 && opcion !=2 && opcion != 3 && opcion !=4);


switch(opcion){

case 1:
Jefe().loginJefe();
print('caso 1');
break;
case 2:
Empleado().loginEmpleado();
print('caso 2');
break;
case 3:
Cliente().loginCliente();
break;
case 4:
//crearCuentacliente();
}

}
menuJefelogueado(Jefe jefe) async {
    int? opcion;
    String? nombre = jefe.nombreJefe;
    do{
      stdout.writeln('''Hola, $nombre, elige una opción
      1 - Listar empleados
      2 - Listar clientes
      3. Inventario
      4 - Hacer factura''');
      String respuesta = stdin.readLineSync() ?? 'e';
      opcion = int.tryParse(respuesta);
    } while(opcion == null || opcion != 1 && opcion !=2 && opcion !=3 && opcion !=4);
    switch(opcion){
      case 1:
        //await listarEmpleados();
        //menuJefelogueado(jefe);
        print('caso 1 login jefe');

        break;
      case 2:
        //await listarClientes(jefe.idjefe);
        print ('caso 2 de login jefe');
        break;
}
}
  login() async {
    Jefe jefe = new Jefe();
    stdout.writeln('Introduce tu nombre de usuario');
    jefe.nombreJefe = stdin.readLineSync();
    stdout.writeln('Introduce tu constraseña');
    jefe.passwordJefe = stdin.readLineSync();
    var resultado = await jefe.loginJefe();
    if(resultado == false){
      stdout.writeln('Tu nombre de usuario o contraseña son incorrectos');
      menuInicialconstruccion();
    } else {
      menuJefelogueado(resultado);
    }
  }
}