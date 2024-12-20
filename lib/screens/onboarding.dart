import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pageModel.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'home_screen.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<PageModel> pages;
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _addPages() {
    pages = List<PageModel>();

    pages.add(
      PageModel(
        'Welcome',
        'Making friends is easy as waving your hand back and forth is easy step for Welcome.',
        'assets/images/onboarding_screen_1.jpg',
        Icons.account_circle,
      ),
    );
    pages.add(
      PageModel(
        'Shopping ',
        'Making friends is easy as waving your hand back and forth is easy step for Shop.',
        'assets/images/onboarding_screen_2.jpg',
        Icons.add_shopping_cart,
      ),
    );

    pages.add(
      PageModel(
        'Flying',
        'Making friends is easy as waving your hand back and forth is easy step for Fly.',
        'assets/images/onboarding_screen_3.jpg',
        Icons.map,
      ),
    );

    pages.add(
      PageModel(
        'Photos',
        'Making friends is easy as waving your hand back and forth is easy step for Photos.',
        'assets/images/onboarding_screen_4.jpg',
        Icons.add_a_photo,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _addPages();
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
                        image: ExactAssetImage(
                          pages[index].image,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Transform.translate(
                        offset: Offset(0, -100),
                        child: Icon(
                          pages[index].icon,
                          size: 150,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        pages[index].title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          pages[index].description,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0, left: 16.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: pages.length,
                    effect: WormEffect(
                      dotColor: Colors.grey,
                      activeDotColor: Colors.white,
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 8,
                    ),
                  ),
                  TextButton(
                    child: Text(
                      _currentPage == pages.length - 1 ? 'GET STARTED' : 'NEXT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {
                      if (_currentPage == pages.length - 1) {
                        _updateSeen();
                      } else {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _updateSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seen', true);
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
