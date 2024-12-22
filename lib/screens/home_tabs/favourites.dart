import 'dart:math';
import 'package:flutter/material.dart';
import 'package:news_app/api/posts_api.dart';
import 'package:news_app/models/post.dart';
import 'package:news_app/screens/single_post.dart';
import 'package:news_app/utilities/data_utilities.dart';

class Favourites extends StatefulWidget {
  const Favourites({super.key});

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  PostsAPI postsAPI = PostsAPI();
  List<int> ids = [0, 1, 5];

  List<Color> colorsList = [
    Colors.red,
    Colors.teal,
    Colors.deepOrange,
    Colors.indigo,
    Colors.brown,
    Colors.purple
  ];

  Random random = Random();

  Color _getRandomColor() {
    return colorsList[random.nextInt(colorsList.length)];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: postsAPI.fetchPostsByCategoryId("1"),
      builder: (context, AsyncSnapshot snapshot) {
        return _favouritesCart(snapshot);
      },
    );
  }

  Widget _favouritesCart(AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.waiting:
        return loading();
      case ConnectionState.active:
        return loading();
      case ConnectionState.none:
        return connectionError();
      case ConnectionState.done:
        if (snapshot.hasError) {
          return error(snapshot.error);
        } else {
          List<Post> posts = snapshot.data;
          return ListView.builder(
            itemBuilder: (context, position) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SinglePost(posts[position]);
                      },
                    ),
                  );
                },
                child: Card(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: <Widget>[
                        _authorRow(position, posts[position]),
                        const SizedBox(
                          height: 16,
                        ),
                        _newsItemRow(posts[position]),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: posts.length,
          );
        }
    }
  }

  Widget _authorRow(int position, Post post) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(post.featuredImage), fit: BoxFit.cover),
                shape: BoxShape.circle,
              ),
              width: 50,
              height: 50,
              margin: const EdgeInsets.only(right: 16),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Michael Adams',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      parseHumanDateTime(post.dateWritten),
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      ' User Id : ${post.id}',
                      style: TextStyle(
                        color: _getRandomColor(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        IconButton(
          icon: (ids.contains(position))
              ? const Icon(Icons.bookmark)
              : const Icon(Icons.bookmark_border),
          color: (ids.contains(position)) ? Colors.red : Colors.grey,
          onPressed: () {
            setState(() {
              if (ids.contains(position)) {
                ids.remove(position);
              } else {
                ids.add(position);
              }
            });
          },
        ),
      ],
    );
  }

  Widget _newsItemRow(Post post) {
    return Row(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(post.featuredImage), fit: BoxFit.cover),
          ),
          width: 124,
          height: 124,
          margin: const EdgeInsets.only(right: 16),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Text(
                post.title,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                post.content,
                maxLines: 4,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  height: 1.25,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
