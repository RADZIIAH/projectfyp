import 'package:flutter/material.dart';

class Ingredient {
  final String name;
  int stock;
  String unitType; // Add this field to specify the unit type

  Ingredient({required this.name, required this.stock, required this.unitType});
}

class WetIngredientsPage extends StatefulWidget {
  @override
  _WetIngredientsPageState createState() => _WetIngredientsPageState();
}

class _WetIngredientsPageState extends State<WetIngredientsPage> {
  List<Ingredient> ingredients = [
    Ingredient(name: 'Water', stock: 50, unitType: 'liters'),
    Ingredient(name: 'Milk', stock: 30, unitType: 'liters'),
    Ingredient(name: 'Chicken Broth', stock: 15, unitType: 'cartons'),
    Ingredient(name: 'Meat', stock: 15, unitType: 'kilograms'),
    Ingredient(name: 'Chicken ', stock: 17, unitType: 'pieces'),
    Ingredient(name: 'Tomato', stock: 25, unitType: 'pieces'),
    Ingredient(name: 'Chicken Broth', stock: 15, unitType: 'cartons'),
    Ingredient(name: 'Carrot', stock: 15, unitType: 'pieces'),
    Ingredient(name: 'Baby Corn', stock: 45, unitType: 'cans'),
    Ingredient(name: 'Long Bean ', stock: 23, unitType: 'pieces'),
    // Add more ingredients as needed
  ];

  TextEditingController _quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wet Ingredients Stock'),
        backgroundColor: const Color(0xff607d8b),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bgmain.jpg'), // Replace with your image asset path
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: ingredients.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(ingredients[index].name),
              subtitle: Text('Stock: ${ingredients[index].stock} ${ingredients[index].unitType}'),
              trailing: ElevatedButton(
                onPressed: () {
                  // Show warning if low stock
                  _showStockWarning(index);
                },
                style: ElevatedButton.styleFrom(
                  primary: _getButtonColor(ingredients[index].stock),
                ),
                child: Text('Status'),
              ),
              contentPadding: EdgeInsets.all(10.0),
              onTap: () {
                // Handle tile tap
                _handleTileTap(index);
              },
            );
          },
        ),
      ),
    );
  }

  void _handleTileTap(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Manage Stock'),
          content: Column(
            children: [
              Text('Current Stock: ${ingredients[index].stock} ${ingredients[index].unitType}'),
              SizedBox(height: 10),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Add stock
                      _addStock(index);
                    },
                    child: Text('Add'),
                  ),
                  SizedBox(width: 5),
                  ElevatedButton(
                    onPressed: () {
                      // Remove stock
                      _removeStock(index);
                    },
                    child: Text('Remove'),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: TextField(
                      controller: _quantityController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Quantity',
                        hintText: 'Enter quantity',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _addStock(int index) {
    setState(() {
      int quantity = int.tryParse(_quantityController.text) ?? 5;
      ingredients[index].stock += quantity;
      _quantityController.clear();
      Navigator.of(context).pop(); // Close the dialog
    });
  }

  void _removeStock(int index) {
    setState(() {
      int quantity = int.tryParse(_quantityController.text) ?? 5;
      if (ingredients[index].stock >= quantity) {
        ingredients[index].stock -= quantity;
      } else {
        ingredients[index].stock = 0;
      }
      _quantityController.clear();
      Navigator.of(context).pop(); // Close the dialog
    });
  }

  Color _getButtonColor(int stock) {
    if (stock <= 10) {
      return Colors.red;
    } else if (stock <= 30) {
      return Colors.yellow;
    } else {
      return Colors.green;
    }
  }

  void _showStockWarning(int index) {
    if (ingredients[index].stock <= 10) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Low Stock Warning'),
            content: Text('${ingredients[index].name} stock is running low!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: WetIngredientsPage(),
  ));
}
