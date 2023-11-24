import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardScreen1(),
    );
  }
}

class DashboardScreen1 extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen1> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<Widget> _tabs;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabs = [
      _buildDummyOrderListTab('Received Order'), // Received Order Tab
      _buildDummyOrderListTab('Canceled Order'), // Canceled Order Tab
      _buildDummyOrderListTab('Total Order'), // Total Order Tab
    ];
  }

  // Replace this with your own data fetching logic
  Widget _buildDummyOrderListTab(String title) {
    return _buildCard(title, _buildDummyOrderListView(), 2, 300);
  }

  // Replace this with your own data fetching logic
  Widget _buildDummyOrderListView() {
    return ListView.builder(
      itemCount: 5, // Replace with the number of dummy orders you want to display
      itemBuilder: (context, index) {
        return _buildDummyOrderHistoryItem('Order #$index', 'Item 1, Item 2', '100.0');
      },
    );
  }

  // Replace this with your own data fetching logic
  Widget _buildDummyOrderHistoryItem(String orderNumber, String items, String total) {
    return ListTile(
      title: Text('Order Number: $orderNumber'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Items: $items'),
          Text('Total: $total'),
        ],
      ),
    );
  }

  Widget _buildCard(String title, Widget content, int crossAxisCount, double height) {
    return Card(
      elevation: 3,
      child: Column(
        children: [
          ListTile(
            title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: height,
            child: content,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Dashboard'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Received Order'),
            Tab(text: 'Canceled Order'),
            Tab(text: 'Total Order'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabs,
      ),
    );
  }
}
