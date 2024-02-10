import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form is valid, submitting data...')),
      );
      Navigator.of(context).pop();
    }
  }

  String? _validateName(String? value) {
    final nameExp = RegExp(r'^[A-Za-z]+(?:[ -][A-Za-z]+)*$');
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    } else if (value.length < 2 || value.length > 50) {
      return 'Name must be between 2 and 50 characters';
    } else if (!nameExp.hasMatch(value)) {
      return 'Please enter a valid name';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    final emailExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!emailExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: _validateName,
                  onSaved: (value) => name = value!.trim(),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: _validateEmail,
                  onSaved: (value) => email = value!.trim(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('Submit'),
                  ),
                ),
                const Text(
                  'Form Validation Rules:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    '1. Name must be between 2 and 50 characters, only letters, spaces, hyphens, and apostrophes are allowed.\n'
                    '2. Email must be a valid email address format.\n'
                    'Make sure to fill all fields correctly.',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
