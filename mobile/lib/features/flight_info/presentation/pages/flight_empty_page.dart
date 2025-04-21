import 'package:flutter/material.dart';
import 'package:mobile/core/theme/app_colors.dart';
import 'package:mobile/features/flight_info/presentation/pages/create_flight_page.dart';

class FlightEmptyPage extends StatefulWidget {
  const FlightEmptyPage({super.key});

  @override
  State<FlightEmptyPage> createState() => _FlightEmptyPageState();
}

class _FlightEmptyPageState extends State<FlightEmptyPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateFlightPage()),
          );
        },
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.add,
          color: Colors.white, // Make the + icon white
        ),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Icon(Icons.flight, size: 48, color: Colors.white),
          SizedBox(height: 16),
          Text(
            "No Flight Details Yet",
            style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white, fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8),
            child: Text(
              "Start by adding your travel info — origin, destination, reason, and more — so we can help you communicate clearly at your destination",
              style: TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
          ),
          Spacer(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
