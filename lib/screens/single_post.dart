import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/models/post.dart';

@immutable
class SinglePost extends StatefulWidget {
  final Post post;

  const SinglePost(this.post, {super.key});

  @override
  _SinglePostState createState() => _SinglePostState();
}

class _SinglePostState extends State<SinglePost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300.0,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.post.featuredImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, position) {
                if (position == 0) {
                  return _drawPostDetails();
                } else if (position >= 1 && position < 24) {
                  return _comments();
                } else {
                  return _commentTextEntry();
                }
              },
              childCount: 25,
            ),
          ),
        ],
      ),
    );
  }

  Color getRandomColor({int minBrightness = 50}) {
    final random = Random();
    assert(minBrightness >= 0 && minBrightness <= 255);
    return Color.fromARGB(
      0xFF,
      minBrightness + random.nextInt(255 - minBrightness),
      minBrightness + random.nextInt(255 - minBrightness),
      minBrightness + random.nextInt(255 - minBrightness),
    );
  }

  Widget _drawPostDetails() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        widget.post.content,
        style: const TextStyle(
          fontSize: 18,
          letterSpacing: 1.2,
          height: 1.25,
        ),
      ),
    );
  }

  Widget _comments() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(widget.post.featuredImage),
              ),
              const SizedBox(
                width: 16,
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Christina"),
                  Text("1 hour"),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
              "Weasel the jeeper goodness inconsiderately spelled so ubiquitous amused knitted and altruistic amiable..."),
        ],
      ),
    );
  }

  Widget _commentTextEntry() {
    return Container(
      color: const Color.fromRGBO(241, 245, 247, 1),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              const Flexible(
                child: Padding(
                  padding: EdgeInsets.only(left: 16, bottom: 16),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Write Comment here!',
                      contentPadding: EdgeInsets.only(
                        left: 16,
                        top: 24,
                        bottom: 28,
                      ),
                    ),
                  ),
                ),
              ),
              FlatButton(
                child: const Text(
                  'SEND',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                onPressed: () {},
              )
            ],
          ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}

FlatButton({required Null Function() onPressed, required Text child}) {}
