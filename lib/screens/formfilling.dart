import 'dart:io';
import 'package:firebase1/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../functions/databaseFunctions.dart';

class FormFilling extends StatefulWidget {
  const FormFilling({super.key});

  @override
  State<FormFilling> createState() => _FormFillingState();
}

class _FormFillingState extends State<FormFilling> {
  final _formkey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController _usnController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _motherNameController = TextEditingController();
  final TextEditingController _studentAddressController =
      TextEditingController();
  String dateOfBirth = '';
  String? _selectedGender;
  XFile? _imageFile;
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fill the form')),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTextField(
                    'department', 'department name', departmentController),
                buildTextField(
                    'Full Name:', 'Enter your name', fullNameController),
                buildTextField('USN:', 'Enter USN', _usnController),
                buildDatePicker(),
                buildGenderSelection(),
                buildTextField('Email:', 'Enter Email', _emailController),
                buildTextField(
                    'Phone No:', 'Enter Phone Number', _phoneNoController,
                    isNumeric: true),
                buildTextField(
                    'Father Name:', 'Enter Father Name', _fatherNameController),
                buildTextField(
                    'Mother Name:', 'Enter Mother Name', _motherNameController),
                buildTextField('Student Address:', 'Enter Address',
                    _studentAddressController,
                    isMultiline: true),
                buildImagePicker(),
                const SizedBox(height: 10),
                buildSubmitButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
    String label,
    String hint,
    TextEditingController controller, {
    bool isNumeric = false,
    bool isMultiline = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          keyboardType: isNumeric
              ? TextInputType.number
              : (isMultiline ? TextInputType.multiline : TextInputType.text),
          maxLines: isMultiline ? 4 : 1,
          decoration: InputDecoration(
            labelText: hint,
            border: const OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'This field cannot be empty';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget buildDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Date of Birth:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: TextEditingController(text: dateOfBirth),
          readOnly: true,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: const Icon(Icons.calendar_month),
              onPressed: () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2026),
                );
                if (pickedDate != null) {
                  setState(() {
                    dateOfBirth = pickedDate.toLocal().toString().split(' ')[0];
                  });
                }
              },
            ),
            border: const OutlineInputBorder(),
          ),
          validator: (value) {
            if (dateOfBirth.isEmpty) {
              return 'Please select a date of birth';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget buildGenderSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Gender:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Row(
          children: [
            Radio<String>(
              value: 'Male',
              groupValue: _selectedGender,
              onChanged: (value) => setState(() => _selectedGender = value),
            ),
            const Text('Male'),
            Radio<String>(
              value: 'Female',
              groupValue: _selectedGender,
              onChanged: (value) => setState(() => _selectedGender = value),
            ),
            const Text('Female'),
          ],
        ),
        if (_selectedGender == null)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Text('Please select a gender',
                style: TextStyle(color: Colors.red, fontSize: 14)),
          ),
        const SizedBox(height: 20),
      ],
    );
  }


  Widget buildImagePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _imageFile == null
            ? const Text('No image selected')
            : SizedBox(
                height: 150,
                width: 150,
                child: Image.file(File(_imageFile!.path), fit: BoxFit.contain),
              ),
        const SizedBox(height: 10),
        Row(
          children: [
            ElevatedButton(
              onPressed: () async {
                final XFile? image =
                    await picker.pickImage(source: ImageSource.gallery);
                setState(() => _imageFile = image);
              },
              child: const Text('Pick from Gallery'),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () async {
                final XFile? image = await picker.pickImage(
                  source: ImageSource.camera,
                );
                setState(
                  () => _imageFile = image,
                );
              },
              child: const Text('Pick from Camera'),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget buildSubmitButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            _formkey.currentState!.reset();
            setState(() {
              _selectedGender = null;
              dateOfBirth = '';
              _imageFile = null;
            });
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          child: const Text('Clear', style: TextStyle(color: Colors.white)),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formkey.currentState!.validate() && _selectedGender != null) {
              create(
                departmentController.text,
                _usnController.text,
                fullNameController.text,
                _emailController.text,
                _phoneNoController.text,
                _fatherNameController.text,
                _motherNameController.text,
                _studentAddressController.text,
                dateOfBirth, // Missing comma added here
                _selectedGender!,
                // _imageFile, // Pass Image File
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Home(),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please fill all fields'),
                ),
              );
            }
          },
          child: const Text('Submit'),
        ),

      ],
    );
  }
}
