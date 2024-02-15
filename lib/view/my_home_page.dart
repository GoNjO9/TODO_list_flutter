import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_g9/view_model/event_view_model.dart';
import 'package:todo_list_g9/view_model/user_view_model.dart';
import 'dart:async';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  Future<Map<String, dynamic>?> showBottomSheet() => showModalBottomSheet(
        //evnet adding area
        context: context,
        builder: (BuildContext context) {
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
                  controller:
                      item1Controller, //use controller to get the input value
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
                        decoration:
                            const InputDecoration(labelText: 'Deadline'),
                        controller: item2Controller,
                      ),
                    ),
                    SizedBox(
                      child: IconButton(
                        // so as iconButton
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
        },
      );
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

  @override
  Widget build(BuildContext context) {
    return Consumer2<EventViewModel, UserViewModel>(
      builder: (context, eventVM, userVM, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(221, 255, 223, 118),
          title: Text(widget.title),
          actions: <Widget>[
            if (userVM.user == null)
              ElevatedButton(
                onPressed: () => {userVM.signInWithGoogle()},
                child: const Text('Login'),
              )
            else
              ElevatedButton(
                onPressed: () => {userVM.signOut()},
                child: const Text('Logout'),
              )
          ],
        ),
        body: Builder(
          builder: (context) {
            if (eventVM.items != null) {
              return ListView.separated(
                itemCount: eventVM.items!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      top: 3,
                      bottom: 3, //上下左間距
                    ),
                    child: ListTile(
                      title: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(eventVM.items![index].name),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(eventVM.items![index].date),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(eventVM.items![index].note),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                eventVM.removeEvent(index); //delete event
                              });
                            },
                          ),
                          const Divider(),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    const Divider(), //draw some seperate lines between events(?)
              );
            } else {
              return const Center(
                child: Text('Add some new events...'),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final map1 = await showBottomSheet(); //waiting for the input
            eventVM.addEvent(map1?['name'], map1?['date'], map1?['note']);
          },
          tooltip: 'Add an event',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
