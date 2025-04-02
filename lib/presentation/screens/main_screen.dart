import 'package:flutter/material.dart';
import 'package:social_network/presentation/components/main_screen/bottom_nav_bar.dart';
import 'package:social_network/presentation/screens/home/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static final List<Widget> _screens = <Widget>[
    HomeScreen(),
    Center(child: Text('Page 2', style: TextStyle(fontSize: 24))),
    Center(child: Text('Page 3', style: TextStyle(fontSize: 24))),
    Center(child: Text('Page 4', style: TextStyle(fontSize: 24))),
    Center(child: Text('Page 5', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _onItemTapped(2);
        },
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add_a_photo_outlined, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
