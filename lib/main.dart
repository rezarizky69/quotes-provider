import 'package:flutter/material.dart';
import 'package:flutter_quotes_provider/viewmodel/home_provider.dart';
import 'package:flutter_quotes_provider/views/homepage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<QuotesProvider>(
      create: (_) => QuotesProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
