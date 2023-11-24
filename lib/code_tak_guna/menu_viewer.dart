// menu_viewer.dart
import 'package:adminpage/code_tak_guna/Menumanagement.dart';
import 'package:flutter/material.dart';

class MenuViewer extends StatelessWidget {
  final List<MenuItem> menuItems;

  MenuViewer({required this.menuItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Menu'),
      ),
      body: ListView.builder(
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(menuItems[index].name),
              subtitle: Text('\$${menuItems[index].price.toStringAsFixed(2)}'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MenuManagementPage()),
          );
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}

class MenuItem {
  final String name;
  final double price;

  MenuItem({required this.name, required this.price});
}
