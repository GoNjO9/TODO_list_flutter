import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_g9/view/widgets/event_adding_sheet.dart';
import 'package:todo_list_g9/view_model/event_view_model.dart';

class EventAddingButton extends StatefulWidget {
  const EventAddingButton({super.key});

  @override
  State<EventAddingButton> createState() => _EventAddingButtonState();
}

class _EventAddingButtonState extends State<EventAddingButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EventViewModel>(
      builder: (context, eventVM, child) => FloatingActionButton(
        onPressed: () async {
          final map1 = await showBottomSheet(); //waiting for the input
          eventVM.addEvent(map1?['name'], map1?['date'], map1?['note']);
        },
        tooltip: 'Add an event',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<Map<String, dynamic>?> showBottomSheet() => showModalBottomSheet(
        //event adding area
        context: context,
        builder: (BuildContext context) {
          return const EventAddingSheet();
        },
      );
}
