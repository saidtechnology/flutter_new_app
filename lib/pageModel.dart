import "package:flutter/material.dart";

class PageModel {
  final String _title;
  final String _description;
  final String _image;
  final IconData _icon;

  PageModel(this._title, this._description, this._image, this._icon);

  // Getting Data ..
  IconData get icon => _icon;

  String get image => _image;

  String get description => _description;

  String get title => _title;
}
