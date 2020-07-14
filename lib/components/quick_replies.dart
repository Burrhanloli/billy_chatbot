import 'package:flutter/material.dart';

class MessageQuickReplies extends StatefulWidget {
  final List<dynamic> list;
  final Function notifyParent;

  MessageQuickReplies({this.list, @required this.notifyParent});

  @override
  _MessageQuickRepliesState createState() => _MessageQuickRepliesState();
}

class _MessageQuickRepliesState extends State<MessageQuickReplies> {
  bool isHidden = false;

  @override
  Widget build(BuildContext context) {
    return isHidden
        ? SizedBox()
        : Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              height: 50,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.list.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: OutlineButton(
                    highlightedBorderColor: Colors.blue,
                    textColor: Colors.blue,
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    onPressed: () {
                      setState(() {
                        isHidden = true;
                      });
                      widget.notifyParent(widget.list[index]["text"].toString());
                    },
                    child: Text(
                      widget.list[index]["text"].toString(),
                    ),
                  ),
                ),
              )),
        );
  }
}
