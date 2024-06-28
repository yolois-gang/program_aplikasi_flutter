import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DataKeluarDetailScreen extends StatefulWidget {
  @override
  _DataKeluarDetailScreenState createState() => _DataKeluarDetailScreenState();
}

class _DataKeluarDetailScreenState extends State<DataKeluarDetailScreen> {
  List<Map<String, dynamic>> _DataKeluar = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDataKeluar();
  }

  Future<void> _fetchDataKeluar() async {
    try {
      final response = await http.get(
          Uri.parse('http://yoloiss.com.yolois.my.id/datakeluar_detail.php'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          setState(() {
            _DataKeluar = List<Map<String, dynamic>>.from(data['data']);
            _isLoading = false;
          });
        } else {
          setState(() {
            _isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['message'])),
          );
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load data. Please try again.')),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Keluar Detail'),
        backgroundColor: Colors.blue,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/dashboard'));
              },
            ),
          ],
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _DataKeluar.isEmpty
              ? Center(child: Text('No data available'))
              : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Data Keluar',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue, // Background color biru
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Table(
                                border: TableBorder.all(),
                                columnWidths: {
                                  0: FlexColumnWidth(1), // ID
                                  1: FlexColumnWidth(2), // Waktu
                                  2: FlexColumnWidth(1.5), // Gerakan
                                  3: FlexColumnWidth(1.5), // Sensor
                                },
                                children: [
                                  TableRow(
                                    decoration: BoxDecoration(
                                      color: Colors.orange,
                                    ),
                                    children: [
                                      buildTableCell('ID', Colors.white),
                                      buildTableCell('Waktu', Colors.white),
                                      buildTableCell('Gerakan', Colors.white),
                                      buildTableCell('Sensor', Colors.white),
                                    ],
                                  ),
                                  for (final item in _DataKeluar)
                                    TableRow(
                                      children: [
                                        buildTableCell(
                                          item['id_dke'].toString(),
                                          Colors.white,
                                        ),
                                        buildTableCell(
                                          item['timestamp'].toString(),
                                          Colors.white,
                                        ),
                                        buildTableCell(
                                          item['gerakan'].toString(),
                                          Colors.white,
                                        ),
                                        buildTableCell(
                                          item['sensor'].toString(),
                                          Colors.white,
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                              SizedBox(height: 10),
                              // Jumlah total data keluar
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    buildTableCell(
                                      'Jumlah Data :',
                                      Colors.white,
                                    ),
                                    buildTableCell(
                                      _DataKeluar.length.toString(),
                                      Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget buildTableCell(String text, Color textColor) {
    return TableCell(
      child: Container(
        padding: EdgeInsets.all(8),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
