import 'package:flutter/material.dart';

class MessageOptions extends StatefulWidget {
  final List<dynamic> list;
  final Function notifyParent;

  MessageOptions({this.list, @required this.notifyParent});

  @override
  _MessageOptionsState createState() => _MessageOptionsState();
}

class _MessageOptionsState extends State<MessageOptions> {
  bool isHidden = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          for (var option in widget.list)
            CheckboxListTile(
              title: Text(option["text"].toString()),
              onChanged: (bool value) {
                handleChange(option, value);
              },
              value: option["value"],
            ),
          isHidden
              ? Container(
                  width: 300,
                  child: OutlineButton(
                    highlightedBorderColor: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).primaryColor,
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    onPressed: () {
                      String value = widget.list
                          .where((element) => element["value"] == true)
                          .map((e) => e["text"])
                          .join(", ");
                      widget.notifyParent(value, "OPTIONS");
                    },
                    child: Text("Send"),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }

  void handleChange(option, bool value) {
    if (option["type"] == "RADIO") {
      widget.list
          .where((element) => element["type"] == "CHECKBOX")
          .forEach((element) {
        setState(() => element["value"] = false);
      });
    } else {
      widget.list
          .where((element) => element["type"] == "RADIO")
          .forEach((element) {
        setState(() => element["value"] = false);
      });
    }
    setState(() => option["value"] = value);
    if (widget.list.every((element) => element["value"] == false)) {
      setState(() => isHidden = false);
    } else {
      setState(() => isHidden = true);
    }
  }
}
