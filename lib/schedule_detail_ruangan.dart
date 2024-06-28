import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ScheduleRuanganDetail extends StatefulWidget {
  final String roomName;

  ScheduleRuanganDetail({required this.roomName});

  @override
  _ScheduleRuanganDetailState createState() => _ScheduleRuanganDetailState();
}

class _ScheduleRuanganDetailState extends State<ScheduleRuanganDetail> {
  List<Map<String, dynamic>> _scheduleData = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchScheduleData();
  }

  Future<void> _fetchScheduleData() async {
    try {
      final response = await http.get(Uri.parse(
          'http://yoloiss.com.yolois.my.id/schedule_detail_ruangan.php'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          setState(() {
            _scheduleData = List<Map<String, dynamic>>.from(data['data'])
                .where((item) => item['nama_ruangan'] == widget.roomName)
                .toList();
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
        title: Text('Schedule Ruangan Detail'),
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
          : _scheduleData.isEmpty
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
                            widget.roomName,
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
                          child: Table(
                            border: TableBorder.all(),
                            columnWidths: {
                              0: FlexColumnWidth(1),
                              1: FlexColumnWidth(1.5),
                              2: FlexColumnWidth(1.5),
                              3: FlexColumnWidth(2),
                              4: FlexColumnWidth(2),
                              5: FlexColumnWidth(1.5),
                              6: FlexColumnWidth(1.5),
                            },
                            children: [
                              TableRow(
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                ),
                                children: [
                                  buildTableCell('Nomor Ruang', Colors.white),
                                  buildTableCell('Jam Masuk', Colors.white),
                                  buildTableCell('Jam Keluar', Colors.white),
                                  buildTableCell('Matakuliah', Colors.white),
                                  buildTableCell('Nama Kelas', Colors.white),
                                  buildTableCell('Jumlah Masuk', Colors.white),
                                  buildTableCell('Jumlah Keluar', Colors.white),
                                ],
                              ),
                              for (final item in _scheduleData)
                                TableRow(
                                  children: [
                                    buildTableCell(
                                      item['no_ruangan'].toString(),
                                      Colors.white,
                                    ),
                                    buildTableCell(
                                      item['jam_masuk'].toString(),
                                      Colors.white,
                                    ),
                                    buildTableCell(
                                      item['jam_keluar'].toString(),
                                      Colors.white,
                                    ),
                                    buildTableCell(
                                      item['nama_matkul'].toString(),
                                      Colors.white,
                                    ),
                                    buildTableCell(
                                      item['nama_kelas'].toString(),
                                      Colors.white,
                                    ),
                                    buildTableCell(
                                      item['timestamp_count_masuk'].toString(),
                                      Colors.white,
                                    ),
                                    buildTableCell(
                                      item['timestamp_count_keluar'].toString(),
                                      Colors.white,
                                    ),
                                  ],
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
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
