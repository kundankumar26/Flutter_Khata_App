import 'package:flutter/material.dart';
import 'package:flutter_second_app/widgets/chart.dart';
import 'package:flutter_second_app/widgets/new_transaction.dart';
import 'package:flutter_second_app/widgets/transaction_list.dart';
import 'package:google_fonts/google_fonts.dart';


import 'models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Khata App",
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Colors.green,
        textTheme: ThemeData.light().textTheme.copyWith(
          button: TextStyle(color: Colors.white),
        ),
        // textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
        // appBarTheme: AppBarTheme(
        //   textTheme: ThemeData.light().textTheme.copyWith(
        //     title: TextStyle(
        //       fontWeight: FontWeight.bold,
        //     )
        //   )
        // )
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyHomePage> {

  //STORES ALL THE TRANSACTIONS
  final List<Transaction> _userTransaction = [
    //ransaction(id: "t1", title: "New Books", amount: 19.50, date: DateTime.now()),
    //Transaction(id: "t2", title: "New House", amount: 90.00, date: DateTime.now())
  ];

  //GET THE RECENT TRANSACTION OF PREVIOUS 7 DAYS
  List<Transaction> get _recentTransaction {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(                                                   //RETURN ONLY THOSE TX WHICH HAPPENED IN LAST 7 DAYS
        DateTime.now().subtract(Duration(days: 7)),                             //CALCULATE THE DATE OF CURRENT - 7 DAYS BACK
      );
    }).toList();
  }

  //ADD A NEW TRANSACTION TO THE USER TX LIST
  void _addNewTransaction(String titleTx, double amountTx, DateTime dateTx){
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: titleTx,
        amount: amountTx,
        date: dateTx
    );

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  //DELETE A TRANSACTION
  void _deleteTransaction(String id){
    setState(() {
      _userTransaction.removeWhere((item) => item.id == id);
    });
  }

  //OPEN THE FORM TO ENTER THE DETAILS
  void _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Flutter App 2"),
          actions: [
            Builder(
                builder: (context) => IconButton(                               //CREATE ADD TX BUTTON IN APP BAR
                  icon: Icon(Icons.add, color: Colors.white,),
                  onPressed: () => _startAddNewTransaction(context),
                )
            )
          ],
        ),
        body: SingleChildScrollView(                                            //CREATE SCROLLVIEW OF THE LIST
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,                     //USED FOR NUMBER OF ITEMS
            children: [
            Chart(_recentTransaction),                                          //CREATE THE CHART
            TransactionList(_userTransaction, _deleteTransaction),                                  //CREATE THE TX LIST
          ],),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, //CREATE ADD NEW BUTTON IN MIDDLE
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            onPressed: () => _startAddNewTransaction(context),
            child: Icon(Icons.add),
          ),
        )
      ),
    );
  }
}
