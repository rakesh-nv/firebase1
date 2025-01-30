import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PetsList extends StatefulWidget {
  const PetsList({super.key});

  @override
  State<PetsList> createState() => _PetsListState();
}

class _PetsListState extends State<PetsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('my pets'),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('pets').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final petDocs = snapshot.data?.docs;
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(petDocs?[index]['name']),
                      subtitle: Text(petDocs?[index]['animal']),
                    ),
                  );
                },
                itemCount:petDocs?.length,
              );
            }
          },
        ),
      ),
    );
  }
}
