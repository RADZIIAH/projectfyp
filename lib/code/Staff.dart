import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StaffViewer(),
    );
  }
}

class Staff {
  final int id;
  late final String name;
  final String position;
  final String jobScope;

  Staff({required this.id, required this.name, required this.position, required this.jobScope});
}

class StaffViewer extends StatefulWidget {
  final List<Staff> registeredStaff = [
    Staff(id: 1, name: 'AMIRUL', position: 'ADMINISTRATOR', jobScope: 'view and manage user in an application'),
    Staff(id: 2, name: 'FATIHAH', position: 'CHEF', jobScope: 'cook for the customer and report to admin'),
    Staff(id: 3, name: 'DANISH', position: 'ADMIN ASSISTANT', jobScope: 'help the main admin when the admin needed'),
    Staff(id: 4, name: 'NABIHA', position: 'CHEF2', jobScope: 'cook for the customer and report to admin'),
    // Add more staff members as needed...
  ];

  @override
  _StaffViewerState createState() => _StaffViewerState();
}

class _StaffViewerState extends State<StaffViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff Viewer'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: widget.registeredStaff.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Name: ${widget.registeredStaff[index].name}'),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Handle edit staff action
                        _editStaff(index);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Handle remove staff action
                        _removeStaff(index);
                      },
                    ),
                  ],
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ID: ${widget.registeredStaff[index].id}'),
                Text('Position: ${widget.registeredStaff[index].position}'),
                Text('Job Scope: ${widget.registeredStaff[index].jobScope}'),
              ],
            ),
          );
        },
      ),
    );
  }

  void _editStaff(int index) {
    TextEditingController newNameController = TextEditingController();
    newNameController.text = widget.registeredStaff[index].name;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Staff Name'),
          content: TextField(
            controller: newNameController,
            decoration: InputDecoration(labelText: 'New Name'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                // Save the new name and close the dialog
                setState(() {
                  widget.registeredStaff[index].name = newNameController.text;
                });
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void _removeStaff(int index) {
    // Implement your logic to remove the staff member
    setState(() {
      widget.registeredStaff.removeAt(index);
    });
  }
}
