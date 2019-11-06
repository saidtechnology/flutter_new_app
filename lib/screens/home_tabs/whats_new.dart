import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:news_app/api/posts_api.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:news_app/models/post.dart';

class WhatsNew extends StatefulWidget {
  @override
  _WhatsNewState createState() => _WhatsNewState();
}

class _WhatsNewState extends State<WhatsNew> {
  PostsAPI postsAPI = PostsAPI();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _drawHeader(),
          _drawTopStories(),
          _drawRecentUpdates(),
        ],
      ),
    );
  }

  Widget _drawHeader() {
    TextStyle _headerTitle = TextStyle(
        color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600);
    TextStyle _headerDescription = TextStyle(
      color: Colors.white,
      fontSize: 18,
    );

    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: MediaQuery
          .of(context)
          .size
          .height * 0.25,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: ExactAssetImage('assets/images/placeholder_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 48, right: 48),
              child: Text(
                'How Terriers & Royals Gatecrashed Final',
                style: _headerTitle,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 34, right: 34),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.',
                style: _headerDescription,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawTopStories() {
    return Container(
      color: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16),
            child: _drawSectionTitle('Top Stories'),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              child: FutureBuilder(
                  future: postsAPI.fetchWhatsNew(),
                  builder: (context, AsyncSnapshot snapShot) {
                    return _dataGetter(snapShot);
                  }
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _drawRecentUpdates() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: FutureBuilder(
        future: postsAPI.fetchRecentUpdates(),
        builder: (context, AsyncSnapshot snapShot) {
          return _dataUpdater(snapShot);
        },
      ),
    );
  }

  Widget _drawDivider() {
    return Container(
      color: Colors.teal,
      height: 1,
      width: double.infinity,
    );
  }

  Widget _drawSingleRow(Post post) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            child: Image.network(
              post.featuredImage,
              fit: BoxFit.cover,
            ),
            width: 124,
            height: 124,
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Text(
                  post.title,
                  maxLines: 2,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 18,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Michael Adams'),
                    Row(
                      children: <Widget>[
                        Icon(Icons.timer),
                        Text(_parseHumanDateTime(post.dateWritten)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _parseHumanDateTime(String dateTime) {
    Duration timeAgo = DateTime.now().difference(DateTime.parse(dateTime));
    DateTime theDifference = DateTime.now().subtract(timeAgo);
    return timeago.format(theDifference);
  }

  Widget _drawSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
          color: Colors.grey.shade700,
          fontWeight: FontWeight.w600,
          fontSize: 16),
    );
  }

  Widget _drawRecentUpdatesCard(Color color , Post post) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(post.featuredImage, ),
                fit: BoxFit.cover,
              ),
            ),
            width: double.infinity,
            height: MediaQuery
                .of(context)
                .size
                .height * 0.25,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 16),
            child: Container(
              padding: EdgeInsets.only(left: 24, right: 24, top: 2, bottom: 2),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'SPORT',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
            child: Text(
              post.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 16),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.timer,
                  color: Colors.grey,
                  size: 18,
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  _parseHumanDateTime(post.dateWritten),
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dataUpdater(AsyncSnapshot snapShot ) {

    switch (snapShot.connectionState) {
      case ConnectionState.waiting:
        return _loading();
        break;
      case ConnectionState.active:
        return _loading();
        break;
      case ConnectionState.none:
        return _connectionError();
        break;
      case ConnectionState.done:
        if (snapShot.hasError) {
          return _error(snapShot.error);
        } else {
          Post post1 = snapShot.data[0];
          Post post2 = snapShot.data[1];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 8, top: 8),
                child: _drawSectionTitle('Recent Updates'),
              ),
              _drawRecentUpdatesCard(Colors.deepOrange , post1),
              _drawRecentUpdatesCard(Colors.teal, post2),
              SizedBox(
                height: 48,
              ),
            ],
          );
        }
        break;
    }
  }

  Widget _dataGetter(AsyncSnapshot snapShot) {
    switch (snapShot.connectionState) {
      case ConnectionState.waiting:
        return _loading();
        break;
      case ConnectionState.active:
        return _loading();
        break;
      case ConnectionState.none:
        return _connectionError();
        break;
      case ConnectionState.done:
        if (snapShot.error != null) {
          return _error(snapShot.error);
        } else {
          if (snapShot.hasData) {
            List<Post> posts = snapShot.data;
            if (posts.length >= 3) {
              Post post1 = snapShot.data[0];
              Post post2 = snapShot.data[1];
              Post post3 = snapShot.data[2];
              return Column(
                children: <Widget>[
                  _drawSingleRow(post1),
                  _drawDivider(),
                  _drawSingleRow(post2),
                  _drawDivider(),
                  _drawSingleRow(post3),
                ],
              );
            } else {
              return _noData();
            }
          } else {
            return _noData();
          }
        }
        break;
    }
  }

  Widget _loading() {
    return Container(
      padding: EdgeInsets.only(top: 16, bottom: 16),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _connectionError() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Text('Connection Error !!!!'),
    );
  }

  Widget _error(var error) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Text(error.toString()),
    );
  }

  Widget _noData() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Text('No Data Available!'),
    );
  }

}