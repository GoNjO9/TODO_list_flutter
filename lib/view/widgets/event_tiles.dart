import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_g9/view_model/event_view_model.dart';

class EventTiles extends StatelessWidget {
  const EventTiles({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EventViewModel>(builder: (context, eventVM, child) {
      if (eventVM.items != null) {
        if (eventVM.items!.isNotEmpty) {
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
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(eventVM.items![index].name),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(eventVM.items![index].date),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(eventVM.items![index].note),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          eventVM.removeEvent(index); //delete event
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
        }
      }
      return const Center(
        child: Text('Add some new events...'),
      );
    });
  }
}
