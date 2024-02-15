import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_g9/view/widgets/custom_text.dart';
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
                          child: CustomText(
                            text: eventVM.items![index].name,
                            textColor: Colors.white,
                            textSize: 20,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: CustomText(
                            text: eventVM.items![index].date,
                            textColor: Colors.white,
                            textSize: 15,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: CustomText(
                            text: eventVM.items![index].note,
                            textColor: const Color.fromARGB(255, 192, 192, 192),
                            textSize: 17,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Color.fromARGB(255, 111, 111, 111),
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
        child: CustomText(
          text: 'Trivago',
          textColor: Colors.white,
          textSize: 120,
        ),
      );
    });
  }
}
