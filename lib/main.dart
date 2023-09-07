import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  Future getUserData() async {
    var response =
        await http.get(Uri.http('jsonplaceholder.typicode.com', 'users'));
    var jsonData = jsonDecode(response.body);
    List<User> users = [];

    for (var u in jsonData) {
      User user = User(
        u["name"],
        u["email"],
        u["username"],
        u["address"]["street"],
        u["address"]["suite"],
        u["address"]["city"],
        u["address"]["zipcode"],
        u["address"]["geo"]["lat"],
        u["address"]["geo"]["lng"],
        u["phone"],
        u["website"],
        u["company"]["name"],
        u["company"]["catchPhrase"],
        u["company"]["bs"],
      );
      users.add(user);
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Data API 1')),
      ),
      body: Container(
        child: FutureBuilder(
          future: getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data.isEmpty) {
              return Center(
                child: Text('No data available'),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserDetailsPage(
                            user: snapshot.data[i],
                          ),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text(snapshot.data[i].name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(snapshot.data[i].username),
                          Text(snapshot.data[i].email),
                          Text(snapshot.data[i].addressstreet),
                          Text(snapshot.data[i].addresssuite),
                          Text(snapshot.data[i].addresscity),
                          Text(snapshot.data[i].addresszipcode),
                          Text(snapshot.data[i].addressgeolat),
                          Text(snapshot.data[i].addressgeolng),
                          Text(snapshot.data[i].phone),
                          Text(snapshot.data[i].website),
                          Text(snapshot.data[i].companyname),
                          Text(snapshot.data[i].companycatchPhrase),
                          Text(snapshot.data[i].companybs),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class UserDetailsPage extends StatelessWidget {
  final User user;

  UserDetailsPage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(' ${user.name}'),
            Text(' ${user.email}'),
            Text(' ${user.username}'),
            Text(' ${user.addressstreet}'),
            Text(' ${user.addresssuite}'),
            Text(' ${user.addresscity}'),
            Text(' ${user.addresszipcode}'),
            Text(' ${user.addressgeolat}'),
            Text(' ${user.addressgeolng}'),
            Text(' ${user.phone}'),
            Text(' ${user.website}'),
            Text(' ${user.companyname}'),
            Text(' ${user.companycatchPhrase}'),
            Text(' ${user.companybs}'),
          ],
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
