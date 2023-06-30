import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SupportPage extends StatefulWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  List<dynamic> supportStaff = [];

  @override
  void initState() {
    super.initState();

    fetchSupportStaff();
  }

  Future<void> fetchSupportStaff() async {
    final response =
        await http.get(Uri.parse('https://reqres.in/api/users?page=2'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        supportStaff = data['data'];
      });
    } else {
      // Handle error case if the API request fails
      print('Failed to fetch support staff: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 210, 233, 196),
      appBar: AppBar(
        title: Text('Support Staff'),
      ),
      body: ListView.builder(
        itemCount: supportStaff.length,
        itemBuilder: (BuildContext context, int index) {
          final staff = supportStaff[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(staff['avatar']),
            ),
            title: Text('${staff['first_name']} ${staff['last_name']}'),
            subtitle: Text(staff['email']),
          );
        },
      ),
    );
  }
}
