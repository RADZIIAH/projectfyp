import 'package:adminpage/code/manage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DataViewer(),
    );
  }
}

class User {
  final int id;
  final String username;
  final String password;

  User({required this.id, required this.username, required this.password});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      password: map['password'],
    );
  }
}

class DataViewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<User> registeredUsers = [
      User(id: 1, username: 'Syahieda13', password: '13@syahieda'),
      User(id: 2, username: 'nabih44', password: '44@nabiha'),
      User(id: 3, username: 'fatihahzmar', password: '@zmar0210'),
      User(id: 4, username: 'haziiqque', password: '@jiq1112'),
      //User(id: 5, username: 'daniel7', password: '77danie*'),
      //User(id: 6, username: 'adlidani', password: 'adlidan**'),
      // Add more users as needed...
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Data Viewer'),
        backgroundColor: const Color(0xff607d8b),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegisteredUsersList(registeredUsers)),
            );
          },
        ),
      ),
    );
  }
  void viewAllData(BuildContext context, List<User> registeredUsers) {
    if (registeredUsers.isEmpty) {
      showMessage(context, "Error", "No data found in the database");
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RegisteredUsersList(registeredUsers)),
      );
    }
  }

  void showMessage(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class RegisteredUsersList extends StatelessWidget {
  final List<User> registeredUsers;

  RegisteredUsersList(this.registeredUsers);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registered Users'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Navigate back to the previous screen
          },
        ),
      ),
      body: ListView.builder(
        itemCount: registeredUsers.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Username: ${registeredUsers[index].username}'),
            subtitle: Text('Password: ${registeredUsers[index].password}'),
          );
        },
      ),
    );
  }
}

