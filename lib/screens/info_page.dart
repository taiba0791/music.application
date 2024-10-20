import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting the Date of Birth

class UserInfoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserInfoScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class UserInfoScreen extends StatefulWidget {
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  String? username;
  String? gender;
  DateTime? dateOfBirth;
  bool termsAccepted = false;

  // Color scheme based on the provided hex colors
  final Color tangerine = Color(0xFFF38701); // Tangerine
  final Color orange = Color(0xFFF7A400); // Orange
  final Color chaletGreen = Color(0xFF616D3D); // Chalet Green
  final Color palmLeaf = Color(0xFF2F4D2A); // Palm Leaf

  // Gender options
  final List<String> genderOptions = ['Male', 'Female', 'Other'];

  // Date picker function
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != dateOfBirth) {
      setState(() {
        dateOfBirth = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Information', style: TextStyle(fontSize: 22)),
        backgroundColor: orange,
        centerTitle: true, // Center title for a balanced look
        elevation: 5, // Subtle shadow for AppBar
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView( // Make the content scrollable
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                'Enter Your Details',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: palmLeaf,
                ),
              ),
              SizedBox(height: 24),

              // Username input field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(color: palmLeaf, fontSize: 18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  hintText: 'Enter your username',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
                onSaved: (value) => username = value,
              ),
              SizedBox(height: 16),

              // Gender dropdown
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Gender',
                  labelStyle: TextStyle(color: palmLeaf, fontSize: 18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                ),
                value: gender,
                items: genderOptions.map((String gender) {
                  return DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    gender = newValue;
                  });
                },
                validator: (value) => value == null ? 'Please select gender' : null,
              ),
              SizedBox(height: 16),

              // Date of Birth picker
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: dateOfBirth == null
                          ? 'Date of Birth'
                          : 'Date of Birth: ${DateFormat('dd/MM/yyyy').format(dateOfBirth!)}',
                      labelStyle: TextStyle(color: palmLeaf, fontSize: 18),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    ),
                    validator: (value) {
                      if (dateOfBirth == null) {
                        return 'Please select your date of birth';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Terms and Conditions checkbox
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: termsAccepted,
                    activeColor: chaletGreen,
                    onChanged: (bool? value) {
                      setState(() {
                        termsAccepted = value ?? false;
                      });
                    },
                  ),
                  Expanded(
                    child: Text(
                      'I agree to the Terms and Conditions',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ],
              ),
              Text(
                'Terms and Conditions:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: palmLeaf,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '1. Music streaming is provided for personal use only.\n'
                    '2. Unauthorized reproduction or distribution is prohibited.\n'
                    '3. Subscription fees are non-refundable once paid.',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              SizedBox(height: 16),

              // Next Button
              Align(
                alignment: Alignment.bottomLeft,
                child: ElevatedButton(
                  onPressed: termsAccepted ? () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      print('User Info: $username, $gender, $dateOfBirth');
                    }
                  } : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tangerine,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    elevation: 4, // Add a slight shadow to the button
                  ),
                  child: Text(
                    'Next',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
