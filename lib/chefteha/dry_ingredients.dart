import 'package:flutter/material.dart';

class Ingredient {
  final String name;
  int stock;
  String unitType; // Add this field to specify the unit type

  Ingredient({required this.name, required this.stock, required this.unitType});
}

class DryIngredientsPage extends StatefulWidget {
  @override
  _DryIngredientsPageState createState() => _DryIngredientsPageState();
}

class _DryIngredientsPageState extends State<DryIngredientsPage> {
  List<Ingredient> ingredients = [
    Ingredient(name: 'Flour', stock: 100, unitType: 'kilograms'),
    Ingredient(name: 'Sugar', stock: 50, unitType: 'kilograms'),
    Ingredient(name: 'Salt', stock: 20, unitType: 'grams'),
    Ingredient(name: 'Tumeric Powder', stock: 20, unitType: 'grams'),
    Ingredient(name: 'Cooking Oil', stock: 20, unitType: 'liters'),
    Ingredient(name: 'Onion', stock: 20, unitType: 'pieces'),
    Ingredient(name: 'Garlic', stock: 20, unitType: 'cloves'),
    Ingredient(name: 'Oyster Sauce', stock: 20, unitType: 'bottles'),
    Ingredient(name: 'Tamarind', stock: 20, unitType: 'grams'),
    Ingredient(name: 'Chili Sauce', stock: 20, unitType: 'bottles'),
    Ingredient(name: 'Tomato Sauce', stock: 20, unitType: 'bottles'),
    Ingredient(name: 'Lemongrass', stock: 20, unitType: 'stalks'),
    Ingredient(name: 'Red Chilies', stock: 20, unitType: 'pieces'),
    Ingredient(name: 'Green Chilies', stock: 20, unitType: 'pieces'),
    Ingredient(name: 'Palm Sugar', stock: 20, unitType: 'grams'),
    // Add more ingredients as needed
  ];

  TextEditingController _quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dry Ingredients Stock'),
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
    home: DryIngredientsPage(),
  ));
}
