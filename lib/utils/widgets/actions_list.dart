import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_wheel_of_fortune/utils/models/game_action.dart';
import 'dart:math' as math;

class ActionsList extends StatefulWidget {
  final List<GameAction> actionsList;
  ActionsList(this.actionsList);

  @override
  ActionsListState createState() => ActionsListState(actionsList);
}

class ActionsListState extends State<ActionsList> {
  final List<GameAction> actionsList;

  ActionsListState(this.actionsList);

  final _listWheelController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return actionsList.isNotEmpty
        ? Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Icon(
                    Icons.arrow_right,
                    color: Colors.orange,
                    size: 50,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 12),
                child: new ListWheelScrollView.useDelegate(
                  controller: _listWheelController,
                  diameterRatio: 3,
                  itemExtent: MediaQuery.of(context).orientation == Orientation.landscape ? MediaQuery.of(context).size.width / 8.5 : MediaQuery.of(context).size.width / 6.5,
                  squeeze: MediaQuery.of(context).orientation == Orientation.landscape ? 1.05 : 1.10,
                  childDelegate: ListWheelChildLoopingListDelegate(
                    children: List<Widget>.generate(
                      actionsList.length,
                      (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 0,
                          color: Colors.black12,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(color: Colors.orangeAccent)),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    actionsList[index].actionName,
                                    style: TextStyle(
                                        color: Colors.orangeAccent,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0),
                                  child: Text(
                                    actionsList[index].actionDescription,
                                    style: TextStyle(
                                        color: Colors.orange,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              actionsList.length > 2 ? Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0, bottom: 147.5),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      border: Border.all(
                        color: Colors.orangeAccent,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: FloatingActionButton(
                      backgroundColor: Colors.black12,
                      onPressed: () {
                        randomAction();
                      },
                      child: Icon(
                        Icons.help_outline,
                        color: Colors.orange,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ) : Container()
            ],
          )
        : Container(
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Icon(
                    Icons.clear,
                    size: 300,
                    color: Colors.white10,
                  ),
                  Text(
                    "Você ainda não possui nenhum desafio na lista!\nAdicione um clicando no ícone na direita.",
                    style: TextStyle(color: Colors.white60, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
  }

  randomAction() {
    setState(() {
      var random = math.Random();
      var randomNumber = 0 + random.nextInt(actionsList.length - 0);
      print(randomNumber);
      print(_listWheelController.position);

      _listWheelController.animateTo(randomNumber.toDouble() * 7550,
          duration: Duration(seconds: 4), curve: Curves.decelerate);

      print(_listWheelController.position);
    });
  }
}
