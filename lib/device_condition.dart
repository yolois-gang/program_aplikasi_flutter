import 'package:flutter/material.dart';
import 'dart:math'; // Import dart:math for max function

class DeviceCondition extends StatefulWidget {
  @override
  _DeviceConditionState createState() => _DeviceConditionState();
}

class _DeviceConditionState extends State<DeviceCondition> {
  PageController _pageController = PageController(viewportFraction: 0.8);
  double _currentPage = 0.0;

  final List<Map<String, String>> _devices = [
    {'image': 'assets/ajs.png', 'title': 'AJS Device'},
    {'image': 'assets/classroom.png', 'title': 'Classroom Device'},
    {'image': 'assets/iot.png', 'title': 'IoT Device'},
    {'image': 'assets/dosen.png', 'title': 'Dosen Device'},
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void navigateToDashboard(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Device Condition'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Container(
          height: 450, // Adjust the height as needed
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                20.0), // Adjust the border radius as needed
          ),
          child: PageView.builder(
            controller: _pageController,
            itemCount: _devices.length,
            itemBuilder: (context, index) {
              double scale = max(0.8, 1 - (_currentPage - index).abs() + 0.2);
              return DeviceCard(
                image: _devices[index]['image']!,
                title: _devices[index]['title']!,
                scale: scale,
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () => navigateToDashboard(context),
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // Add logic for search action
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DeviceCard extends StatelessWidget {
  final String image;
  final String title;
  final double scale;

  DeviceCard({required this.image, required this.title, required this.scale});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: Container(
        width: 100, // Adjust the width as needed
        margin: EdgeInsets.symmetric(horizontal: 8.0), // Margin between cards
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 249, 173, 60), // Card color
          borderRadius: BorderRadius.circular(12.0), // Border radius
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0), // Padding inside card
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                width: 100 * scale,
                height: 100 * scale,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(fontSize: 16 * scale),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
