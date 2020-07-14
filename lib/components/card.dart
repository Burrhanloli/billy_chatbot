import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MessageCard extends StatelessWidget {
  final dynamic message;

  const MessageCard({this.message});

  @override
  Widget build(BuildContext context) {
    launchURL(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Padding(
        padding: EdgeInsets.all(5.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(message["text"].toString(),
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold)),
                ),
                Divider(
                  height: 5.0,
                  color: Colors.blue,
                ),
                FlatButton(
                  onPressed: () => launchURL(message["href"].toString()),
                  child: Text(message["buttonText"].toString(),
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
        ));
  }
}
