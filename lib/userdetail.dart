import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserDetailPage extends StatelessWidget {
  const UserDetailPage(data, {super.key});

  Future getUserData(int userId) async {
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
        title: Center(child: Text('Data API 1')),
      ),
      body: Container(
        child: FutureBuilder(
          future: getUserData(2),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text('Loading...'),
                ),
              );
            } else {
              return ListTile(
                title: Text(snapshot.data.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(snapshot.data.username),
                    Text(snapshot.data.email),
                    Text(snapshot.data.addressstreet),
                    Text(snapshot.data.addresssuite),
                    Text(snapshot.data.addresscity),
                    Text(snapshot.data.addresszipcode),
                    Text(snapshot.data.addressgeolat),
                    Text(snapshot.data.addressgeolng),
                    Text(snapshot.data.phone),
                    Text(snapshot.data.website),
                    Text(snapshot.data.companyname),
                    Text(snapshot.data.companycatchPhrase),
                    Text(snapshot.data.companybs),
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
