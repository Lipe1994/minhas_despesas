import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:minhas_despesas/models/transaction.dart';

import 'chart_bar.dart';

class Chart extends StatelessWidget{
  final List<Transaction> recentTransactions;

  const Chart({Key key, this.recentTransactions}) : super(key: key);

  List<Map<String, Object>> get groupedTransactions{
    return List.generate(7, (index){

      final weekDay =DateTime.now().subtract(Duration(days: index));

      double total =0.0;

      for(var i = 0; i < recentTransactions.length; i++){
        bool sameDay = recentTransactions[i].date.day == weekDay.day;
        bool sameMonth = recentTransactions[i].date.month == weekDay.month;
        bool sameYear = recentTransactions[i].date.year == weekDay.year;

        if(sameDay && sameMonth && sameYear){
          total += recentTransactions[i].value;
        }
      }

        return {
          'day': DateFormat.E().format(weekDay)[0],
          'value': total
        }; 
    }).reversed.toList();
  }

  double get weekTotal{
    return groupedTransactions.fold(0.0, (acc, tr) => acc + tr['value']);
  }
  
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ...groupedTransactions.map((tr) => Flexible(fit: FlexFit.tight,child: ChartBar(percentage: weekTotal == 0 ? 0 : (tr['value'] as double)/weekTotal, label: tr['day'], value: tr['value'],)))
          ],
        ),
      ),
    );
  }
  
}