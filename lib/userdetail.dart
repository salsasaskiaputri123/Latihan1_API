import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserDetailPage extends StatelessWidget {
  final userId;

  UserDetailPage(this.userId, {Key? key}) : super(key: key);

  Future getUserData(userId) async {
    var response = await http
        .get(Uri.http('jsonplaceholder.typicode.com', 'users/$userId'));
    var jsonData = jsonDecode(response.body);

    if (jsonData != null) {
      return User(
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
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Detail'),
      ),
      body: Container(
        child: FutureBuilder(
          future: getUserData(userId),
          builder: (context, User) {
            if (User == null) {
              return Container(
                child: Center(
                  child: Text('Loading...'),
                ),
              );
            } else {
              return ListTile(
                title: Text(userId.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(userId.username),
                    Text(userId.email),
                    Text(userId.addressstreet),
                    Text(userId.addresssuite),
                    Text(userId.addresscity),
                    Text(userId.addresszipcode),
                    Text(userId.addressgeolat),
                    Text(userId.addressgeolng),
                    Text(userId.phone),
                    Text(userId.website),
                    Text(userId.companyname),
                    Text(userId.companycatchPhrase),
                    Text(userId.companybs),
                  ],
                ),
              );
            }
          },
        ),
      ),
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
