import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/api/services.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UpdateEmailScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Email'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter your new email address',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'New Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your new email';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _updateEmail(context);
              },
              child: Text('Update Email'),
            ),
          ],
        ),
      ),
    );
  }

  void _updateEmail(BuildContext context) async {
    final newEmail = _emailController.text;
    if (newEmail.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your new email')),
      );
      return;
    }

    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('accessToken');
      final url = Uri.parse(AppServices.getChangeEmailEndpoint());
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          if (token != null)
            'Authorization':
                'Bearer $token', // Replace with your actual JWT token
        },
        body: json.encode({'new_email': newEmail}),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email updated successfully')),
        );
        // Optionally navigate to another screen or perform any other action upon success
        // Navigator.pushNamed(context, '/confirmation_screen');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update email')),
        );
      }
    } catch (e) {
      print('Error updating email: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred')),
      );
    }
  }
}
