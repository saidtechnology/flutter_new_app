import 'package:flutter/material.dart';
import 'package:news_app/shared_ui/navigation_drawer.dart' as NavigationDrawer;

class TwitterFeed extends StatefulWidget {
  const TwitterFeed({super.key});

  @override
  _TwitterFeedState createState() => _TwitterFeedState();
}

class _TwitterFeedState extends State<TwitterFeed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Twitter Feed'),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      drawer: const NavigationDrawer.NavigationDrawer(),
      body: ListView.builder(
        itemBuilder: (context, position) {
          return Padding(
            padding: const EdgeInsets.only(right: 8, top: 8, left: 8),
            child: Card(
              child: Column(
                children: <Widget>[
                  _cardHeader(),
                  _cardBody(),
                  _cardFooter(),
                ],
              ),
            ),
          );
        },
        itemCount: 20,
      ),
    );
  }

  Widget _cardHeader() {
    return const Padding(
      padding: EdgeInsets.only(
        left: 16,
        top: 16,
        right: 16,
      ),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: CircleAvatar(
              backgroundColor: Colors.purple,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'Christina Meyers ',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    '@ch_meyers',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Text('Fri 12 May 2017 '),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                      '.',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(' 14.30'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _cardBody() {
    return const Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: 16,
              bottom: 25,
            ),
            child: Text(
              'We also talk about the future of work as the robots advance, and we ask whether a retro phone',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardFooter() {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.grey.shade300,
          height: 1,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.repeat,
                      size: 35,
                      color: Colors.orange,
                    ),
                    onPressed: () {},
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      '25',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  FlatButton(
                    onPressed: () {},
                    child: const Text(
                      'SHARE',
                      style: TextStyle(
                        color: Colors.orange,
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: const Text(
                      'OPEN',
                      style: TextStyle(
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

FlatButton({required Null Function() onPressed, required Text child}) {}
