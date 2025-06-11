// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ListaPage extends StatelessWidget {
  const ListaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/login');
      });
      return Container(); 
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Tasks"),        actions: [
          IconButton(
              onPressed: () async {
                await Supabase.instance.client.auth.signOut();
                if (context.mounted) {
                  Navigator.pushReplacementNamed(context, "/login");
                }
              },
              icon: const Icon(Icons.logout))
        ],
      ),      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection("tasks")
              .where('userId', isEqualTo: user.id)
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Text("Carregando...");

            return ListView(
              children: snapshot.data!.docs.map((doc) {
                return Dismissible(
                  background: Container(color: Colors.red),
                  key: Key(doc.id),
                  onDismissed: (_) => doc.reference.delete(),                  child: CheckboxListTile(
                    value: doc['completed'],
                    onChanged: (value) => doc.reference.update({
                      "completed": value,
                      "updatedAt": FieldValue.serverTimestamp()
                    }),
                    title: Text(doc['title']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Prioridade: ${doc['priority'] ?? 'Não definida'}"),
                        if (doc['name'] != null) Text("Criado por: ${doc['name']}"),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, "/create"),
      ),
    );
  }
}