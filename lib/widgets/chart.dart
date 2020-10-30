import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_second_app/models/transaction.dart';
import 'package:flutter_second_app/widgets/chart_bar.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {

  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {

    //FIND ALL THE TXS IN LAST 7 DAYS
    return List.generate(7, (index){
      //IT FINDS THE DATE WHICH IS IN RANGE FROM CURRENT TO PREVIOUS 7 DAYS
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;

      //FIND TOTAL SUM OF EACH DAY FOR LAST 7 DAYS
      for(var i = 0; i < recentTransactions.length; i++){

        //CHECKS IF THE TX DATE IS SAME AS GENERATED DATE
        if(recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year){
          totalSum += recentTransactions[i].amount;
        }
      }

      //RETURNS DAY NAME WITH TOTAL AMOUNT SPENT ON THAT DAY
      return {
        "day": DateFormat.E().format(weekDay).substring(0, 1),
        "amount": totalSum};

      //RETURN THE REVERSE TO PUT THE CURRENT DAY IN LAST AND PREVIOUS 7TH DAY IN FIRST IN CHART
    }).reversed.toList();
  }

  //FINDS THE TOTAL AMOUNT SPENT IN THAT ENTIRE WEEK
  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];

    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(                                                                //CREATE A CARD FOR THE CHART
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,                     //DISTRIBUTE THE ITEMS EQUALLY INSIDE THE CHART
          children: groupedTransactionValues.map((data) {
            //return Text(data['day'].toString() + ' : ' + data['amount'].toString(),);
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  data['day'],
                  data['amount'],
                  //IF TOTAL AMOUNT SPENT IN THAT WEEK IS 0 THEN MAKE TOTAL SPENDING 0
                  totalSpending == 0.0 ? 0.0 : (data['amount'] as double) / totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
