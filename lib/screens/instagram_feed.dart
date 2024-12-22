import 'package:flutter/material.dart';
import '../shared_ui/navigation_drawer.dart' as NavigationDrawer;

class InstagramFeeds extends StatefulWidget {
  const InstagramFeeds({super.key});

  @override
  _InstagramFeedsState createState() => _InstagramFeedsState();
}

class _InstagramFeedsState extends State<InstagramFeeds> {
  late List<int> ids;

  @override
  void initState() {
    super.initState();
    ids = [0, 3, 7];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instagram Feeds'),
        centerTitle: false,
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ],
      ),
      drawer: NavigationDrawer.NavigationDrawer(),
      body: ListView.builder(
        itemBuilder: (context, position) {
          return Padding(
            padding: const EdgeInsets.only(
              right: 8,
              top: 8,
              left: 8,
            ),
            child: Card(
              child: Column(
                children: <Widget>[
                  _headerDrawer(position),
                  _bodyDrawer(),
                  _footerDrawer(),
                ],
              ),
            ),
          );
        },
        itemCount: 20,
      ),
    );
  }

  Widget _headerDrawer(int position) {
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
                onPressed: () {
                  if (ids.contains(position)) {
                    ids.remove(position);
                  } else {
                    ids.add(position);
                  }
                  setState(() {});
                },
                color: (ids.contains(position))
                    ? Colors.red
                    : Colors.grey.shade400,
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

  Widget _bodyDrawer() {
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

  Widget _footerDrawer() {
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
            child: const Text(
              '10 COMMENTS',
              style: TextStyle(
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
