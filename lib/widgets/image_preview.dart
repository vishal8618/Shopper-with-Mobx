import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImagePreview extends StatefulWidget {
  final String path;

  ImagePreview({this.path});

  @override
  _ImagePreviewState createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: PhotoView(
        imageProvider: NetworkImage(widget.path),
      ),
    );
  }
}
