import 'package:flutter/material.dart';
import 'package:adminpage/userbiha/cartreview.dart';
import 'package:adminpage/userbiha/payment.dart';
import 'package:intl/intl.dart';

class ReceiptPage extends StatelessWidget {
  final List<OrderDetail> orderDetails;
  final DateTime orderDateTime;
  final String restaurantName;
  final String selectedPaymentMethod;

  ReceiptPage({
    required this.orderDetails,
    required this.orderDateTime,
    required this.restaurantName,
    required this.selectedPaymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receipt'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Date: ${DateFormat('yyyy-MM-dd').format(orderDateTime)}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Restaurant Name: $restaurantName',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Payment Method: $selectedPaymentMethod',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Order Details:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              itemCount: orderDetails.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(orderDetails[index].itemName),
                  subtitle: Text(
                    'Quantity: ${orderDetails[index].quantity}  -  '
                        'RM${(orderDetails[index].quantity * orderDetails[index].price).toStringAsFixed(2)}',
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            Text(
              'Total Price: RM${calculateTotalPrice(orderDetails).toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Thank you for your order! 😊',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  double calculateTotalPrice(List<OrderDetail> orderDetails) {
    double total = 0;
    for (var item in orderDetails) {
      total += (item.price * item.quantity);
    }
    return total;
  }
}
