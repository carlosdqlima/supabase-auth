// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  var txtTask = TextEditingController();
  String priority = "Média";  void create(BuildContext context) async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuário não autenticado')),
      );
      return;
    }

    if (txtTask.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, insira uma tarefa')),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('tasks').add({
        "title": txtTask.text.trim(),
        "completed": false,
        "userId": user.id,
        "priority": priority,
        "name": user.userMetadata?['display_name'] ?? user.email?.split('@')[0] ?? 'Usuário',
        "createdAt": FieldValue.serverTimestamp(),
        "updatedAt": FieldValue.serverTimestamp(),
      });

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tarefa criada com sucesso!')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao criar tarefa: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("New Task")),
        body: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                controller: txtTask,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Task"),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: priority,
                items: ["Alta", "Média", "Baixa"]
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    priority = value!;
                  });
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Prioridade"),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () => create(context), child: Text("Salvar")),
            ],
          ),
        ));
  }
}