import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_wheel_of_fortune/utils/models/game_action.dart';

class ActionsList extends StatelessWidget {
  final List<GameAction> actionsList;

  ActionsList(this.actionsList);

  @override
  Widget build(BuildContext context) {
    return actionsList.isNotEmpty
        ? Stack(
          children: <Widget>[Align(
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
                  diameterRatio: 4,
                  itemExtent: MediaQuery.of(context).size.width / 6.5,
                  squeeze: 1.09,
                  childDelegate: ListWheelChildLoopingListDelegate(
                    children: List<Widget>.generate(
                      actionsList.length,
                      (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 5,
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
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 18.0),
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
}
