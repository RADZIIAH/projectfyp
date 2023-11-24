// main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: RestaurantMenu(),
    );
  }
}

class FoodItem {
  late final String name;
  double price;
  final String imagePath;

  FoodItem({required this.name, required this.price, required this.imagePath});
}

class RestaurantMenu extends StatefulWidget {
  @override
  _RestaurantMenuState createState() => _RestaurantMenuState();
}

class _RestaurantMenuState extends State<RestaurantMenu> {
  final List<FoodItem> foodItems = [
    FoodItem(name: "Ayam masak kunyit", price: 5.00, imagePath: "assets/images/ayamkunyit.jpg"),
    FoodItem(name: "Daging masak kunyit", price: 5.00, imagePath: "assets/images/dagingkunyit.jpg"),
    FoodItem(name: "Ayam masak merah", price: 5.00, imagePath: "assets/images/ayammerah.jpeg"),
    FoodItem(name: "Daging masak merah", price: 5.00, imagePath: "assets/images/dagingmerah.jpeg"),
    FoodItem(name: "Teh O Ais", price: 0.00, imagePath: "assets/images/tehopeng.jpg"),
    FoodItem(name: "Sirap Ais", price: 0.00, imagePath: "assets/images/sirap.jpg"),
  ];

  void updateFoodItem(FoodItem updatedFoodItem) {
    int index = foodItems.indexWhere((item) => item.name == updatedFoodItem.name);
    if (index != -1) {
      setState(() {
        foodItems[index] = updatedFoodItem;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Restaurant Menu'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditFoodItemScreen(foodItems: foodItems, onUpdate: updateFoodItem),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.blueGrey[50],
      body: ListView.builder(
        itemCount: foodItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Image.asset(
                    foodItems[index].imagePath,
                    width: 100,
                    height: 100,
                  ),
                ),
                Text(foodItems[index].name),
              ],
            ),
          );
        },
      ),
    );
  }
}

class EditFoodItemScreen extends StatefulWidget {
  final List<FoodItem> foodItems;
  final Function(FoodItem) onUpdate; // Callback function

  EditFoodItemScreen({required this.foodItems, required this.onUpdate});

  @override
  _EditFoodItemScreenState createState() => _EditFoodItemScreenState();
}

class _EditFoodItemScreenState extends State<EditFoodItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Edit Food Items'),
      ),
      body: ListView.builder(
        itemCount: widget.foodItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Image.asset(
                    widget.foodItems[index].imagePath,
                    width: 100,
                    height: 100,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.foodItems[index].name),
                    SizedBox(height: 8),
                    Text('Price: \RM${widget.foodItems[index].price.toStringAsFixed(2)}'),
                  ],
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditFoodItemDetailsScreen(foodItem: widget.foodItems[index], onUpdate: widget.onUpdate),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class EditFoodItemDetailsScreen extends StatefulWidget {
  final FoodItem foodItem;
  final Function(FoodItem) onUpdate; // Callback function

  EditFoodItemDetailsScreen({required this.foodItem, required this.onUpdate});

  @override
  _EditFoodItemDetailsScreenState createState() => _EditFoodItemDetailsScreenState();
}

class _EditFoodItemDetailsScreenState extends State<EditFoodItemDetailsScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.foodItem.name;
    priceController.text = widget.foodItem.price.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Edit Food Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16),
            Text('Current Price: \RM${widget.foodItem.price.toStringAsFixed(2)}'),
            SizedBox(height: 16),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: 'New Price'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                double newPrice = double.tryParse(priceController.text) ?? widget.foodItem.price;
                FoodItem updatedFoodItem = FoodItem(
                  name: nameController.text,
                  price: newPrice,
                  imagePath: widget.foodItem.imagePath,
                );
                widget.onUpdate(updatedFoodItem); // Callback to update the food item
                Navigator.pop(context); // Go back to the previous screen
              },
              child: Text('Save Changes'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Confirmation'),
                      content: Text('Are you sure to delete this menu?'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('No'),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                        ),
                        TextButton(
                          child: Text('Yes'),
                          onPressed: () {
                            widget.onUpdate(FoodItem(name: "", price: 0.0, imagePath: "")); // Pass an empty FoodItem to indicate deletion
                            Navigator.pop(context); // Close the dialog
                            Navigator.pop(context); // Go back to the previous screen
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(primary: Colors.red),
              child: Text('Delete Menu'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back to the previous screen
              },
              child: Text('Create New Menu'),
            ),
          ],
        ),
      ),
    );
  }
}
