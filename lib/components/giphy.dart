import 'package:flutter/material.dart';

class MessageGiphy extends StatelessWidget {
  final String link;

  const MessageGiphy({this.link});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Image.network(
            link,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
