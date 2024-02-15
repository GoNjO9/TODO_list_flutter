import 'package:flutter/material.dart';

class EventAddingSheet extends StatefulWidget {
  const EventAddingSheet({super.key});

  @override
  State<EventAddingSheet> createState() => _EventAddingSheetState();
}

class _EventAddingSheetState extends State<EventAddingSheet> {
  late TextEditingController item1Controller; //name
  late TextEditingController item2Controller; //date
  late TextEditingController item3Controller; //note

  @override
  void initState() {
    super.initState();
    item1Controller = TextEditingController(); //initialize controllers
    item2Controller = TextEditingController();
    item3Controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    item1Controller.dispose(); //還不知道這是在做啥
    item2Controller.dispose();
    item3Controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 40,
        right: 40,
        top: 30,
      ),
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(labelText: 'Name'),
            controller: item1Controller, //use controller to get the input value
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Note'),
            controller: item3Controller,
          ),
          Row(
            children: <Widget>[
              Expanded(
                //if putting TextField directly to be the children of row, there will be some rendering problems
                child: TextField(
                  decoration: const InputDecoration(labelText: 'Deadline'),
                  controller: item2Controller,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.date_range,
                  color: Colors.black,
                ),
                onPressed: () async {
                  final result = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2023, 11),
                    lastDate: DateTime(2100, 12),
                  );
                  if (result != null) {
                    item2Controller.text =
                        "${result.year}-${result.month}-${result.day}";
                  }
                },
              ),
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                  onPressed: () {
                    if (item1Controller.text.isEmpty) {
                      //if user didn't fill in the event name, dialog jump out and won't submit
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const AlertDialog(
                            title: Text('Warning'),
                            content: Text('Event name can\'t be empty'),
                          );
                        },
                      );
                    } else {
                      submit();
                    }
                  },
                  child: const Text('SUBMIT')),
            ),
          )
        ],
      ),
    );
  }

  void submit() {
    if (item1Controller.text.isEmpty) {
      item1Controller.text = 'new event';
    }
    if (item2Controller.text.isEmpty) {
      item2Controller.text =
          'no deadline'; //default value if user didn't key in the deadline
    }
    if (item3Controller.text.isEmpty) {
      item3Controller.text = ' ';
    }
    Navigator.of(context).pop({
      //return the input in the Text field
      'name': item1Controller.text,
      'date': item2Controller.text,
      'note': item3Controller.text,
    });
    item1Controller.clear();
    item2Controller.clear();
    item3Controller.clear();
  }
}
