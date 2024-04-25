import'dart:io';
import 'jefeConstruccio.dart';
import 'clienteConstruccion.dart';
import 'empleadoConstruccion.dart';

class App{

 menuInicialconstruccion() async {
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
   Jefe jefe = await login();
   menuJefelogueado(jefe);
   break;
   case 2:
   Empleado empleado  = await login2();
   menuEmpleadologueado(empleado);
   break;
   case 3:
   Cliente().loginCliente();
   break;
   case 4:
   crearCliente();
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
       
       case 3:
       //await hacerInventario();
       print ('caso 3 de login jefe');

       break;

       case 4:
       //await hacerFactura();
       print ('caso 4 de login jefe');
      break;
    }
  }


  menuEmpleadologueado(Empleado empleado){
   int? opcion;
   String? respuesta;
   
   do{
     stdout.writeln('''
     1. Lista clientes
     2. Inventario
     3. Hacer factura
     ''');
     respuesta =stdin.readLineSync() ?? 'error';
     opcion = int.tryParse(respuesta);
    }while(opcion == null);


    switch(opcion){
     case 1:
     print('caso 1 menu empleado');
      //await listarClientes(jefe.idjefe);
     break;
      
      case 2:
      print('caso 2 menu empleado');
      //await hacerInventario();
      break;
      
      case 3:
      print('caso 3 menu empleado');
      //await hacerFactura();



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
      return resultado;
    }
  }

  login2() async {
    Empleado empleado = new Empleado();
    stdout.writeln('Introduce tu nombre de usuario');
    empleado.nombreEmpleado = stdin.readLineSync();
    stdout.writeln('Introduce tu constraseña');
    empleado.passwordEmpleado = stdin.readLineSync();
    var resultado = await empleado.loginEmpleado();
    if(resultado == false){
     stdout.writeln('Tu nombre de usuario o contraseña son incorrectos');
     menuInicialconstruccion();
    } else {
      return resultado;
    }
  }


   crearCliente() async {
    Cliente cliente = new Cliente();
    stdout.writeln('Introduce un nombre');
    cliente.nombrecliente = stdin.readLineSync();

    stdout.writeln('Introduce una direccion');
    cliente.direccion = stdin.readLineSync();
       
   stdout.writeln('Introduce un teléfono');
   cliente.telefono = stdin.readLineSync();

   stdout.writeln('Introduce una contraseña');
   cliente.password = stdin.readLineSync();
    
    await cliente.insertarCliente();
    menuInicialconstruccion();
  }
}