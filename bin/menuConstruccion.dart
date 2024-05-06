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
   Empleado empleado  = await loginEmpleados();
   menuEmpleadologueado(empleado);
   break;
   case 3:
   Cliente cliente = await loginClientes();
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
      4 - Hacer factura''');
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
       await menuInventario(jefe);

       break;

       case 4:
       //await hacerFactura(jefe);
       print ('caso 4 de login jefe');
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
    }while(opcion == null ||  opcion != 1 &&  opcion != 2 && opcion != 3);


    switch(opcion){
     case 1:
     await listarClientes();
     menuEmpleadologueado(empleado);
     break;
      
      case 2:
      print('caso 2 menu empleado');
      await verInventario();
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
    }while(opcion == null ||  opcion != 1 );

   switch(opcion){
    case 1:
    print('caso 1 menu cliente');
    break;
   }

  }


  menuInventario(Jefe jefe) async{
   String? respuesta;
   int? opcion;
   do{
    stdout.writeln('''
   1. Ver inventario
   2. Añadir material
   3. Eliminar material
   ''');
   respuesta = stdin.readLineSync() ?? 'error';
   opcion = int.tryParse(respuesta);
   }while(opcion == null || opcion != 1 && opcion != 2 && opcion != 3);
   switch(opcion) {
    case 1:
     await verInventario();
    break;

    case 2:
     await pedirMaterial();
    break;

    case 3:
    await eliminarMaterial();
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

  loginEmpleados() async {
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

  loginClientes() async {
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

  //PEDIR CLIENTE Y COSAS PARA AÑADIR AL INVENTARIO

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
    }while(precio == null);
    inventario.precio = precio;
    await inventario.insertarMaterial();
  }
  

  //  LISTAS CON EMPLEADOS, CLIENTES E INVENTARIO
  listarEmpleados()async{
    List<Empleado> listadoEmpleados = await Empleado().allEmpleados();
    for(Empleado elemento in listadoEmpleados){
      stdout.writeln(elemento.nombreEmpleado);
    }
  }

  
  listarClientes()async{
    List<Cliente> listadoClientes = await Cliente().allClientes();
    for(Cliente elemento in listadoClientes){
      stdout.writeln(elemento.nombrecliente);
    }
  }

  verInventario() async {
   List<Inventario> listadoInventario = await Inventario().allInventario();
   for(Inventario elemento  in listadoInventario){
  
    double total = elemento.cantidad * elemento.precio;
    
    stdout.writeln('''
      Material               Cantidad              Precio/u               Total
      ${elemento.material}                  ${elemento.cantidad}                 ${elemento.precio}                    ${total}
    ''');
   }
  }

  eliminarMaterial()async{
   String? material;
   String? respuestacantidad;
   int ? cantidad;
   Inventario inventario = new Inventario();

    stdout.writeln('Material a eliminar:');
    material = stdin.readLineSync() ?? 'e';

    if(material == inventario.material){
      stdout.writeln('Cantidad a cambiar');
      respuestacantidad = stdin.readLineSync()?? 'error';
      cantidad = int.tryParse(respuestacantidad);
      inventario.material = material;
      await inventario.cambiarCantidad();

    
    }else{
      stdout.writeln('Ese material no está en la base de datos');
    }

  }
}