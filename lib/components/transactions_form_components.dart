import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String title, double value, DateTime date) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();
  DateTime date;

  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;

    if(title.isEmpty || value <= 0 || date == null ){
      return;
    }
      widget.onSubmit(title, value, date);
  }

  _showDatePicker(){
    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2019), lastDate: DateTime.now())
      .then((dt){
        if(dt == null){
          return;
        }
        setState(() {
          date = dt;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          TextField(
              onSubmitted:(_) => _submitForm(),
              controller: titleController,
              decoration: InputDecoration(labelText: 'insira um titulo')),
          TextField(
              onSubmitted:(_) => _submitForm(),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: valueController,
              decoration: InputDecoration(labelText: 'insira um valor em R\$')),
          Row(
            children: <Widget>[
              Flexible(fit: FlexFit.tight, child: date == null ? Text('Nenhuma data selecionada!') : Text('Data selecionada: ${DateFormat('dd/MM/yyyy').format(date)}')),
              FlatButton(onPressed: _showDatePicker, child: Text('Selecione uma data', style:Theme.of(context).textTheme.button,))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              RaisedButton(
                color: Theme.of(context).primaryColor,
                  onPressed: () {
                     _submitForm();
                  },
                  child: Text(
                    'Nova Tranção',
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          )
        ],
      ),
    ));
  }
}
