import 'package:flutter/material.dart';
import 'package:mobile/core/theme/app_colors.dart';
import 'package:mobile/features/flight_info/presentation/pages/create_flight_page.dart';

class FlightListPage extends StatefulWidget {
  const FlightListPage({super.key});

  @override
  State<FlightListPage> createState() => _FlightListPageState();
}

class _FlightListPageState extends State<FlightListPage> {
  int _selectedIndex = 0;
  final List<Map<String, dynamic>> _flights = []; // This will be populated from API

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Find",
                      filled: true,
                      fillColor: Colors.grey[900],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.filter_alt, color: Colors.white),
                  onPressed: () {},
                )
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: _flights.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.flight_takeoff,
                            size: 64,
                            color: Colors.white70,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No flights yet',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Tap the + button to create your first flight',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: _flights.length,
                      itemBuilder: (context, index) {
                        final flight = _flights[index];
                        return Card(
                          color: Colors.grey[900],
                          margin: EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            leading: Icon(Icons.flight_takeoff, color: Colors.white),
                            title: Text(
                              flight['title'] ?? 'Untitled Flight',
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              '${flight['fromCountry']} - ${flight['toCountry']}\n${flight['date']}',
                              style: TextStyle(color: Colors.white70),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.redAccent),
                              onPressed: () {
                                // TODO: Implement delete functionality
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateFlightPage()),
            );
          } else {
            setState(() {
              _selectedIndex = index;
            });
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Create',
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
