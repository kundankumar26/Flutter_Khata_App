import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_second_app/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);                                           //CONSTRUCTOR TO CALL THE TRANSACTION LIST

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty ? Column(                                     //IF TX LIST EMPTY SHOW NO TRANSACTION IMAGE
        children: [
          Text(
            "No transactions yet",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(                                                             //FIX HEIGHT AS 30 TO SHOW SOME SPACES BETWEEN TEXT AND IMAGE
            height: 30,
          ),
          Container(
            height: 40,                                                         //SET IMAGE SIZE
            child: Image.asset("assets/images/noStopping.png", fit: BoxFit.cover,)
          ),
        ],
      ) :
      ListView.builder(                                                         //BUILD THE LISTVIEW (SAME AS RECYCLER VIEW)
        itemCount: transactions.length,
        itemBuilder: (ctx, index) {                                             //GIVES TWO VALUES (CONTEXT AND CURRENT INDEX)
          return Card(
            elevation: 2,
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),          //ADD MARGIN
            child: ListTile(                                                    //CREATES EACH LIST ITEM
              leading: CircleAvatar(                                            //FOR CIRCLE
                radius: 30,
                child: Padding(                                                 //ADD PADDING FOR CIRCLE INSIDE DATA
                  padding: EdgeInsets.all(5),
                  child: FittedBox(                                             //TO FIT SMALL AND BIG NUMBERS
                    child: Text("${transactions[index].amount}"),
                  ),
                ),
              ),
              title: Text(transactions[index].title, style: Theme.of(context).textTheme.title,),      //GIVES TITLE
              subtitle: Text(DateFormat.yMMMd().format(transactions[index].date)),                    //GIVES DATE FORMATTED BY MONTH, DAY YEAR
              trailing: IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => deleteTx(transactions[index].id),
              ),
            )
          );
        }),
    );
  }
}





//
// Row(
// children: <Widget>[
// Container(
// child: Text(
// "Rs ${transactions[index].amount.toStringAsFixed(2)}", //Can be used in place of tx.amount.tostring()
// style: TextStyle(
// fontWeight: FontWeight.bold,
// fontSize: 18,
// color: Theme.of(context).primaryColor
// ),
// ),
// margin: EdgeInsets.symmetric(
// vertical: 10,
// horizontal: 10,
// ),
// decoration: BoxDecoration(
// border: Border.all(
// color: Theme.of(context).primaryColor,
// width: 2
// ),
// ),
// padding: EdgeInsets.all(10),
// ),
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: <Widget>[
// Text(
// transactions[index].title,
// style: TextStyle(
// fontSize: 16,
// fontWeight: FontWeight.bold,
// color: Colors.black54
// ),
// ),
// Text(
// DateFormat.yMMMd().format(transactions[index].date),
// style: TextStyle(fontSize: 12,),
// ),
// ]
// ),
// ]
// ),
