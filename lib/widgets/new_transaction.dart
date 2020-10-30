import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();                              //BEST USE TO TAKE INPUT FROM USER
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void submitData(){
    if(_amountController.text.isEmpty){
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if(enteredTitle.isEmpty || enteredAmount <= 0){                             //WHEN SUBMIT IS CALLED IF BOTH FIELD NOT EMPTY THEN SAVE ELSE EXIT
      return;
    }
    widget.addTx(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();                                                //CLOSE THE FORM AFTER TAKING THE INPUT
  }

  //OPEN A DATE PICKER WINDOW TO SELECT DATE FROM, FIRSTDATE MEANS- DATE TILL 2020 ONLY AND NOT BEFORE THAT
  //LASTDATE MEANS- CANNOT SELECT FUTURE DATES
  void _datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {                                                       //IT GETS TRIGGERED WHEN A DATE IS SELECTED
      if(pickedDate == null){
        return;
      }
      setState(() {
        _selectedDate = pickedDate;                                             //SETS THE CURRENT DATE TO SELECTED DATE
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Title"),                  //DISPLAY HINT OF TITLE
              controller: _titleController,
              onSubmitted: (_) => submitData(),                                 //AFTER TAKING INPUT IT WILL BE TRIGGERED
              //onChanged: (val) => titleInput = val,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),                                 //AFTER TAKING INPUT IT WILL BE TRIGGERED
              //onChanged: (val) => amountInput = val,
            ),
            Container(
              height: 80,
              child: Row(
                children: [
                  Expanded(
                    child: Text("Picked Date: ${DateFormat.yMd().format(_selectedDate)}"),
                  ),
                  FlatButton(
                      onPressed: _datePicker,
                      child: Text(
                          "Choose Date",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor,),
                      ),
                  )
                ],
              ),
            ),
            RaisedButton(
              child: Text("Add Item", style: TextStyle(fontWeight: FontWeight.normal),),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: submitData,                                            //IT WILL BE TRIGGERED WHEN USER SUBMIT
            )
          ],
        ),
      ),
    );
  }
}
