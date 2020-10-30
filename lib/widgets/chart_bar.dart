import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercentOfTotal;

  //GET THE VALUE OF EACH VARIABLE TO CREATE THE BAR
  ChartBar(this.label, this.spendingAmount, this.spendingPercentOfTotal);

  @override
  Widget build(BuildContext context) {
    return Column(children: [                                                   //COLUMN OF LABEL, BAR, DAY
      Container(
        height: 20,
        child: FittedBox(
            child: Text("Rs ${spendingAmount.toStringAsFixed(0)}")              //SHOW THE TEXT OF TOTAL AMOUNT SPENT ON THAT DAY
        ),
      ),
      SizedBox(height: 5,),                                                     //GIVES SPACE BETWEEN BAR AND TEXT
      Container(
        height: 120,
        width: 10,
        child: Stack(children: [                                                //USED AS RELATIVE LAYOUT TO PUT ONE ITEM OVER ANOTHER ITEM
          Container(
            decoration: BoxDecoration(                                          //CREATE THE BLANK ROUNDED BOX
                border: Border.all(color: Colors.grey, width: 1),
                color: Color.fromRGBO(220, 220, 220, 1),
                borderRadius: BorderRadius.circular(10),
            ),
          ),
          FractionallySizedBox(
            heightFactor: spendingPercentOfTotal,                               //GIVES THE HEIGHT IN FRACTION
            child: Container(                                                   //ALWAYS PUT IT INSIDE A CONTAINER BECAUSE BOX CONTAINER IS NOT WIDGET
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
      ],),),
      SizedBox(height: 4,),                                                     //GIVES SPACE IN BETWEEN
      Text(label),                                                              //TEXT FOR DAY NAME'S FIRST LETTER
    ],);
  }
}
