import'dart:io';
import 'jefeConstruccio.dart';
import 'clienteConstruccion.dart';
import 'empleadoConstruccion.dart';
import 'inventario.dart';

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
   Cliente cliente = await login3();
   menuClientelogueado(cliente);
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
      3 - Inventario
      4 - Añadir objeto al inventario
      5 - Hacer factura''');
      String respuesta = stdin.readLineSync() ?? 'e';
      opcion = int.tryParse(respuesta);
    } while(opcion == null || opcion != 1 && opcion !=2 && opcion !=3 && opcion !=4);
    switch(opcion){
      case 1:
        await listarEmpleados();
        menuJefelogueado(jefe);

        break;
       case 2:
        await listarClientes();
        menuJefelogueado(jefe);
        break;
       
       case 3:
       //await hacerInventario();
       print ('caso 3 de login jefe');

       break;

       case 4:
       await pedirMaterial();
       print ('caso 4 de login jefe');
      break;
      case 5:
       //await hacerFactura();
       print ('caso 5 de login jefe');
      break;
    }
  }


  menuEmpleadologueado(Empleado empleado)async{
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
     await listarClientes();
     menuEmpleadologueado(empleado);
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


  menuClientelogueado(Cliente cliente){
    String? respuesta;
    int? opcion;
    do{
      stdout.writeln('''
     Elige una opcion:
     1.Sacar cita
     ''');
     respuesta =stdin.readLineSync() ?? 'error';
     opcion = int.tryParse(respuesta);
    }while(opcion == null);

   switch(opcion){
    case 1:
    print('caso 1 menu cliente');
    break;
   }

  }

  //LOGIN

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

login3() async {
    Cliente cliente = new Cliente();
    stdout.writeln('Introduce tu nombre de usuario');
    cliente.nombrecliente = stdin.readLineSync();
    stdout.writeln('Introduce tu constraseña');
    cliente.password = stdin.readLineSync();
    var resultado = await cliente.loginCliente();
    if(resultado == false){
     stdout.writeln('Tu nombre de usuario o contraseña son incorrectos');
     menuInicialconstruccion();
    } else {
      return resultado;
    }
  }

  //PEDIR CLIENTE Y COSAS AL INVENTARIO

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

  pedirMaterial() async{
   String? respuesta;
   int? cantidad;
   String? respuesta2;
   double? precio;
    Inventario inventario = new Inventario();
    stdout.writeln('Material:');
    inventario.material = stdin.readLineSync();
    
    do{
     stdout.writeln('Cantidad:');
     respuesta = stdin.readLineSync() ?? 'error';
     cantidad = int.tryParse(respuesta);
    }while(cantidad == null);
    inventario.cantidad = cantidad;

    
    do{
    stdout.writeln('Precio:');
    respuesta2 = stdin.readLineSync() ?? 'error';
    precio = double.tryParse(respuesta2);
    inventario.precio = precio;
    }while(precio == null);
    await inventario.insertarMaterial();
  }


  //  LISTAS CON EMPLEADOS Y CLIENTES
  listarEmpleados()async{
    List<Empleado> listadoEmpleados = await Empleado().all();
    for(Empleado elemento in listadoEmpleados){
      stdout.writeln(elemento.nombreEmpleado);
    }
  }

  
  listarClientes()async{
    List<Cliente> listadoClientes = await Cliente().all2();
    for(Cliente elemento in listadoClientes){
      stdout.writeln(elemento.nombrecliente);
    }
  }
}