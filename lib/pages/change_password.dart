import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/api/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdatePasswordPage extends StatefulWidget {
  @override
  _UpdatePasswordPageState createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  Future<void> _updatePassword() async {
    String apiUrl = AppServices.getUpdatePasswordEndpoint();

    try {
      // Retrieve the JWT token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('accessToken');

      var response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, String>{
          'current_password': _currentPasswordController.text,
          'new_password': _newPasswordController.text,
        }),
      );

      if (response.statusCode == 200) {
        // Password updated successfully
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password updated successfully')),
        );
      } else {
        // Handle other status codes like 400, 401, 404, 500
        print(
            'Failed to update password: ${response.body}'); // Print the error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to update password: ${response.body}')),
        );
      }
    } catch (e) {
      // Handle other errors
      print('An error occurred: $e'); // Print the exception
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _currentPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Current Password',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'New Password',
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _updatePassword,
              child: Text('Update Password'),
            ),
          ],
        ),
      ),
    );
  }
}
//molextv826@gmail.com
// nauval2503