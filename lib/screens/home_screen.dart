import 'package:flutter/material.dart';
import 'package:news_app/api/authors_api.dart';
import 'package:news_app/screens/pages/about.dart';
import 'package:news_app/screens/pages/contact.dart';
import 'package:news_app/screens/pages/help.dart';
import 'package:news_app/screens/pages/settings.dart';
import 'package:news_app/shared_ui/navigation_drawer.dart' as NavigationDrawer;
import 'home_tabs/whats_new.dart';
import 'home_tabs/popular.dart';
import 'home_tabs/favourites.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

enum PopOutMenu {
  HELP,
  ABOUT,
  CONTACT,
  SETTINGS,
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  AuthorsAPI authorsApi = AuthorsAPI();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    authorsApi.fetchAllAuthors();

    return Scaffold(
      appBar: AppBar(
        title: Text('Explore'),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          _popOutMenu(context),
        ],
        bottom: TabBar(
          indicatorColor: Colors.white,
          tabs: <Widget>[
            Tab(
              text: "WHAT'S NEW",
            ),
            Tab(
              text: "POPULAR",
            ),
            Tab(
              text: "FAVOURITES",
            ),
          ],
          controller: _tabController,
        ),
      ),
      drawer: NavigationDrawer.NavigationDrawer(),
      body: Center(
        child: TabBarView(
          children: <Widget>[
            WhatsNew(),
            Popular(),
            Favourites(),
          ],
          controller: _tabController,
        ),
      ),
    );
  }

  Widget _popOutMenu(BuildContext context) {
    return PopupMenuButton<PopOutMenu>(
      icon: Icon(Icons.more_vert),
      itemBuilder: (context) {
        return [
          PopupMenuItem<PopOutMenu>(
            value: PopOutMenu.ABOUT,
            child: Text('ABOUT'),
          ),
          PopupMenuItem<PopOutMenu>(
            value: PopOutMenu.HELP,
            child: Text('HELP'),
          ),
          PopupMenuItem<PopOutMenu>(
            value: PopOutMenu.CONTACT,
            child: Text('CONTACT'),
          ),
          PopupMenuItem<PopOutMenu>(
            value: PopOutMenu.SETTINGS,
            child: Text('SETTINGS'),
          ),
        ];
      },
      onSelected: (PopOutMenu menu) {
        switch (menu) {
          case PopOutMenu.ABOUT:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return AboutUs();
                },
              ),
            );
            break;
          case PopOutMenu.CONTACT:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ContactUs();
                },
              ),
            );
            break;
          case PopOutMenu.SETTINGS:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Settings();
                },
              ),
            );
            break;
          case PopOutMenu.HELP:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Help();
                },
              ),
            );
            break;
        }
      },
    );
  }
}
