import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DataTable Sorting',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CarTablePage(),
    );
  }
}

class Car {
  Car(this.make, this.model, this.price);

  final String make;
  final int model;
  final int price;
}

class CarTablePage extends StatefulWidget {
  const CarTablePage({super.key});

  @override
  State<CarTablePage> createState() => _CarTablePageState();
}

class _CarTablePageState extends State<CarTablePage> {
  int? sortColumnIndex;
  bool sortAscending = true;

  final List<Car> cars = [
    Car('Honda', 2021, 35000),
    Car('Toyota', 2011, 6000),
    Car('BMW', 2010, 9000),
  ];

  void sortBy(
    int columnIndex,
    bool ascending,
    int Function(Car a, Car b) compare,
  ) {
    setState(() {
      cars.sort((a, b) => ascending ? compare(a, b) : compare(b, a));

      sortColumnIndex = columnIndex;
      sortAscending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DataTable Sorting'), centerTitle: true),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          border: TableBorder.all(color: Colors.black),
          headingRowColor: WidgetStateProperty.all<Color>(Colors.grey),
          sortColumnIndex: sortColumnIndex,
          sortAscending: sortAscending,
          columns: [
            DataColumn(
              label: const Text('Car Make'),
              onSort: (columnIndex, ascending) {
                sortBy(
                  columnIndex,
                  ascending,
                  (a, b) => a.make.compareTo(b.make),
                );
              },
            ),
            DataColumn(
              label: const Text('Model'),
              onSort: (columnIndex, ascending) {
                sortBy(
                  columnIndex,
                  ascending,
                  (a, b) => a.model.compareTo(b.model),
                );
              },
            ),
            DataColumn(
              label: const Text('Price'),
              onSort: (columnIndex, ascending) {
                sortBy(
                  columnIndex,
                  ascending,
                  (a, b) => a.price.compareTo(b.price),
                );
              },
            ),
          ],
          rows: cars.map((car) {
            return DataRow(
              cells: [
                DataCell(Text(car.make)),
                DataCell(Text(car.model.toString())),
                DataCell(Text(car.price.toString())),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
