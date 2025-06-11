import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatelessWidget {
  final txtEmail = TextEditingController();
  final txtSenha = TextEditingController();

  LoginPage({super.key});
  void login(BuildContext context) async {
    try {
      await Supabase.instance.client.auth.signInWithPassword(
        email: txtEmail.text.trim(),
        password: txtSenha.text,
      );
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, "/lista");
      }
    } on AuthException catch (ex) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(ex.message)),
        );
      }
    } catch (ex) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro inesperado: $ex')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: txtEmail,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Email",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: txtSenha,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Senha",
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: () => login(context), child: const Text("Login")),
            const SizedBox(height: 10),
            TextButton(
                onPressed: () => Navigator.pushNamed(context, "/registro"),
                child: const Text("Registre-se")),
          ],
        ),
      ),
    );
  }
}