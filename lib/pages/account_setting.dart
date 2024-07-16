import 'package:flutter/material.dart';
import 'change_password.dart'; // Import the change password screen
// Import screens for updating email and profile picture
import 'update_email.dart';
import 'update_profile_picture.dart';

class AccountSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Account settings go here'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdatePasswordPage(),
                  ),
                );
              },
              child: Text('Change Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateEmailScreen(),
                  ),
                );
              },
              child: Text('Change Email'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(),
                  ),
                );
              },
              child: Text('Change Profile Picture'),
            ),
          ],
        ),
      ),
    );
  }
}
