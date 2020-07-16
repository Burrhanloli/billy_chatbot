import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MessageGiphy extends StatelessWidget {
  final String link;

  const MessageGiphy({this.link});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            height: 200,
            width: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: CachedNetworkImage(
                progressIndicatorBuilder: (context, url, progress) => Center(
                  child: CircularProgressIndicator(
                    value: progress.progress,
                  ),
                ),
                imageUrl: link,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
