import 'package:flutter/material.dart';
import 'package:news_app/shared_ui/navigation_drawer.dart' as NavigationDrawer;

class FacebookFeeds extends StatefulWidget {
  const FacebookFeeds({super.key});

  @override
  _FacebookFeedsState createState() => _FacebookFeedsState();
}

class _FacebookFeedsState extends State<FacebookFeeds> {
  List<int> ids1 = List<int>.empty();
  List<int> ids2 = List<int>.empty();

  @override
  void initState() {
    super.initState();
    ids1 = [0, 3, 5];
    ids2 = [0, 1, 7];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Facebook Feeds'),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      drawer: NavigationDrawer.NavigationDrawer(),
      body: ListView.builder(
        itemBuilder: (context, position) {
          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Column(
                    children: <Widget>[
                      _headerDrawer(position, ids1),
                      _bodyFirstDrawer(),
                      _footerDrawer('10 COMMENTS'),
                    ],
                  ),
                ),
              ),
              Card(
                child: Column(
                  children: <Widget>[
                    _headerDrawer(position, ids2),
                    _bodySecondDrawer(),
                    _footerDrawer('12 COMMENTS'),
                  ],
                ),
              ),
            ],
          );
        },
        itemCount: 20,
      ),
    );
  }

  Widget _headerDrawer(int position, List idsList) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(right: 10, bottom: 7),
                child: CircleAvatar(
                  backgroundColor: Colors.deepOrange,
                  radius: 24,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Christina Meyers ',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                        color: Colors.grey.shade800),
                  ),
                  const Row(
                    children: <Widget>[
                      Text(
                        'Fri, 12 May 2017 ',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text(
                          '. ',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ),
                      Text(
                        '14.30',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
          Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.favorite),
                color: (idsList.contains(position))
                    ? Colors.red
                    : Colors.grey.shade400,
                onPressed: () {
                  setState(() {
                    if (idsList.contains(position)) {
                      idsList.remove(position);
                    } else {
                      idsList.add(position);
                    }
                  });
                },
              ),
              Text(
                '25',
                style: TextStyle(
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _bodyFirstDrawer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
          child: Text(
            'We also all about the future of work as the robots',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade800,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 16,
          ),
          child: Text(
            '#advance #retro #facebook',
            style: TextStyle(
              color: Colors.orangeAccent,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage(
                'assets/images/placeholder_bg.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.35,
        ),
      ],
    );
  }

  Widget _bodySecondDrawer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
          child: Text(
            'We also all about the future of work as the robots',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade800,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
          child: Text(
            'advance, and we ask whether a retro phone',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade800,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _footerDrawer(String text) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16,
        bottom: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlatButton(
            onPressed: () {},
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.orangeAccent,
              ),
            ),
          ),
          Row(
            children: <Widget>[
              FlatButton(
                onPressed: () {},
                child: const Text(
                  'SHARE',
                  style: TextStyle(
                    color: Colors.orangeAccent,
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {},
                child: const Text(
                  'OPEN',
                  style: TextStyle(
                    color: Colors.orangeAccent,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

FlatButton({required Null Function() onPressed, required Text child}) {}
