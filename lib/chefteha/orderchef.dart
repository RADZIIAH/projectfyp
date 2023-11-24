import 'package:flutter/material.dart';

void main() {
  runApp(OrderScreen());
}

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChefOrderViewerPage(
        onStatusUpdate: (orderId, newStatus) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CustomerViewOrderPage(orderId: orderId, newStatus: newStatus),
            ),
          );
        },
      ),
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
      ),
    );
  }
}

class Order {
  final int id;
  final int customerId;
  final String customerName;
  final List<String> items;
  final int estimatedCookingTime;
  String status;

  Order({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.items,
    required this.estimatedCookingTime,
    this.status = 'Pending',
  });
}

class ChefOrderViewerPage extends StatefulWidget {
  final Function(int, String) onStatusUpdate;

  ChefOrderViewerPage({required this.onStatusUpdate});

  @override
  _ChefOrderViewerPageState createState() => _ChefOrderViewerPageState();
}

class _ChefOrderViewerPageState extends State<ChefOrderViewerPage> {
  List<Order> orders = [
    Order(id: 1, customerId: 101, customerName: 'Adawiyah', items: ['Nasi Putih + Ayam Kunyit', 'Sirap Ais'], estimatedCookingTime: 30),
    Order(id: 2, customerId: 102, customerName: 'Farisya', items: ['Nasi Putih + Ayam Paprik', 'Sirap Ais'], estimatedCookingTime: 25),
    Order(id: 3, customerId: 103, customerName: 'Danish', items: ['Nasi Putih + Ayam Paprik', 'Sirap Ais'], estimatedCookingTime: 20),
    Order(id: 4, customerId: 104, customerName: 'Anuar', items: ['Nasi Putih + Ayam Goreng + Sayur', 'Sirap Ais'], estimatedCookingTime: 40),
    // Add more sample orders here
  ];

  void updateOrderStatus(int orderId, String newStatus) {
    setState(() {
      final orderIndex = orders.indexWhere((order) => order.id == orderId);
      if (orderIndex != -1) {
        orders[orderIndex].status = newStatus;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Process'),
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
                  Text('Status: ${order.status}'),
                ],
              ),
              trailing: DropdownButton<String>(
                value: order.status,
                onChanged: (newStatus) {
                  widget.onStatusUpdate(order.id, newStatus!);
                  updateOrderStatus(order.id, newStatus);
                },
                items: ['Pending', 'Preparing', 'Ready'].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
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

class CustomerViewOrderPage extends StatelessWidget {
  final int orderId;
  final String newStatus;

  CustomerViewOrderPage({required this.orderId, required this.newStatus});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Order Details'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Order ID: $orderId'),
              Text('New Status: $newStatus'),
              // Add more details or actions related to customer order
            ],
          ),
        ),
      ),
    );
  }
}
