import 'package:billy_chatbot/pages/home_page.dart';
import 'package:billy_chatbot/util/storage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(
      storage: Storage(),
    ),
    themeMode: ThemeMode.system,
    darkTheme: ThemeData.dark(),
    theme: ThemeData.light(),
    debugShowCheckedModeBanner: false,
  ));
}
