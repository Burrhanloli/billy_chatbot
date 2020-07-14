import 'package:flutter/material.dart';

class MessageQuickReplies extends StatelessWidget {
  final List<dynamic> list;
  final Function notifyParent;

  MessageQuickReplies({this.list, this.notifyParent});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: 50,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
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
                  notifyParent(list[index]["text"].toString());
                },
                child: Text(
                  list[index]["text"].toString(),
                ),
              ),
            ),
          )),
    );
  }
}
