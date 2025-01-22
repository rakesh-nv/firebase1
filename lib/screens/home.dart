import 'package:firebase1/functions/databaseFunctions.dart';
import 'package:flutter/cupertino.dart';
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
        title: Text('Database options'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  create('pets', 'kitty', 'jerry', 'jerry', 20);
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
                onPressed: () {},
                child: const Text("Retrieve"),
              ),
              ElevatedButton(
                onPressed: () {
                  delete('pets', 'tom');
                },
                child: const Text("Delete"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
