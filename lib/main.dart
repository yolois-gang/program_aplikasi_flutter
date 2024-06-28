import 'package:flutter/material.dart';
import 'package:yolois_update/dashboard.dart';
import 'package:yolois_update/home.dart';
import 'package:yolois_update/splash_screen.dart';
import 'package:yolois_update/login.dart';
import 'package:yolois_update/data_detail.dart';
import 'package:yolois_update/datamasuk_detail.dart';
import 'package:yolois_update/datakeluar_detail.dart';
import 'package:yolois_update/datakosong_detail.dart';
import 'package:yolois_update/dataanomali_detail.dart';
import 'package:yolois_update/schedule_detail.dart';
import 'package:yolois_update/schedule_detail_ruangan.dart';
import 'package:yolois_update/device_condition.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String roomName = ''; // Ganti dengan nilai ruangan yang sesuai

    return MaterialApp(
      title: 'YOLOIS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Definisi routing dengan menggunakan routes
      routes: {
        '/': (context) => SplashScreen(), // Route untuk SplashScreen
        '/login': (context) => LoginPage(), // Route untuk LoginPage
        '/home': (context) => HomeScreen(), // Route untuk HomeScreen
        '/dashboard': (context) => Dashboard(),
        '/data_detail': (context) =>
            DataDetailScreen(), // Route untuk DataDetailScreen
        '/data_masuk_detail': (context) => DataMasukDetailScreen(),
        '/data_keluar_detail': (context) => DataKeluarDetailScreen(),
        '/data_kosong_detail': (context) => DataKosongDetailScreen(),
        '/data_anomali_detail': (context) => DataAnomaliDetailScreen(),
        '/schedule_detail': (context) =>
            ScheduleDetail(), // Route untuk ScheduleDetailScreen
        '/schedule_detail_ruangan': (context) => ScheduleRuanganDetail(
            roomName: roomName), // Gunakan nilai roomName di sini
        '/device_condition': (context) => DeviceCondition()
      },
      initialRoute:
          '/', // Route awal yang akan ditampilkan saat pertama kali aplikasi dijalankan
    );
  }
}
