import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel App UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false, // Set this to false
      home: const TravelHomePage(),
    );
  }
}

class TravelHomePage extends StatefulWidget {
  const TravelHomePage({super.key});

  @override
  State<TravelHomePage> createState() => _TravelHomePageState();
}

class _TravelHomePageState extends State<TravelHomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _goToNextPage() {
    if (_currentPage < 2) { // Assuming 3 pages (0, 1, 2)
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: const [
              LocationPage(
                imagePath: 'assets/chamarra.jpg',
                locationName: 'CHAMARRA DE CUERO',
                rating: 4.0,
                reviews: 2000,
                description:
                    "Chamarra de cuero estilo aviador, con cuello de piel de oveja. Clásica, robusta y con parches que le dan un toque vintage. Ideal para un estilo distintivo.",
              ),
              LocationPage(
                imagePath: 'assets/nike.jpg',
                locationName: 'NIKES TRAVIS SCOTT',
                rating: 4.0,
                reviews: 2000,
                description:
                    "Estos tenis destacan por su estética de tonos terrosos y un diseño de corte bajo. Ofrecen una combinación perfecta de estilo moderno y versatilidad, ideales para complementar una amplia gama de atuendos casuales con un toque contemporáneo.",
              ),
              LocationPage(
                imagePath: 'assets/short.jpg',
                locationName: 'SHORT',
                rating: 4.0,
                reviews: 2000,
                description:
                    "Estos shorts de mezclilla destacan por sus elaborados bordados de un pez koi y una ola japonesa, con detalles de flores de cerezo. Ofrecen una estética audaz y artística, perfectos para un estilo casual con mucha personalidad.",
              ),
            ],
          ),
          Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '7:59',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${_currentPage + 1}/3',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (_currentPage > 0) // Only show previous button if not on the first page
              FloatingActionButton(
                onPressed: _goToPreviousPage,
                backgroundColor: Colors.white.withOpacity(0.7),
                child: const Icon(Icons.arrow_back, color: Colors.black),
              ),
            if (_currentPage < 2) // Only show next button if not on the last page
              FloatingActionButton(
                onPressed: _goToNextPage,
                backgroundColor: Colors.white.withOpacity(0.7),
                child: const Icon(Icons.arrow_forward, color: Colors.black),
              ),
          ],
        ),
      ),
    );
  }
}

class LocationPage extends StatelessWidget {
  final String imagePath;
  final String locationName;
  final double rating;
  final int reviews;
  final String description;

  const LocationPage({
    super.key,
    required this.imagePath,
    required this.locationName,
    required this.rating,
    required this.reviews,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.3),
            BlendMode.darken,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  locationName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    ...List.generate(
                      5,
                      (index) => Icon(
                        index < rating.floor() ? Icons.star : Icons.star_border,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '$rating ($reviews)',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 25),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Leer más sobre $locationName')),
                    );
                  },
                  child: const Text(
                    'READ MORE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}