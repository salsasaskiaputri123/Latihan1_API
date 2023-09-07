import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DataFromAPI(),
    );
  }
}

class DataFromAPI extends StatelessWidget {
  const DataFromAPI({super.key});

  Future<User> getUserDataById(int userId) async {
    var response = await http
        .get(Uri.http('jsonplaceholder.typicode.com', 'users/$userId'));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      User user = User(
        jsonData["name"],
        jsonData["email"],
        jsonData["username"],
        jsonData["address"]["street"],
        jsonData["address"]["suite"],
        jsonData["address"]["city"],
        jsonData["address"]["zipcode"],
        jsonData["address"]["geo"]["lat"],
        jsonData["address"]["geo"]["lng"],
        jsonData["phone"],
        jsonData["website"],
        jsonData["company"]["name"],
        jsonData["company"]["catchPhrase"],
        jsonData["company"]["bs"],
      );
      return user;
    } else {
      throw Exception('Failed to load user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Data API 1')),
      ),
      body: Container(
          child: FutureBuilder(
        future: getUserDataById(1),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              child: Center(
                child: Text('Loading...'),
              ),
            );
          } else if (snapshot.hasError) {
            return Container(
              child: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            );
          } else {
            User user = snapshot.data!;
            return ListView(
              children: [
                ListTile(
                  title: Text(user.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.username),
                      Text(user.email),
                      Text(user.addressstreet),
                      Text(user.addresssuite),
                      Text(user.addresscity),
                      Text(user.addresszipcode),
                      Text(user.addressgeolat),
                      Text(user.addressgeolng),
                      Text(user.phone),
                      Text(user.website),
                      Text(user.companyname),
                      Text(user.companycatchPhrase),
                      Text(user.companybs),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      )),
    );
  }
}

class User {
  final String name,
      email,
      username,
      addressstreet,
      addresssuite,
      addresscity,
      addresszipcode,
      addressgeolat,
      addressgeolng,
      phone,
      website,
      companyname,
      companycatchPhrase,
      companybs;
  User(
    this.name,
    this.email,
    this.username,
    this.addressstreet,
    this.addresssuite,
    this.addresscity,
    this.addresszipcode,
    this.addressgeolat,
    this.addressgeolng,
    this.phone,
    this.website,
    this.companyname,
    this.companycatchPhrase,
    this.companybs,
  );
}