import 'package:flutter/material.dart';
import './card_detail.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 240,
        title: Flexible(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.fromLTRB(
                        0, 25.0, 0, 20),
                child: const Icon(
                  Icons.arrow_back_ios,
                ),
              ),
              const Text(
                'Appliances',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: <Widget>[
          buildCard(context, 'Refrigerator',
              'assets/Arugam bay.jpg'),
          buildCard(context, 'Washing Machine',
              'assets/Galle Fort.jpg'),
          buildCard(context, 'Rice Cooker',
              'assets/Horton Plains.jpg'),
          buildCard(context, 'kettle',
              'assets/Temple.jpg'),
        ],
      ),
    );
  }

  Widget buildCard(BuildContext context,
      String title, String imagePath) {
    return InkWell(
      onTap: () {
        // Navigate to a new page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CardDetail(title, imagePath),
          ),
        );
      },
      child: Card(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: Image.asset(
                imagePath,
                height: 128,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight:
                            FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
