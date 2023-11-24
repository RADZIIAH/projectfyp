import 'package:flutter/material.dart';

// This is a hypothetical service to fetch orders from an API.
class OrderService {
  // Replace this method with your actual data-fetching logic.
  Future<List<Map<String, dynamic>>> getOrders() async {
    // Fetch orders from an API
    // In a real-world scenario, you would make an HTTP request here.
    // For simplicity, returning a static list here.
    return [
      {'orderNumber': '1', 'total': 50.0},
      {'orderNumber': '2', 'total': 75.0},
      // Add more orders as needed
    ];
  }
}

class OrderManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Management'),
      ),
      body: OrderList(orderService: OrderService()),
    );
  }
}

class OrderList extends StatefulWidget {
  final OrderService orderService;

  OrderList({required this.orderService});

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  late Future<List<Map<String, dynamic>>> orders;

  @override
  void initState() {
    super.initState();
    orders = widget.orderService.getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: orders,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        var orders = snapshot.data ?? [];

        return ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            var order = orders[index];
            return ListTile(
              title: Text('Order Number: ${order['orderNumber']}'),
              subtitle: Text('Total: RM${order['total'].toStringAsFixed(2)}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Implement update logic (navigate to update page or show a dialog)
                      // For simplicity, let's print a message for now.
                      print('Update order ${order['orderNumber']}');
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Implement delete logic (show a confirmation dialog and delete if confirmed)
                      // For simplicity, let's print a message for now.
                      print('Delete order ${order['orderNumber']}');
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: OrderManagementPage(),
  ));
}
