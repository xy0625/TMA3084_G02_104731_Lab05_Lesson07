import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screen1.dart';
import 'screen2.dart';
import 'screen3.dart';
import 'screen4.dart';

class TabModel extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void updateCurrentIndex(int index) {
    if (index == _currentIndex) return;
    _currentIndex = index;
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TabModel(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BottomNavLab(),
      ),
    ),
  );
}

class BottomNavLab extends StatelessWidget {
  const BottomNavLab({super.key});

  final List<Widget> screens = const [
    Screen1(),
    Screen2(),
    Screen3(),
    Screen4(),
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.watch<TabModel>().currentIndex;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 05: Exercise A'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.white,
        backgroundColor: Colors.blue,
        iconSize: 30,
        currentIndex: currentIndex,
        onTap: (int index) {
          context.read<TabModel>().updateCurrentIndex(index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.alarm), label: 'Alarm'),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'School'),
        ],
      ),
    );
  }
}
