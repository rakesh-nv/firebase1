import 'package:firebase1/functions/databaseFunctions.dart';
import 'package:firebase1/screens/pets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Database options'),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                create('pets','bully', 'bully', 'bull', 10);
              },
              child: const Text("Create"),
            ),
            ElevatedButton(
              onPressed: () {
                update('pets', 'tom', 'animal', 'tiger');
              },
              child: const Text("Update"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PetsList(),
                  ),
                );
              },
              child: const Text("Retrieve"),
            ),
            ElevatedButton(
              onPressed: () {
                delete("pets",'kitty');
              },
              child: const Text("Delete"),
            ),
          ],
        ),
      ),
    );
  }
}
