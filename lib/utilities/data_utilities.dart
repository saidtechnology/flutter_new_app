import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

Widget loading() {
  return Container(
    padding: const EdgeInsets.only(top: 16, bottom: 16),
    child: const Center(
      child: CircularProgressIndicator(),
    ),
  );
}

Widget connectionError() {
  return Container(
    padding: const EdgeInsets.all(16),
    child: const Text('Connection Error !!!!'),
  );
}

Widget error(var error) {
  return Container(
    padding: const EdgeInsets.all(16),
    child: Text(error.toString()),
  );
}

Widget noData() {
  return Container(
    padding: const EdgeInsets.all(16),
    child: const Text('No Data Available!'),
  );
}

String parseHumanDateTime(String dateTime) {
  Duration timeAgo = DateTime.now().difference(DateTime.parse(dateTime));
  DateTime theDifference = DateTime.now().subtract(timeAgo);
  return timeago.format(theDifference);
}

TextStyle headerTitle = const TextStyle(
    color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600);
TextStyle headerDescription = const TextStyle(
  color: Colors.white,
  fontSize: 18,
);
