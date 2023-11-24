import 'package:adminpage/userbiha/loginbiha.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class User {
  final int id;
  final String username;
  final String password;

  User({required this.id, required this.username, required this.password});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      password: map['password'],
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LOGIN | SIGNUP',
      home: RegistrationForm(),
      routes: {
        '/registration': (context) => RegistrationForm(),
        //'/food_menu': (context) => FoodCart(),
      },
    );
  }
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  List<User> registeredUsers = []; // List to store registered users

  bool _isRegistered = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        backgroundColor: const Color(0xff607d8b),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isRegistered ? _buildRegistrationSuccess() : _buildRegistrationForm(),
      ),
    );
  }

  Widget _buildRegistrationForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _usernameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter username';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: 'Username',
              labelText: 'Username',
            ),
          ),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: 'Password',
              labelText: 'Password',
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.black87,
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                String username = _usernameController.text;
                String password = _passwordController.text;
                User newUser = User(id: registeredUsers.length + 1, username: username, password: password);
                registeredUsers.add(newUser);

                // Show a dialog message after successful registration
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Registration Successful'),
                      content: Text('You have successfully registered.'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            // Navigate to the list of registered users
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginPage()),
                            );
                            //Navigator.of(context).pop(registeredUsers);
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: Text('Register'),
          ),
          SizedBox(height: 20),
          TextButton(
            onPressed: () {
              // Navigate back to the previous page when the "Back to Login" button is clicked
              Navigator.of(context).pop();
            },
            child: Text('Back to Login'),
          ),
        ],
      ),
    );
  }

  Widget _buildRegistrationSuccess() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Registration Successful!'),
          ElevatedButton(
            onPressed: () {
              // Inside the onPressed event when registration is successful
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );

              // Navigate to another screen or perform any other action
            },
            child: Text('Continue'),
          ),
        ],
      ),
    );
  }
}

/*class RegisteredUsersList extends StatelessWidget {
  final List<User> registeredUsers;

  RegisteredUsersList(this.registeredUsers);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registered Users'),
      ),
      body: ListView.builder(
        itemCount: registeredUsers.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Username: ${registeredUsers[index].username}'),
            subtitle: Text('Password: ${registeredUsers[index].password}'),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Navigate back to the previous screen
          },
          child: Text('Back'),
        ),
      ),
    );
  }
}*/

