import 'package:flutter/material.dart';
import 'dashboard.dart'; // Mengimpor file datamasuk_detail.dart

class DataDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Detail'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CardOne(),
            SizedBox(height: 16),
            CardTwo(),
            SizedBox(height: 16),
            CardThree(),
            SizedBox(height: 16),
            CardFour(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  // Navigasi ke halaman Dashboard
                  context,
                  MaterialPageRoute(builder: (context) => Dashboard()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CardOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      title: 'Data Masuk',
      imageAsset: 'assets/data_masuk.png',
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 249, 173, 60),
        borderRadius: BorderRadius.circular(10),
      ),
      onTap: () {
        Navigator.pushNamed(context, '/data_masuk_detail');
      },
    );
  }
}

class CardTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      title: 'Data Keluar',
      imageAsset: 'assets/data_keluar.png',
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 249, 173, 60),
        borderRadius: BorderRadius.circular(10),
      ),
      onTap: () {
        Navigator.pushNamed(context, '/data_keluar_detail');
      },
    );
  }
}

class CardThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      title: 'Data Kosong',
      imageAsset: 'assets/data_kosong.png',
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 249, 173, 60),
        borderRadius: BorderRadius.circular(10),
      ),
      onTap: () {
        Navigator.pushNamed(context, '/data_kosong_detail');
      },
    );
  }
}

class CardFour extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      title: 'Data Anomali',
      imageAsset: 'assets/data_anomali.png',
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 249, 173, 60),
        borderRadius: BorderRadius.circular(10),
      ),
      onTap: () {
        Navigator.pushNamed(context, '/data_anomali_detail');
      },
    );
  }
}

class CustomCard extends StatelessWidget {
  final String title;
  final String imageAsset;
  final BoxDecoration decoration;
  final VoidCallback onTap;

  const CustomCard({
    Key? key,
    required this.title,
    required this.imageAsset,
    required this.decoration,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        child: Container(
          constraints:
              BoxConstraints(minHeight: 120), // Menetapkan tinggi minimum kartu
          padding: EdgeInsets.all(16),
          decoration: decoration,
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 80,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange),
                    ),
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 100.0),
                      child: Text(
                        title,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Image.asset(
                    imageAsset,
                    width: 100,
                    height: 100,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
