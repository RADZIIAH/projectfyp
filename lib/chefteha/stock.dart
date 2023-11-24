import 'package:flutter/material.dart';
import 'dry_ingredients.dart';
import 'wet_ingredients.dart';

void main() => runApp(StockCheck());

class StockCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chef Stock',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: StockCheckPage(),
    );
  }
}

class StockCheckPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chef Stock'),
        backgroundColor: const Color(0xff607d8b),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bgmain.jpg'), // Replace with your image asset path
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WetIngredientsPage()),
                  );
                },
                child: Text('Check Wet Ingredients Stock'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DryIngredientsPage()),
                  );
                },
                child: Text('Check Dry Ingredients Stock'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
