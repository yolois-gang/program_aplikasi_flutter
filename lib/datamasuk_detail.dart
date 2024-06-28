import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DataMasukDetailScreen extends StatefulWidget {
  @override
  _DataMasukDetailScreenState createState() => _DataMasukDetailScreenState();
}

class _DataMasukDetailScreenState extends State<DataMasukDetailScreen> {
  List<Map<String, dynamic>> _dataMasuk = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDataMasuk();
  }

  Future<void> _fetchDataMasuk() async {
    try {
      final response = await http.get(
        Uri.parse('http://yoloiss.com.yolois.my.id/datamasuk_detail.php'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          setState(() {
            _dataMasuk = List<Map<String, dynamic>>.from(data['data']);
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
        title: Text('Data Masuk Detail'),
        backgroundColor: Colors.blue,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _dataMasuk.isEmpty
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
                            'Data Masuk',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Table(
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
                                  for (final item in _dataMasuk)
                                    TableRow(
                                      children: [
                                        buildTableCell(
                                          item['id_dm'].toString(),
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
                                                  width: 100,
                                                  height: 95,
                                                  fit: BoxFit.cover,
                                                )
                                              : Center(
                                                  child: Text(
                                                    'No Image',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                        ),
                                      ],
                                    ),
                                ],
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
                                    Expanded(
                                      child: Text(
                                        'Jumlah Data :',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        _dataMasuk.length.toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
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
    return Container(
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
    );
  }
}
