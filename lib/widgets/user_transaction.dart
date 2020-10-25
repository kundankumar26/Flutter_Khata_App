import 'package:flutter/cupertino.dart';
import 'package:flutter_second_app/models/transaction.dart';
import 'package:flutter_second_app/widgets/new_transaction.dart';
import 'package:flutter_second_app/widgets/transaction_list.dart';
import 'package:intl/intl.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransaction = [
    Transaction(id: "t1", title: "New Books", amount: 19.50, date: DateTime.now()),
    Transaction(id: "t2", title: "New House", amount: 90.00, date: DateTime.now())
  ];
  void _addNewTransaction(String titleTx, double amountTx){
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: titleTx,
        amount: amountTx,
        date: DateTime.now()
    );

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(_addNewTransaction),
        TransactionList(_userTransaction)
      ],
    );
  }
}
