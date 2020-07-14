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
  bool isWidgetHidden = false;
  @override
  Widget build(BuildContext context) {
    return isWidgetHidden
        ? SizedBox()
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                for (var option in widget.list)
                  CheckboxListTile(
                    title: Text(option["text"].toString()),
                    onChanged: (bool value) {
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
                      if (widget.list
                          .every((element) => element["value"] == false)) {
                        setState(() => isHidden = false);
                      } else {
                        setState(() => isHidden = true);
                      }
                    },
                    value: option["value"],
                  ),
                isHidden
                    ? Container(
                        width: 300,
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
                              isWidgetHidden = true;
                            });
                            String value = widget.list
                                .where((element) => element["value"] == true)
                                .map((e) => e["text"])
                                .join(", ");
                            widget.notifyParent(value);
                          },
                          child: Text("Send"),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          );
  }
}
