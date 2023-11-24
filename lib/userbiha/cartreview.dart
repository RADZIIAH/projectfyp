import 'package:flutter/material.dart';
import 'package:adminpage/userbiha/payment.dart';

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
      home: RestaurantListScreen(),
      routes: {
        '/cart': (context) => ShoppingCart(selectedRestaurant: ''),
      },
    );
  }
}

class RestaurantListScreen extends StatelessWidget {
  final List<Map<String, String>> restaurants = [
    {'name': 'Gerai MPD No.8 - SURA GATE ', 'imagePath': 'assets/images/mpd.png'},
    {'name': 'RR NASI KERABU HOUSE (KAK YAH NASI KERABU) - BATU 5', 'imagePath': 'assets/images/kerabu.png'},
    {'name': 'ANEKA SUP MIEZAN - PAKA ', 'imagePath': 'assets/images/mizan.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurants'),
      ),
      body: ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(restaurants[index]['name']!),
            leading: Container(
              margin: EdgeInsets.all(8.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Image.asset(
                restaurants[index]['imagePath']!,
                width: 250,
                height: 1000,
                fit: BoxFit.cover,
              ),
            ),
            trailing: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShoppingCart(selectedRestaurant: restaurants[index]['name']!),
                  ),
                );
              },
              child: const Text('View Menu'),
            ),
          );
        },
      ),
    );
  }
}

class FoodItem {
  final String name;
  final double price;
  final String imagePath;

  FoodItem({required this.name, required this.price, required this.imagePath});
}

class CartItem {
  final FoodItem foodItem;
  int quantity;

  CartItem({required this.foodItem, this.quantity = 0});
}

class ShoppingCart extends StatefulWidget {
  final String selectedRestaurant;

  ShoppingCart({required this.selectedRestaurant});

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  DateTime orderDateTime = DateTime.now();
  List<CartItem> cartItems = [];
  List<FoodItem> foodItems = [
    FoodItem(name: "Ayam masak kunyit", price: 5.00, imagePath: "assets/images/ayamkunyit.jpg"),
    FoodItem(name: "Daging masak kunyit", price: 5.00, imagePath: "assets/images/dagingkunyit.jpg"),
    FoodItem(name: "Ayam masak merah", price: 5.00, imagePath: "assets/images/ayammerah.jpeg"),
    FoodItem(name: "Daging masak merah", price: 5.00, imagePath: "assets/images/dagingmerah.jpeg"),
    FoodItem(name: "Teh O Ais", price: 0.00, imagePath: "assets/images/tehopeng.jpg"),
    FoodItem(name: "Sirap Ais", price: 0.00, imagePath: "assets/images/sirap.jpg"),
  ];

  double calculateTotalPrice() {
    double total = 0;
    for (var item in cartItems) {
      total += (item.foodItem.price * item.quantity);
    }
    return total;
  }

  void addToCart(FoodItem foodItem) {
    bool itemExistsInCart = false;

    for (var item in cartItems) {
      if (item.foodItem.name == foodItem.name) {
        item.quantity++;
        itemExistsInCart = true;
        break;
      }
    }

    if (!itemExistsInCart) {
      cartItems.add(CartItem(foodItem: foodItem, quantity: 1));
    }

    setState(() {});
  }

  Future<void> sendDataToDatabase() async {
    try {
      // Your http.post logic here
    } catch (e) {
      print("Error sending data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Shopping Cart'),
      ),
      backgroundColor: Colors.blueGrey[50],
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
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
                  subtitle: Text(
                      foodItems[index].price == 0.00
                          ? 'FREE'
                          : 'RM${foodItems[index].price.toStringAsFixed(2)} '),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          removeFromCart(foodItems[index]);
                        },
                      ),
                      Text('ADD MENU'), // You can replace this with the actual quantity from your data
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          addToCart(foodItems[index]);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Divider(),
          Text(
            'Cart Items:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(cartItems[index].foodItem.name),
                  subtitle: Text('RM${cartItems[index].foodItem.price.toStringAsFixed(2)}'),
                  trailing: Text('Quantity: ${cartItems[index].quantity}'),
                );
              },
            ),
          ),
          Text(
            'Total Price: RM${calculateTotalPrice().toStringAsFixed(2)}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
            onPressed: () {
              // Create a list of order details
              List<OrderDetail> orderDetails = [];
              for (var item in cartItems) {
                orderDetails.add(OrderDetail(
                  itemName: item.foodItem.name,
                  quantity: item.quantity,
                  price: item.foodItem.price,
                ));
              }
              // Set the order date and time
              orderDateTime = DateTime.now();

              // Pass order details to PaymentScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentScreen(
                    orderDetails: orderDetails,
                    orderDateTime: orderDateTime,
                    selectedRestaurant: widget.selectedRestaurant,
                  ),
                ),
              );
            },
            child: Text('Checkout'),
          ),

        ],
      ),
    );
  }
}

class FREE {
}

void removeFromCart(FoodItem foodItem) {
}


