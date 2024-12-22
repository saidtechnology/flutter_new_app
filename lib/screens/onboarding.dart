import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pageModel.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'home_screen.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  late final List<PageModel> pages;
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _addPages();
  }

  void _addPages() {
    pages = [
      PageModel(
        'Welcome',
        'Making friends is easy as waving your hand back and forth is easy step for Welcome.',
        'assets/images/onboarding_screen_1.jpg',
        Icons.account_circle,
      ),
      PageModel(
        'Shopping',
        'Making friends is easy as waving your hand back and forth is easy step for Shop.',
        'assets/images/onboarding_screen_2.jpg',
        Icons.add_shopping_cart,
      ),
      PageModel(
        'Flying',
        'Making friends is easy as waving your hand back and forth is easy step for Fly.',
        'assets/images/onboarding_screen_3.jpg',
        Icons.map,
      ),
      PageModel(
        'Photos',
        'Making friends is easy as waving your hand back and forth is easy step for Photos.',
        'assets/images/onboarding_screen_4.jpg',
        Icons.add_a_photo,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView.builder(
            controller: _pageController,
            itemBuilder: (context, index) {
              return Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(pages[index].image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromRGBO(0, 0, 0, 0.3),
                          Color.fromRGBO(0, 0, 0, 0.5),
                        ],
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Transform.translate(
                          offset: const Offset(0, -100),
                          child: Icon(
                            pages[index].icon,
                            size: 150,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          pages[index].title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          child: Text(
                            pages[index].description,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            itemCount: pages.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(24.0),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Color.fromRGBO(0, 0, 0, 0.7),
                  ],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: pages.length,
                    effect: const WormEffect(
                      dotColor: Colors.grey,
                      activeDotColor: Colors.white,
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 8,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_currentPage == pages.length - 1) {
                        _updateSeen();
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      }
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: Text(
                      _currentPage == pages.length - 1 ? 'GET STARTED' : 'NEXT',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _updateSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seen', true);
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
