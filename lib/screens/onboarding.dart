import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pageModel.dart';
import 'package:page_view_indicator/page_view_indicator.dart';
import 'home_screen.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<PageModel> pages;
  ValueNotifier<int> _pageViewNotifier = ValueNotifier(0);

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
    return Stack(
      children: <Widget>[
        Scaffold(
          body: PageView.builder(
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
                        child: Icon(
                          pages[index].icon,
                          size: 80,
                          color: Colors.lightGreenAccent,
                        ),
                        offset: Offset(0, -250),
                      ),
                      
                      Transform.translate(
                        child: Text(
                          pages[index].title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ), offset: Offset(0 , 120),
                      ),
                      Transform.translate(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 48,
                            right: 48,
                            top: 17,
                          ),
                          child: Text(
                            pages[index].description,
                            style: TextStyle(
                              color: Colors.lightGreenAccent,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ), offset: Offset(0, 120),
                      ),
                    ],
                  ),
                ],
              );
            },
            itemCount: pages.length,
            onPageChanged: (index) {
              _pageViewNotifier.value = index;
            },
          ),
        ),
        Transform.translate(
          offset: Offset(0, 280),
          child: Align(
            alignment: Alignment.center,
            child: _displayPageIndicators(
              pages.length,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 24,
              left: 16,
              right: 16,
            ),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: RaisedButton(
                color: Colors.red.shade800,
                child: Text(
                  'GET STARTED',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    letterSpacing: 1,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context){
                        _updateScreen();
                        return HomeScreen();
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _displayPageIndicators(int length) {
    return PageViewIndicator(
      pageIndexNotifier: _pageViewNotifier,
      length: length,
      normalBuilder: (animationController, index) => Circle(
        size: 8.0,
        color: Colors.grey,
      ),
      highlightedBuilder: (animationController, index) => ScaleTransition(
        scale: CurvedAnimation(
          parent: animationController,
          curve: Curves.ease,
        ),
        child: Circle(
          size: 12.0,
          color: Colors.red,
        ),
      ),
    );
  }

  void _updateScreen() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('seen' , true);
  }

}


