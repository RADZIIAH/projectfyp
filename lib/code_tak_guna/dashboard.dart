import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

void main() {
  runApp(DashboardApp());
}

class DashboardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
        ),

        body: Padding(
        padding: const EdgeInsets.all(8.0),
    child: StaggeredGridView.count(
    crossAxisCount: 4,
    mainAxisSpacing: 8.0,
    crossAxisSpacing: 8.0,
    children: <Widget>[
    _buildCard('Sales Overview', _buildChart(), 4, 300),
    _buildCard('User Statistics', _buildChart(), 2, 150),
    _buildCard('Orders Overview', _buildChart(), 2, 150),
    ],
      staggeredTiles: [
        StaggeredTile.fit(4),
        StaggeredTile.fit(2),
        StaggeredTile.fit(2),
      ],
    ),
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

  Widget _buildChart() {
    // Replace this with your actual chart data
    var data = [
    charts.Series(
        id: 'Sales',
        data: [
          _SalesData(0, 100),
          _SalesData(1, 150),
          _SalesData(2, 75),
          _SalesData(3, 200),
        ],
      domainFn: (_SalesData sales, _) => sales.year,
      measureFn: (_SalesData sales, _) => sales.sales,
    ),
    ];

    return charts.LineChart(data, animate: true);
  }
}

class _SalesData {
  final int year;
  final int sales;

  _SalesData(this.year, this.sales);
}