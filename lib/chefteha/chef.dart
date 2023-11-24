import 'package:flutter/material.dart';
import 'package:adminpage/chefteha/ordercustomer.dart' as customer;
import 'package:adminpage/chefteha/orderchef.dart' as chef;
import 'package:adminpage/chefteha/stock.dart';
import 'package:adminpage/userbiha/loginbiha.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChefHomeScreen(),
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
      ),
    );
  }
}

class ChefHomeScreen extends StatelessWidget {
  void handleStatusUpdate(int orderId, String newStatus) {
    print('Order ID: $orderId, New Status: $newStatus');
    // Implement the desired behavior here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chef Dashboard'),
        backgroundColor: const Color(0xff607d8b),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bgmain.jpg'), // Replace with your image asset path
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/images/bgchef.jpg'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => StockCheckPage()));
              },
              child: Text('Manage the Stock'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => chef.ChefOrderViewerPage(
                      onStatusUpdate: handleStatusUpdate,
                    ),
                  ),
                );
              },
              child: Text('Chef Food Progress'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => customer.CustomerViewOrderPage()));
              },
              child: Text('Customer Food Process'),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text('Log Out'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
