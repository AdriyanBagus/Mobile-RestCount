import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/api/services.dart';
import 'package:mobile/pages/account_setting.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'account_settings_screen.dart'; // Import the account settings screen

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<Map<String, dynamic>> _profileData;

  @override
  void initState() {
    super.initState();
    _profileData = fetchProfile();
  }

  Future<Map<String, dynamic>> fetchProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('accessToken');

    if (token == null) {
      throw Exception('No token found');
    }

    print('Access Token: $token'); // Logging token

    final url = Uri.parse(AppServices.getProfileEndpoint());
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      print('Profile Data: ${response.body}'); // Logging response
      return json.decode(response.body);
    } else if (response.statusCode == 404) {
      throw Exception('User not found');
    } else {
      throw Exception(
          'Failed to load profile: ${response.statusCode}'); // Logging error status
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('accessToken');

    if (token == null) {
      throw Exception('No token found');
    }

    final url = Uri.parse(AppServices.getLogoutEndpoint());
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print('Logout successful'); // Logging success message
      await prefs.remove('accessToken'); // Clear the token
      Navigator.of(context).pushReplacementNamed('/signin'); // Navigate to login
    } else {
      throw Exception('Failed to log out: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _profileData,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No profile data found'));
          } else {
            final profileData = snapshot.data!;
            return Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage(profileData['profile_picture']),
      ),
      SizedBox(height: 20),
      Text(
        profileData['username'],
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 10),
      Text(
        profileData['email'],
        style: TextStyle(fontSize: 18, color: Colors.grey),
      ),
      SizedBox(height: 20),
      ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AccountSettings(),
            ),
          );
        },
        child: Text('Account Settings'),
      ),
      SizedBox(height: 20),
      ElevatedButton(
        onPressed: () async {
          await logout();
        },
        child: Text('Logout'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red, // Button color
        ),
      ),
    ],
  ),
);
          }
        },
      ),
    );
  }
}