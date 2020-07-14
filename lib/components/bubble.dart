import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final int data;
  final String message;
  MessageBubble({
    this.data,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Bubble(
          radius: Radius.circular(15.0),
          color: data == 0 ? Colors.blue : Colors.blueAccent,
          elevation: 0.0,
          alignment: data == 0 ? Alignment.topLeft : Alignment.topRight,
          nip: data == 0 ? BubbleNip.leftBottom : BubbleNip.rightTop,
          child: Padding(
            padding: EdgeInsets.all(2.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (data == 0)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/bot.png"),
                    ),
                  ),
                Flexible(
                  child: Text(
                    message,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                if (data == 1)
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/user.png"),
                    ),
                  ),
              ],
            ),
          )),
    );
  }
}
