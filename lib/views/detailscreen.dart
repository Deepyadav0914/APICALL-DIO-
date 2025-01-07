import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/usermodel.dart';

class Detailscreen extends StatefulWidget {
  final String date;
  final Datum item;

  const Detailscreen({super.key, required this.date, required this.item});

  @override
  _DetailscreenState createState() => _DetailscreenState();
}

class _DetailscreenState extends State<Detailscreen> {
  late String description;
  late String title;
  late String imgurl;
  late String codeurl;

  @override
  void initState() {
    super.initState();
    description = widget.item.description;
    title = widget.item.title;
    imgurl = widget.item.imgurl;
    codeurl = widget.item.codeurl;
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      print(url);
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not launch $url'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Details for ${widget.date}",
          style: const TextStyle(
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
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isWideScreen ? 32 : 16,
              vertical: isWideScreen ? 24 : 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      imgurl,
                      height: isWideScreen ? 250 : 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: isWideScreen ? 250 : 200,
                          color: Colors.grey[200],
                          child: const Icon(
                            Icons.broken_image,
                            size: 50,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Title",
                  style: TextStyle(
                    fontSize: isWideScreen ? 20 : 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: isWideScreen ? 18 : 16,
                    color: Colors.black87,
                  ),
                ),
                const Divider(height: 30, thickness: 1),
                Text(
                  "Description",
                  style: TextStyle(
                    fontSize: isWideScreen ? 20 : 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: isWideScreen ? 18 : 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 40),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {

                      },
                      icon: const Icon(Icons.share),
                      label: const Text("Share"),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        backgroundColor: Colors.blue,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        print(codeurl);
                        _launchURL(codeurl);
                      },
                      icon: const Icon(Icons.favorite),
                      label: const Text("Collect"),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        backgroundColor: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
