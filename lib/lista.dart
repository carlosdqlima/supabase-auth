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
        title: Text("Tasks"),
        actions: [
          IconButton(
              onPressed: () async {
                await Supabase.instance.client.auth.signOut();
                Navigator.pushReplacementNamed(context, "/login");
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection("tasks")
              .where('uid', isEqualTo: user.id)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Text("Carregando...");

            return ListView(
              children: snapshot.data!.docs.map((doc) {
                return Dismissible(
                  background: Container(color: Colors.red),
                  key: Key(doc.id),
                  onDismissed: (_) => doc.reference.delete(),
                  child: CheckboxListTile(
                    value: doc['completed'],
                    onChanged: (value) => doc.reference.update({
                      "completed": value,
                      "updateDate": DateTime.now()
                    }),
                    title: Text(doc['title']),
                    subtitle: Text("Prioridade: ${doc['priority'] ?? 'Não definida'}"),
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