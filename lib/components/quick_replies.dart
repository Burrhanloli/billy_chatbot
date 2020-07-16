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
                highlightedBorderColor: Theme.of(context).primaryColorDark,
                textColor: Theme.of(context).primaryColorDark,
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColorDark,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                onPressed: () {
                  notifyParent(list[index]["text"].toString(), "QUICK_REPLIES");
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
