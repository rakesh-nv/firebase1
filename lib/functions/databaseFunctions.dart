import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

Future<void> create(
  String department,
  String usn,
  String fullName,
  String email,
  String phoneNo,
  String fatherName,
  String motherName,
  String studentAddress,
  String dateOfBirth,
  String selectedGender,
  // XFile? imageFile, // Accept Image File
) async {
  // Save Data in Firestore
  await FirebaseFirestore.instance.collection(department).doc(usn).set(
    {
      'department': department,
      'usn': usn,
      'name': fullName,
      'email': email,
      'phoneNo': phoneNo,
      'fatherName': fatherName,
      'motherName': motherName,
      'studentAddress': studentAddress,
      'dateOfBirth': dateOfBirth,
      'gender': selectedGender
      // 'image': imageUrl, // Store Image URL
    },
  );
  print('Database is Updated');
}

update(String department, usn, field, var newFieldValue) async {
  await FirebaseFirestore.instance.collection(department).doc(usn).update(
    {
      field: newFieldValue,
    },
  );
  print('updated successfully');
}

delete(String department, usn) async {
  await FirebaseFirestore.instance.collection(department).doc(usn).delete();
  print('Document deleted');
}
