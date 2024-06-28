import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => showProfileMenu(context,
                  'yolois'), // Ubah 'Akbar' sesuai dengan nama pengguna dari database
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/mahasiswa.png'),
              ),
            ),
          ),
        ],
      ),
      body: DashboardBody(),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 32, 123, 197),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {
                Navigator.pushNamed(context, '/dashboard');
              },
            ),
            IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () {
                Navigator.pushNamed(context, '/search');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardBody extends StatefulWidget {
  @override
  _DashboardBodyState createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {
  Future<void> _refreshData() async {
    // Simulate fetching new data from the server or database
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      // Update the data in the state to reflect the new data
      // If you have real data to fetch, replace this part with actual data fetching logic
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 50.0),
        child: SingleChildScrollView(
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            children: <Widget>[
              DashboardCard(
                title: 'DATA',
                image: 'assets/data.png',
                color: Color.fromARGB(255, 249, 173, 60),
                onTap: () {
                  Navigator.pushNamed(context, '/data_detail');
                },
              ),
              DashboardCard(
                title: 'SCHEDULE',
                image: 'assets/schedule.png',
                color: Color.fromARGB(255, 249, 173, 60),
                onTap: () {
                  Navigator.pushNamed(context, '/schedule_detail');
                },
              ),
              DashboardCard(
                title: 'DEVICE CONDITION',
                image: 'assets/device_condition.png',
                color: Color.fromARGB(255, 249, 173, 60),
                onTap: () {
                  Navigator.pushNamed(context, '/device_condition');
                },
              ),
              DashboardCard(
                title: 'CASE',
                image: 'assets/case.png',
                color: Color.fromARGB(255, 249, 173, 60),
                onTap: () {
                  Navigator.pushNamed(context, '/data_anomali_detail');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String image;
  final bool doubleSize;
  final Color color;
  final Function()? onTap; // Callback function when card is tapped

  const DashboardCard({
    Key? key,
    required this.title,
    required this.image,
    this.doubleSize = false,
    required this.color,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Color.fromARGB(255, 5, 5, 5),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Image.asset(
              image,
              width: doubleSize ? 150.0 : 100.0,
              height: doubleSize ? 150.0 : 100.0,
            ),
          ],
        ),
      ),
    );
  }
}

void showProfileMenu(BuildContext context, String username) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.person),
              title: Text(username), // Menampilkan nama pengguna dari parameter
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () {
                Navigator.pushNamed(context, '/login'); // Navigate to LoginPage
              },
            ),
          ],
        ),
      );
    },
  );
}
