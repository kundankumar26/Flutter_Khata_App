import 'package:flutter/material.dart';
import 'package:flutter_second_app/widgets/new_transaction.dart';
import 'package:flutter_second_app/widgets/transaction_list.dart';
import 'package:flutter_second_app/widgets/user_transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter App 2"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          Container(
            width: double.infinity,
            child: Card(
              child: Text("chart"),
              color: Colors.blue,
              elevation: 5,
            ),
          ),
          UserTransactions(),
        ],),
      ),
    );
  }
}
