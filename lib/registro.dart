import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegistroPage extends StatelessWidget {
  final txtNome = TextEditingController();
  final txtEmail = TextEditingController();
  final txtSenha = TextEditingController();

  RegistroPage({super.key});
  void registrar(BuildContext context) async {
    if (txtNome.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, insira um nome')),
      );
      return;
    }
    if (txtEmail.text.trim().isEmpty || !txtEmail.text.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, insira um email válido')),
      );
      return;
    }
    if (txtSenha.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('A senha deve ter pelo menos 6 caracteres')),
      );
      return;
    }

    try {
      final response = await Supabase.instance.client.auth.signUp(
        email: txtEmail.text.trim(),
        password: txtSenha.text,
        data: {'display_name': txtNome.text.trim()},
      );

      if (context.mounted) {
        if (response.user != null) {
          if (response.user!.identities!.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Este email já está registrado')),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Usuário cadastrado')),
            );
            await Future.delayed(const Duration(milliseconds: 500));
            if (context.mounted) {
              Navigator.pushReplacementNamed(context, '/login');
            }
          }
        }
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
      appBar: AppBar(title: const Text("Registrar")),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: txtNome,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Nome",
              ),
            ),
            const SizedBox(height: 10),
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
            ElevatedButton(
                onPressed: () => registrar(context), child: const Text("Registrar")),
            const SizedBox(height: 10),
            TextButton(
                onPressed: () => Navigator.pop(context), child: const Text("Login")),
          ],
        ),
      ),
    );
  }
}