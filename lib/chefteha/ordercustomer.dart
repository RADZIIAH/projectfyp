import 'package:flutter/material.dart';

void main() {
  runApp(CustomerScreen());
}

class CustomerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomerViewOrderPage(),
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
      ),
    );
  }
}

class CustomerViewOrderPage extends StatefulWidget {
  @override
  _CustomerViewOrderPageState createState() => _CustomerViewOrderPageState();
}

class _CustomerViewOrderPageState extends State<CustomerViewOrderPage> {
  List<Order> orders = [
    Order(id: 1, customerId: 101, customerName: 'Adawiyah', items: ['Ayam Masak Kunyit', 'Sirap Ais'], estimatedCookingTime: 30, isSelfPickup: false),
    Order(id: 2, customerId: 102, customerName: 'Farisya', items: ['Daging Masak Kunyit', 'Teh O Ais'], estimatedCookingTime: 25, isSelfPickup: false),
    Order(id: 3, customerId: 103, customerName: 'Danish', items: ['Ayam Masak Merah', 'Sirap Ais'], estimatedCookingTime: 20, isSelfPickup: false),
    Order(id: 4, customerId: 104, customerName: 'Anuar', items: ['Daging Masak Merah', 'Sirap Ais'], estimatedCookingTime: 40, isSelfPickup: false),
    // Add more sample orders here
  ];

  void markOrderAsInProgress(int orderId) {
    setState(() {
      final orderIndex = orders.indexWhere((order) => order.id == orderId);
      if (orderIndex != -1) {
        orders[orderIndex].isSelfPickup = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Process'),
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
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return ListTile(
              title: Text('Order #${order.id} by ${order.customerName} (ID: ${order.customerId})'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Items: ${order.items.join(', ')}'),
                  Text('Estimated Cooking Time: ${order.estimatedCookingTime} minutes'),
                ],
              ),
              trailing: order.isSelfPickup
                  ? Text('Self Pickup', style: TextStyle(color: Colors.green))
                  : ElevatedButton(
                onPressed: () {
                  markOrderAsInProgress(order.id);
                },
                child: Text('Food In Progress'),
              ),
              onTap: () {
                // Navigate to a detailed order view if needed
              },
            );
          },
        ),
      ),
    );
  }
}

class Order {
  final int id;
  final int customerId; // Add customer ID
  final String customerName;
  final List<String> items;
  final int estimatedCookingTime;
  bool isSelfPickup;

  Order({
    required this.id,
    required this.customerId, // Add customer ID
    required this.customerName,
    required this.items,
    required this.estimatedCookingTime,
    this.isSelfPickup = false,
  });
}
