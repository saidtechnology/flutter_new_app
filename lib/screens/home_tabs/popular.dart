import 'package:flutter/material.dart';
import 'package:news_app/api/posts_api.dart';
import 'dart:async';
import 'package:news_app/models/post.dart';
import 'package:news_app/utilities/data_utilities.dart';

class Popular extends StatefulWidget {
  @override
  _PopularState createState() => _PopularState();
}

class _PopularState extends State<Popular> {

  PostsAPI postsAPI = PostsAPI();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: postsAPI.fetchPostsByCategoryId("1"),
      builder: ( context, AsyncSnapshot snapShot ){
        return _dataGetter(snapShot);
      },
    );
  }

  Widget _drawSingleRow(Post post) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            child: Image(
              image: NetworkImage(post.featuredImage),
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
    );
  }

  Widget _dataGetter(AsyncSnapshot snapShot ) {
    switch (snapShot.connectionState) {
      case ConnectionState.waiting:
        return loading();
        break;
      case ConnectionState.active:
        return loading();
        break;
      case ConnectionState.none:
        return connectionError();
        break;
      case ConnectionState.done:
        if (snapShot.hasError) {
          return error(snapShot.error);
        } else {
          List<Post> posts = snapShot.data;

          return ListView.builder(
            itemBuilder: (context, position) {
              return Card(
                child: _drawSingleRow(posts[position]),
              );
            },
            itemCount: posts.length,
          );
        }
        break;
    }
  }


}
