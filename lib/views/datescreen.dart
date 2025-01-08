import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../model/usermodel.dart';
import 'datesortscreen.dart';

class Datescreen extends StatefulWidget {
  const Datescreen({super.key});

  @override
  State<Datescreen> createState() => _DatescreenState();
}

class _DatescreenState extends State<Datescreen> {
  late Future<Usermodel> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = fetchData();
  }

  Future<Usermodel> fetchData() async {
    try {
      var response = await Dio()
          .get('https://miracocopepsi.com/admin/mayur/data_darsh/data.json');

      if (response.statusCode == 200) {
        print(response.data);
        return Usermodel.fromJson(response.data);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.blueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          "Date Screen",
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWideScreen = constraints.maxWidth > 600;

          return FutureBuilder<Usermodel>(
            future: _dataFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.blue),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Failed to load data. Please try again.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.red.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _dataFuture = fetchData();
                          });
                        },
                        child: const Text("Retry"),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasData) {
                final allData = snapshot.data!.data;

                final Map<String, List<Datum>> groupedData = {};
                for (var item in allData) {
                  String date = item.date;
                  groupedData.putIfAbsent(date, () => []).add(item);
                }

                final uniqueDates = groupedData.keys.toList();

                return ListView.builder(
                  itemCount: uniqueDates.length,
                  padding: EdgeInsets.symmetric(
                      vertical: isWideScreen ? 16 : 8,
                      horizontal: isWideScreen ? 32 : 16),
                  itemBuilder: (context, index) {
                    final date = uniqueDates[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        title: Text(
                          date,
                          style: TextStyle(
                            fontSize: isWideScreen ? 20 : 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.blue,
                        ),
                        onTap: () {
                          print(date);
                          print(groupedData);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DatesortScreen(
                                date: date,
                                data: groupedData[date]!,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              }

              return const SizedBox();
            },
          );
        },
      ),
    );
  }
}
