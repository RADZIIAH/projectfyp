import 'package:adminpage/code/Menu.dart';
import 'package:adminpage/code/Staff.dart';
import 'package:adminpage/code/main.dart';
import 'package:adminpage/code_tak_guna/menu_viewer.dart';
import 'package:adminpage/code/order_management.dart';
import 'package:adminpage/db/data.dart';
import 'package:flutter/material.dart';

class DeliveryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AdminPage1(),
      routes: {
        '/Dashboard': (context) => MyHomePage(),
      },
    );
  }
}

class AdminPage1 extends StatelessWidget {
  List<User>? get registeredUsers => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
        backgroundColor: const Color(0xff607d8b),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage()),
            );
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/foodteha.jpg'), // Replace with your image asset path
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Manage Order',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderManagementPage()),
                );
                // Navigate to a page to manage orders
                // You can implement the navigation logic here
              },
              child: Text('View Orders'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Manage Users',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DataViewer()),
                );
              },
              child: Text('View Data Users'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Manage Menu',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RestaurantMenu()),
                );
              },
              child: Text('View Menu'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Manage Staff',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StaffViewer()),
                );
                // Navigate to a page to manage orders
                // You can implement the navigation logic here
              },
              child: Text('View Staff'),
            ),
            // Add a button below
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                  );
                },

                child: Text('Back'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
