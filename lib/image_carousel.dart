import 'package:carousel_slider/carousel_slider.dart' as carousel_slider;
import 'package:flutter/material.dart';
import 'package:sl_portal/singup.dart';

class ImageCarousel extends StatefulWidget {
  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int _currentIndex = 0;
  int _loopCount = 0;
  final int _maxLoops = 1; // Number of loops you want the carousel to play

  final List<Map<String, String>> imgList = [
    {
      'path': 'assets/Carousel/Beaches.png',
      'description': 'Step into paradise and feel the warmth of the sun',
      'title': 'Sunny Beaches'
    },
    {
      'path': 'assets/Carousel/Temple.jpg',
      'description': 'Find peace in sacred temples',
      'title': 'Spiritual Landmarks'
    },
    {
      'path': 'assets/Carousel/Perehera.jpg',
      'description': 'Immerse yourself in vibrant cultural events',
      'title': 'Rich Cultures'
    },
    {
      'path': 'assets/Carousel/Waterfall.jpg',
      'description': 'Let the natural beauty capture your soul',
      'title': 'Cascading Waterfalls'
    },
    {
      'path': 'assets/Carousel/Sigiriya.jpg',
      'description': 'Discover the centuries of tradition and artistry',
      'title': 'Timeless Heritage'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return carousel_slider.CarouselSlider(
      options: carousel_slider.CarouselOptions(
        height: MediaQuery.of(context).size.height,
        viewportFraction: 1.0, // Full width of each item
        enlargeCenterPage: false,
        autoPlay: _loopCount < _maxLoops, // Stop auto-play after one loop
        autoPlayInterval: const Duration(seconds: 4),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        scrollDirection: Axis.horizontal,
        onPageChanged: (index, reason) {
          setState(() {
            _currentIndex = index;

            // Check if we reached the last item and increment loop count
            if (_currentIndex == imgList.length - 1) {
              _loopCount += 1;
              if (_loopCount == _maxLoops) {
                // Wait for the duration of the last image being displayed before navigating
                Future.delayed(const Duration(seconds: 2), () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignupScreen()),
                  );
                });
              }
            }
          });
        },
      ), // Disable center enlargement),
      items: imgList.map((item) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Stack(
                children: <Widget>[
                  Image.asset(item['path']!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20.0),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(5, 0, 0, 0),
                              Color.fromARGB(150, 0, 0, 0),
                              Color.fromARGB(255, 0, 0, 0)
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Column(children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              item['title']!,
                              style: const TextStyle(
                                color: Color(0xFFFFFAF0),
                                fontFamily: 'RockyBilly',
                                fontSize: 40.0,
                                height: 2.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                              height: 18.0), // Add a 10px space after the title
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              item['description']!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                // Centers the description text within the widget
                              ),
                            ),
                          ),
                        ])),
                  ),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
