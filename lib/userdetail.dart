import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserDetailPage extends StatefulWidget {
  final int id;

  UserDetailPage({required this.id});

  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  Future<Map<String, dynamic>> getUserDetail() async {
    var response = await http
        .get(Uri.http('jsonplaceholder.typicode.com', 'users/${widget.id}'));
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Detail'),
      ),
      body: FutureBuilder(
        future: getUserDetail(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            var user = snapshot.data;
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${user!["name"]}'),
                  Text('${user["email"]}'),
                  Text('${user["username"]}'),
                  Text('${user["address"]["street"]}'),
                  Text('${user["address"]["suite"]}'),
                  Text('${user["address"]["zipcode"]}'),
                  Text('${user["address"]["geo"]["lat"]}'),
                  Text('${user["address"]["geo"]["lng"]}'),
                  Text('${user["phone"]}'),
                  Text('${user["website"]}'),
                  Text('${user["company"]["name"]}'),
                  Text('${user["company"]["catchPhrase"]}'),
                  Text('${user["company"]["bs"]}'),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
