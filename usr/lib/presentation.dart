import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class SaudiPresentation extends StatefulWidget {
  const SaudiPresentation({super.key});

  @override
  State<SaudiPresentation> createState() => _SaudiPresentationState();
}

class _SaudiPresentationState extends State<SaudiPresentation> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _wobbleTimer;
  double _wobble = 0.0;

  // Lista de slide-uri cu datele necesare
  final List<SlideData> _slides = [
    SlideData(
      title: "ARABIA SAUDITA!!!!",
      subtitle: "Proiect de Geografie\nFacut de mine (Elevul)",
      bgColor: Colors.redAccent,
      icon: Icons.flag,
      description: "Cel mai tare proiect!!!",
    ),
    SlideData(
      title: "UNDE ESTE??? 🌍",
      subtitle: "E in Asia, in Orientul Mijlociu!",
      bgColor: Colors.blueAccent,
      icon: Icons.public,
      description: "E super mare si are multa iesire la mare (Marea Rosie).",
    ),
    SlideData(
      title: "CAPITALA: RIAD 🏙️",
      subtitle: "Un oras GIGANTIC!",
      bgColor: Colors.purpleAccent,
      icon: Icons.location_city,
      description: "Sunt blocuri foarte inalte si mall-uri uriase.",
    ),
    SlideData(
      title: "DESERTUL ☀️",
      subtitle: "Rub' al Khali",
      bgColor: Colors.orangeAccent,
      icon: Icons.landscape,
      description: "E doar nisip peste tot! E foarte cald, ia-ti apa! 🥵",
    ),
    SlideData(
      title: "PETROL = BANI 💰",
      subtitle: "Aurul Negru",
      bgColor: Colors.greenAccent,
      icon: Icons.oil_barrel,
      description: "Arabia Saudita e super bogata pentru ca are mult petrol sub pamant.",
    ),
    SlideData(
      title: "CAMILELE 🐫",
      subtitle: "Vapoarele Desertului",
      bgColor: Colors.brown,
      icon: Icons.pets,
      description: "Sunt animalele mele preferate. Rezista fara apa mult timp!",
    ),
    SlideData(
      title: "MECCA 🕌",
      subtitle: "Loc Sfant",
      bgColor: Colors.teal,
      icon: Icons.mosque,
      description: "Milioane de oameni vin aici in fiecare an. E foarte important.",
    ),
    SlideData(
      title: "MANCAREA 🍗",
      subtitle: "Kabsa e delicioasa!",
      bgColor: Colors.deepOrange,
      icon: Icons.restaurant,
      description: "Orez cu carne si multe condimente. Miam miam!",
    ),
    SlideData(
      title: "VIITORUL: NEOM 🚀",
      subtitle: "Orasul SF",
      bgColor: Colors.indigoAccent,
      icon: Icons.rocket_launch,
      description: "Vor sa faca un oras care e o linie dreapta (The Line). Arata ca in filme!",
    ),
    SlideData(
      title: "SFARSIT!!! 👋",
      subtitle: "Multumesc pentru atentie!",
      bgColor: Colors.pinkAccent,
      icon: Icons.star,
      description: "Sper ca v-a placut! Nota 10 va rog!!!",
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Efect de "tremurat" pentru a parea mai dinamic/copilaresc
    _wobbleTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (mounted) {
        setState(() {
          _wobble = _wobble == 0.0 ? 0.05 : 0.0;
        });
      }
    });
  }

  @override
  void dispose() {
    _wobbleTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 800),
        curve: Curves.elasticOut, // Tranzitie "bouncy"
      );
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 800),
        curve: Curves.elasticOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _slides.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return SlideWidget(
                data: _slides[index],
                wobble: _wobble,
              );
            },
          ),
          // Butoane de navigare mari si urate (intentionat)
          Positioned(
            bottom: 20,
            left: 20,
            child: FloatingActionButton(
              heroTag: "prev",
              onPressed: _currentPage > 0 ? _prevPage : null,
              backgroundColor: Colors.yellow,
              child: const Icon(Icons.arrow_back, color: Colors.black, size: 30),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              heroTag: "next",
              onPressed: _currentPage < _slides.length - 1 ? _nextPage : null,
              backgroundColor: Colors.yellow,
              child: const Icon(Icons.arrow_forward, color: Colors.black, size: 30),
            ),
          ),
          // Numarul paginii
          Positioned(
            top: 40,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "${_currentPage + 1} / ${_slides.length}",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SlideData {
  final String title;
  final String subtitle;
  final Color bgColor;
  final IconData icon;
  final String description;

  SlideData({
    required this.title,
    required this.subtitle,
    required this.bgColor,
    required this.icon,
    required this.description,
  });
}

class SlideWidget extends StatelessWidget {
  final SlideData data;
  final double wobble;

  const SlideWidget({super.key, required this.data, required this.wobble});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            data.bgColor,
            Colors.white,
          ],
          stops: const [0.3, 1.0],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Titlu care se roteste putin
            Transform.rotate(
              angle: wobble,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  border: Border.all(color: Colors.black, width: 5),
                  boxShadow: const [
                    BoxShadow(color: Colors.black, offset: Offset(5, 5))
                  ],
                ),
                child: Text(
                  data.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: Colors.blue,
                    shadows: [
                      Shadow(
                        blurRadius: 2.0,
                        color: Colors.red,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Imaginea (Iconita mare)
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.bounceOut,
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 3),
              ),
              child: Icon(
                data.icon,
                size: 100,
                color: data.bgColor,
              ),
            ),
            const SizedBox(height: 30),
            // Subtitlu
            Text(
              data.subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                backgroundColor: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            // Descriere
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.red, width: 2, style: BorderStyle.solid),
              ),
              child: Text(
                data.description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Emoji-uri random pentru efect
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _BouncingEmoji(emoji: "✨", delay: 0),
                _BouncingEmoji(emoji: "🔥", delay: 100),
                _BouncingEmoji(emoji: "🇸🇦", delay: 200),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BouncingEmoji extends StatefulWidget {
  final String emoji;
  final int delay;

  const _BouncingEmoji({required this.emoji, required this.delay});

  @override
  State<_BouncingEmoji> createState() => _BouncingEmojiState();
}

class _BouncingEmojiState extends State<_BouncingEmoji> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _controller.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, -_animation.value),
          child: Text(
            widget.emoji,
            style: const TextStyle(fontSize: 40),
          ),
        );
      },
    );
  }
}
