import 'package:adminpage/code/admin.dart';
import 'package:adminpage/code/manage.dart';
import 'package:adminpage/code/setting.dart';
import 'package:adminpage/code/test2.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'WELCOME TO ADMIN PAGE',
          style: TextStyle(fontSize: 18),
        ),
        backgroundColor: const Color(0xff607d8b),
      ),
      body: Stack(
        children: [
          _buildBackgroundImage(),
          Column(
            children: [
              // Welcome Banner
              _buildWelcomeBanner(),

              // Delivery Summary Card
              _buildDeliverySummaryCard(),

              // Promotional Banner
              _buildPromotionalBanner(),

              // Expanded Section (Your existing content goes here)
              Expanded(
                child: Center(
                  child: Text('Your existing content goes here'),
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // Drawer Header
            _buildHeader(),

            // Drawer Items
            _buildItem(
              icon: Icons.home,
              title: 'Dashboard',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen1())),
            ),
            _buildItem(
              icon: Icons.person,
              title: 'Profile',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AdminProfilePage())),
            ),
            _buildItem(
              icon: Icons.manage_accounts,
              title: 'Manage',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AdminPage1())),
            ),
            _buildItem(
              icon: Icons.settings_rounded,
              title: 'Setting',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen())),
            ),
          ],
        ),
      ),
    );
  }

  // Widgets

  Widget _buildHeader() {
    return DrawerHeader(
      decoration: const BoxDecoration(
        color: Color(0xff1D1E22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: AssetImage(
              'assets/images/mirul.jpeg', // Replace with your admin's avatar
            ),
            radius: 50,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'ADMIN',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildItem({IconData? icon, required String title, required Function onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () => onTap(),
    );
  }

  Widget _buildWelcomeBanner() {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.blueGrey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome, Admin!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliverySummaryCard() {
    // You can replace this with actual delivery summary data
    int totalOrders = 150;
    int pendingOrders = 20;
    int completedOrders = 130;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildSummaryItem('Total Orders', totalOrders),
            _buildSummaryItem('Pending Orders', pendingOrders),
            _buildSummaryItem('Completed Orders', completedOrders),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String title, int value) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          value.toString(),
          style: TextStyle(
            fontSize: 18,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }

  Widget _buildPromotionalBanner() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.yellow,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.local_offer,
            color: Colors.orange,
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Special Offer!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Mari-mari mendapatkan set menu rahmah dengan harga RM5',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backfood.jpg'), // Replace with your image asset path
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

// Other classes (DashboardScreen1, AdminProfilePage, AdminPage1, SettingsScreen) are assumed to be defined elsewhere in your code.
