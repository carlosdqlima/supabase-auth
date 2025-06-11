import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todolist/create.dart';
import 'package:todolist/lista.dart';
import 'package:todolist/login.dart';
import 'package:todolist/registro.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Carregar variáveis de ambiente
  await dotenv.load(fileName: ".env");
  
  // Configurar Firebase usando variáveis de ambiente
  final firebaseConfig = FirebaseOptions(
    apiKey: dotenv.env['FIREBASE_API_KEY']!,
    authDomain: dotenv.env['FIREBASE_AUTH_DOMAIN']!,
    projectId: dotenv.env['FIREBASE_PROJECT_ID']!,
    storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET']!,
    messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID']!,
    appId: dotenv.env['FIREBASE_APP_ID']!,
  );
  
  await Firebase.initializeApp(options: firebaseConfig);
  
  // Configurar Supabase usando variáveis de ambiente
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  
  runApp(const TodoListApp());
}

class TodoListApp extends StatelessWidget {
  const TodoListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false),
      routes: {
        "/lista": (context) => ListaPage(),
        "/create": (context) => CreatePage(),
        "/login": (context) => LoginPage(),
        "/registro": (context) => RegistroPage(),
      },
      initialRoute: "/login",
    );
  }
}