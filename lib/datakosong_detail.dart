import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DataKosongDetailScreen extends StatefulWidget {
  @override
  _DataKosongDetailScreenState createState() => _DataKosongDetailScreenState();
}

class _DataKosongDetailScreenState extends State<DataKosongDetailScreen> {
  List<Map<String, dynamic>> _DataKosong = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDataKosong();
  }

  Future<void> _fetchDataKosong() async {
    try {
      final response = await http.get(
          Uri.parse('http://yoloiss.com.yolois.my.id/datakosong_detail.php'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          setState(() {
            _DataKosong = List<Map<String, dynamic>>.from(data['data']);
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
        title: Text('Data Kosong Detail'),
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Data Kosong',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _DataKosong.isEmpty
                      ? Center(child: Text('No data available'))
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Table(
                                border: TableBorder.all(),
                                columnWidths: {
                                  0: FlexColumnWidth(1),
                                  1: FlexColumnWidth(2),
                                  2: FlexColumnWidth(1.5),
                                  3: FlexColumnWidth(1.5),
                                  4: FlexColumnWidth(2),
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
                                      buildTableCell('Foto', Colors.white),
                                    ],
                                  ),
                                  for (final item in _DataKosong)
                                    TableRow(
                                      children: [
                                        buildTableCell(
                                          item['id_dko'].toString(),
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
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: item['foto_data'] != null &&
                                                  item['foto_data'].isNotEmpty
                                              ? Image.memory(
                                                  base64Decode(
                                                      item['foto_data']),
                                                  width: double.infinity,
                                                  height: 100,
                                                  fit: BoxFit.cover,
                                                )
                                              : Center(
                                                  child: Text(
                                                    'No Image',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
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
                                    _DataKosong.length.toString(),
                                    Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ],
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
