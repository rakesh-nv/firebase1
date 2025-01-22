import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

create(String collName, docName, name, animal, int age) async {
  await FirebaseFirestore.instance.collection(collName).doc(docName).set(
    {
      'name': name,
      'animal': 'animal',
      'age': age,
    },
  );
  print('Database is Updated');
}

update(String collName, docName, field, var newFieldValue) async {
  await FirebaseFirestore.instance.collection(collName).doc(docName).update(
    {
      field: newFieldValue,
    },
  );
  print('updated successfully');
}

delete(String collName, docName) async {
  await FirebaseFirestore.instance.collection(collName).doc(docName).delete();
  print('Document deleted');
}
