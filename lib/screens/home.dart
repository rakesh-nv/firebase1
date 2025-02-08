import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase1/functions/databaseFunctions.dart';
import 'package:firebase1/screens/data.dart';
import 'package:firebase1/screens/formfilling.dart';
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
        title: const Text('Database Options'),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FormFilling(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('mca').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return const Center(child: Text("Error loading data"));
                  }

                  final details = snapshot.data?.docs;

                  if (details == null || details.isEmpty) {
                    return const Center(child: Text("No data available"));
                  }

                  return ListView.builder(
                    itemCount: details.length,
                    itemBuilder: (context, index) {
                      final data =
                          details[index].data() as Map<String, dynamic>;

                      return Card(
                        child: Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Data(
                                        name: data['name'] ?? "N/A",
                                        usn: data['usn'] ?? "N/A",
                                        department: data['department'] ?? "N/A",
                                        email: data['email'] ?? "N/A",
                                        phoneNo: data['phoneNo'] ?? "N/A",
                                        fatherName: data['fatherName'] ?? "N/A",
                                        motherName: data['motherName'] ?? "N/A",
                                        dateOfBirth:
                                            data['dateOfBirth'] ?? "N/A",
                                        studentAddress:
                                            data['studentAddress'] ?? "N/A",
                                        gender: data['gender'] ?? "n/A",
                                        // image: data['image'] ?? "",
                                      ),
                                    ),
                                  );
                                },
                                leading: CircleAvatar(
                                  radius: 25,
                                  // backgroundImage: data['image'] != null &&
                                  //         data['image'].isNotEmpty
                                  //     ? NetworkImage(data['image'])
                                  //     : null,
                                  child: data['image'] == null ||
                                          data['image'].isEmpty
                                      ? const Icon(Icons.person)
                                      : null,
                                ),
                                title: Text(data['name'] ?? "No Name"),
                                subtitle: Text(data['usn'] ?? "No USN"),
                              ),
                            ),
                            InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(5)),
                                height: 35,
                                width: 35,
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () {
                                delete(data['department'],data['usn']);
                                print('delete');
                              },

                            ),
                            const SizedBox(
                              width: 20,
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
