import 'package:flutter/material.dart';
import '../model/usermodel.dart';
import 'detailscreen.dart';

class DatesortScreen extends StatelessWidget {
  final String date;
  final List<Datum> data;
  const DatesortScreen({super.key, required this.date, required this.data});

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
        title: Text(
          "Entries for $date",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWideScreen = constraints.maxWidth > 600;
          return ListView.builder(
            itemCount: data.length,
            padding: EdgeInsets.symmetric(
                vertical: isWideScreen ? 16 : 8,
                horizontal: isWideScreen ? 32 : 16),
            itemBuilder: (context, index) {
              final item = data[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  onTap: () async {
                    print(item);
                    Navigator.push<Datum>(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Detailscreen(
                          date: item.date,
                          item: item,
                        ),
                      ),
                    );
                  },
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      item.imgurl,
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 60,
                          width: 60,
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.broken_image,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                  title: Text(
                    item.title,
                    style: TextStyle(
                      fontSize: isWideScreen ? 18 : 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  subtitle: Text(
                    item.description,
                    style: TextStyle(
                      fontSize: isWideScreen ? 16 : 14,
                      color: Colors.black54,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.blue,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
