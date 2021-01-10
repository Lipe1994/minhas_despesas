
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:minhas_despesas/components/chart.dart';
import 'package:minhas_despesas/models/transaction.dart';

import 'components/transactions_components.dart';
import 'components/transactions_form_components.dart';

main() => runApp(MyExpenses());

class MyExpenses extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Roboto',
        textTheme: TextTheme(
          button: TextStyle(
            color: Colors.purple,
            fontWeight: FontWeight.bold
          )
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )

        )
      ),
    );
  }
}

class Home extends StatefulWidget {


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final List<Transaction> _transactions = [
  ];

  List<Transaction> get _recentTransactions{
    return _transactions.where((tr) => tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)))).toList();
  }

  _addTransaction(String title, double value, DateTime dateTime){
    final newTransaction = Transaction(id: Random().nextDouble().toString(), title: title, value: value, date: dateTime);
    setState(() {
      _transactions.add(newTransaction);
    });
    Navigator.of(context).pop();
  }

  _deleteTransaction(String id){
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  openModalFormTransactions(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (_){return TransactionForm(_addTransaction);});
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('Minhas despesas'), actions: <Widget>[IconButton(icon: Icon(Icons.add), onPressed: ()=> openModalFormTransactions(context))]),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment:  MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(recentTransactions: _recentTransactions), 
            //TransactionForm(_addTransaction),    
            TransactionsComponents(transactions: _transactions, delete: _deleteTransaction),
        ]
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: ()=> openModalFormTransactions(context), child: Icon(Icons.add)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}