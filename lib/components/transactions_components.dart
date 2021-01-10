import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:minhas_despesas/models/transaction.dart';

class TransactionsComponents extends StatelessWidget {
  final List<Transaction> transactions;

  final Function(String id) delete;

  const TransactionsComponents({Key key, this.transactions, this.delete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        child: transactions.isEmpty ? Container(child: Image.asset('assets/images/waiting.png'),) : ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (cxt, index) {
            final e = transactions[index];
            return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: FittedBox(child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text('R\$${e.value.toStringAsFixed(2)}'),
                  )),
                ),
                title: Text('${e.title}', style: Theme.of(context).textTheme.headline6,),
                subtitle: Text('${DateFormat('d MMM y').format(e.date)}'),
                trailing: GestureDetector(child: Icon(Icons.delete, color: Theme.of(context).errorColor,), onTap: ()=> delete(e.id)),
              )
            );
          },
        ));
  }
}
