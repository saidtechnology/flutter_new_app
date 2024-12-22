import 'dart:math';
import 'package:flutter/material.dart';
import 'package:news_app/api/posts_api.dart';
import 'package:news_app/models/post.dart';
import 'package:news_app/screens/single_post.dart';
import 'package:news_app/utilities/data_utilities.dart';

class WhatsNew extends StatefulWidget {
  const WhatsNew({super.key});

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

  /// Group 1 : Draw Header Package.
  Widget _drawHeader() {
    return FutureBuilder(
      future: postsAPI.fetchPostsByCategoryId("1"),
      builder: (context, AsyncSnapshot snapShot) {
        return _dataDrawHeader(snapShot);
      },
    );
  }

  Widget _dataDrawHeader(AsyncSnapshot snapShot) {
    switch (snapShot.connectionState) {
      case ConnectionState.waiting:
        return loading();
      case ConnectionState.active:
        return loading();
      case ConnectionState.none:
        return connectionError();
      case ConnectionState.done:
        if (snapShot.hasError) {
          return error(snapShot.error);
          // ignore: missing_return
        } else {
          List<Post> posts = snapShot.data;
          Random random = Random();
          int randomIndex = random.nextInt(posts.length);
          Post post = posts[randomIndex];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SinglePost(post);
                  },
                ),
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(post.featuredImage),
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
                        post.title,
                        style: headerTitle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 34, right: 34),
                      child: Text(
                        post.content.substring(0, 50),
                        style: headerDescription,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    }
  }

  /// Group 2 : Draw Top Stories Package.
  Widget _drawTopStories() {
    return Container(
      color: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              top: 16,
            ),
            child: _drawSectionTitle('Top Stories'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: FutureBuilder(
                future: postsAPI.fetchPostsByCategoryId("2"),
                builder: (context, AsyncSnapshot snapShot) {
                  return _dataDrawSingleRow(snapShot);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.grey.shade700,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    );
  }

  Widget _dataDrawSingleRow(AsyncSnapshot snapShot) {
    switch (snapShot.connectionState) {
      case ConnectionState.waiting:
        return loading();
      case ConnectionState.active:
        return loading();
      case ConnectionState.none:
        return connectionError();
      case ConnectionState.done:
        if (snapShot.error != null) {
          return error(snapShot.error);
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
              return noData();
            }
          } else {
            return noData();
          }
        }
    }
  }

  Widget _drawSingleRow(Post post) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return SinglePost(post);
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: 124,
              height: 124,
              child: Image.network(
                post.featuredImage,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(
                    post.title,
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text('Michael Adams'),
                      Row(
                        children: <Widget>[
                          const Icon(Icons.timer),
                          Text(parseHumanDateTime(post.dateWritten)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
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

  /// Group 3 : Draw Recent Updates.
  Widget _drawRecentUpdates() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: FutureBuilder(
        future: postsAPI.fetchPostsByCategoryId("3"),
        builder: (context, AsyncSnapshot snapShot) {
          return _dataDrawRecentUpdatesCard(snapShot);
        },
      ),
    );
  }

  Widget _dataDrawRecentUpdatesCard(AsyncSnapshot snapShot) {
    switch (snapShot.connectionState) {
      case ConnectionState.waiting:
        return loading();
      case ConnectionState.active:
        return loading();
      case ConnectionState.none:
        return connectionError();
      case ConnectionState.done:
        if (snapShot.hasError) {
          return error(snapShot.error);
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
              _drawRecentUpdatesCard(Colors.deepOrange, post1),
              _drawRecentUpdatesCard(Colors.teal, post2),
              const SizedBox(
                height: 48,
              ),
            ],
          );
        }
    }
  }

  /// Call Draw Section Title.
  Widget _drawRecentUpdatesCard(Color color, Post post) {
    return Card(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return SinglePost(post);
              },
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    post.featuredImage,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.25,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16),
              child: Container(
                padding: const EdgeInsets.only(
                    left: 24, right: 24, top: 2, bottom: 2),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'SPORT',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 16, bottom: 8),
              child: Text(
                post.title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 8, bottom: 16),
              child: Row(
                children: <Widget>[
                  const Icon(
                    Icons.timer,
                    color: Colors.grey,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    parseHumanDateTime(post.dateWritten),
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
