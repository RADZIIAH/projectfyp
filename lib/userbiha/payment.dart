// payment.dart
import 'package:flutter/material.dart';
import 'package:adminpage/userbiha/receipt.dart';

class OrderDetail {
  final String itemName;
  final int quantity;
  final double price;

  OrderDetail({
    required this.itemName,
    required this.quantity,
    required this.price,
  });
}

class PaymentMethod {
  final String name; // Add other properties as needed

  PaymentMethod({required this.name});
}

class PaymentScreen extends StatefulWidget {
  final List<OrderDetail> orderDetails;
  final DateTime orderDateTime;
  final String selectedRestaurant; // Add the selected restaurant name

  PaymentScreen({
    required this.orderDetails,
    required this.orderDateTime,
    required this.selectedRestaurant,
  });

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool showPaymentReview = true; // Change this based on your condition
  PaymentMethod? _selectedPaymentMethod;

  double calculateTotalPrice(List<OrderDetail> orderDetails) {
    double total = 0;
    for (var item in orderDetails) {
      total += (item.price * item.quantity);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Payment',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (showPaymentReview)
              Column(
                children: [
                  // Payment review section
                  Text(
                    'Payment Review',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  // Display order details and total price here
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.orderDetails.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(widget.orderDetails[index].itemName),
                        subtitle: Text(
                          'Quantity: ${widget.orderDetails[index].quantity}  -  '
                              'RM${(widget.orderDetails[index].quantity * widget.orderDetails[index].price).toStringAsFixed(2)}',
                        ),
                      );
                    },
                  ),
                  Text(
                    'Total Price: RM${calculateTotalPrice(widget.orderDetails).toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      // Update state to show payment methods
                      setState(() {
                        showPaymentReview = false;
                      });
                    },
                    child: Text('Continue to Payment'),
                  ),
                ],
              )
            else
              PaymentMethodSelection(
                orderDetails: widget.orderDetails,
                orderDateTime: widget.orderDateTime,
                selectedRestaurant: widget.selectedRestaurant, // Pass the selected restaurant name
              ),
          ],
        ),
      ),
    );
  }
}

class PaymentMethodSelection extends StatelessWidget {
  final List<OrderDetail> orderDetails;
  final DateTime orderDateTime;
  final String selectedRestaurant; // Add the selected restaurant name

  PaymentMethodSelection({
    required this.orderDetails,
    required this.orderDateTime,
    required this.selectedRestaurant,
  });

  @override
  Widget build(BuildContext context) {
    PaymentMethod? _selectedPaymentMethod;

    return Column(
      children: [
        // Payment method selection section
        Text(
          'Select Payment Method:',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Column(
          children: paymentMethods
              .map((paymentMethod) => ListTile(
            title: Text(paymentMethod.name),
            leading: Radio<PaymentMethod>(
              value: paymentMethod,
              groupValue: _selectedPaymentMethod,
              onChanged: (PaymentMethod? value) {
                _selectedPaymentMethod = value;
              },
            ),
          ))
              .toList(),
        ),
        SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: () {
            if (_selectedPaymentMethod != null) {
              // Process payment based on the selected payment method.
              String selectedMethod = _selectedPaymentMethod!.name;
              // Implement your payment processing logic here.
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Payment Successful'),
                    content: Text('You have paid with $selectedMethod.'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          // Navigate to the ReceiptPage
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReceiptPage(
                                orderDetails: orderDetails,
                                orderDateTime: orderDateTime,
                                restaurantName: selectedRestaurant,
                                selectedPaymentMethod: selectedMethod,
                              ),
                            ),
                          );
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Error'),
                    content: Text('Please select a payment method.'),
                    actions: <Widget>[
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
          },
          child: Text('Pay Now'),
        ),
        ElevatedButton(
          onPressed: () {
            // Navigate back to the payment review section
            Navigator.pop(context);
          },
          child: Text('Back to Payment Review'),
        ),
      ],
    );
  }
}

List<PaymentMethod> paymentMethods = [
  PaymentMethod(name: 'Credit Card'),
  PaymentMethod(name: 'CASH'),
  PaymentMethod(name: 'QR CODE'),
  // Add more payment methods as needed
];
