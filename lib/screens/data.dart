import 'package:flutter/material.dart';

class Data extends StatefulWidget {
  final String name;
  final String usn;
  final String department;
  final String email;
  final String phoneNo;
  final String fatherName;
  final String motherName;
  final String dateOfBirth;
  final String studentAddress;
  final String gender;

  // final String image; // Assuming it's a URL or Asset path.

  const Data({
    super.key,
    required this.name,
    required this.usn,
    required this.department,
    required this.email,
    required this.phoneNo,
    required this.fatherName,
    required this.motherName,
    required this.dateOfBirth,
    required this.studentAddress,
    required this.gender,
    // required this.image,
  });

  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            spacing: 30,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child:
                    //widget.image.isNotEmpty
                    //     ? Image.network(
                    //         widget.image,
                    //         width: 150,
                    //         height: 150,
                    //         fit: BoxFit.cover,
                    //       ):
                    Icon(Icons.person, size: 100), // Fallback if no image
              ),
              const SizedBox(height: 20),
              Text('USN : ${widget.usn}', style: _textStyle()),
              Text('Name : ${widget.name}', style: _textStyle()),
              Text('gender : ${widget.gender}', style: _textStyle()),
              Text('Email : ${widget.email}', style: _textStyle()),
              Text('Father Name : ${widget.fatherName}', style: _textStyle()),
              Text('Mother Name : ${widget.motherName}', style: _textStyle()),
              Text('Date of Birth : ${widget.dateOfBirth}', style: _textStyle()),
              Text('Address : ${widget.studentAddress}', style: _textStyle()),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle _textStyle() {
    return const TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
  }
}
