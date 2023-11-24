import 'package:adminpage/code_tak_guna/registerform.dart';
import 'package:adminpage/userbiha/loginbiha.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() /*async*/ {
  /*WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();*/
  runApp(DeliveryApp());
}

class DeliveryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Menu Rahmah App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        //'/restaurant': (context) => LoginPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Rahmah App'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.bottomCenter, // Align content to the bottom center
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Image(
                image: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0lsgy7n0qbo4uiYorXw379C0lz-RG-4P7zQ&usqp=CAU',
                ),
              ),
            ),
            SizedBox(height: 16), // Add some spacing between the image and text
            Text(
              'Welcome to Menu Rahmah App',
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('LOGIN | SIGNUP'),
            ),
          ],
        ),
      ),
    );
  }
}
