import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AdminPanel(),
    );
  }
}

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  String currentAdmin = "Admin 1"; // Initial admin account

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Current Admin: $currentAdmin',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Open a dialog to select a new admin account
                _selectAdminAccount(context);
              },
              child: Text('Switch Admin'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectAdminAccount(BuildContext context) async {
    // Dummy list of admin accounts
    List<String> adminAccounts = ["Admin 1", "Admin 2", "Admin 3"];

    String? newAdmin = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Admin Account'),
          content: Column(
            children: adminAccounts
                .map((admin) => ListTile(
              title: Text(admin),
              onTap: () {
                Navigator.pop(context, admin);
              },
            ))
                .toList(),
          ),
        );
      },
    );

    // Update the selected admin account
    if (newAdmin != null) {
      setState(() {
        currentAdmin = newAdmin;
      });
    }
  }
}
