import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_wheel_of_fortune/utils/models/game_action.dart';

class ActionsListEditPage extends StatefulWidget {
  final List<GameAction> actionsList;

  ActionsListEditPage(this.actionsList);

  @override
  ActionsListEditPageState createState() => ActionsListEditPageState();
}

class ActionsListEditPageState extends State<ActionsListEditPage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimatedList(
        key: _listKey,
        initialItemCount: widget.actionsList.length,
        itemBuilder: (context, index, animation) {
          return Dismissible(
            key: Key("dismissibleKey$index"),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Colors.orange)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: ListTile(
                          title: Text(
                            widget.actionsList[index].actionName,
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.orange,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            widget.actionsList[index].actionDescription,
                            style: TextStyle(fontSize: 20, color: Colors.orange, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Icon(Icons.mode_edit, color: Colors.orange, size: 30,),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _listKey.currentState.removeItem(index, (context, animation) => null);
                                    widget.actionsList.removeAt(index);
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Icon(Icons.delete, color: Colors.orange, size: 30,),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
