import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_wheel_of_fortune/pages/actions_list_edit_page.dart';
import 'package:my_wheel_of_fortune/utils/models/game_action.dart';
import 'package:my_wheel_of_fortune/utils/models/game_list.dart';
import 'package:my_wheel_of_fortune/utils/widgets/actions_list.dart';

class GameScreen extends StatefulWidget {
  final GameList gameList;

  GameScreen(this.gameList);

  @override
  GameScreenState createState() => GameScreenState();
}

class GameScreenState extends State<GameScreen> {
  final _actionNameController = TextEditingController();
  final _actionDescriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.orange, accentColor: Colors.orangeAccent),
      home: Scaffold(
        appBar: buildAppBar(),
        backgroundColor: Colors.black54,
        body: buildHomePageBackground(
          Stack(
            children: <Widget>[
              buildActionsListWheel(),
              buildActions(),
            ],
          ),
        ),
      ),
    );
  }

  buildAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 1,
      leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Icon(
              Icons.chevron_left,
              color: Colors.white,
              size: 50,
            ),
          )),
      centerTitle: true,
      title: Text(
        widget.gameList.gameListName,
        style: TextStyle(
            fontSize: MediaQuery.of(context).orientation == Orientation.portrait
                ? MediaQuery.of(context).size.width / 22
                : MediaQuery.of(context).size.width / 30,
            color: Colors.white),
      ),
    );
  }

  buildHomePageBackground(Widget child) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.1, 0.9],
          colors: [
            Colors.black,
            Colors.black87,
          ],
        ),
      ),
      child: child,
    );
  }

  buildActionsListWheel() {
    return ActionsList(widget.gameList.gameActions);
  }

  buildActions() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Align(
          alignment: Alignment.bottomRight,
          child: InkWell(
            onTap: () {
              addGameActionToList();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0, bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black12,
                  border: Border.all(
                    color: Colors.orange,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Icon(
                    Icons.add,
                    color: Colors.orange,
                    size: MediaQuery.of(context).size.width / 12,
                  ),
                ),
              ),
            ),
          ),
        ),
        widget.gameList.gameActions.length > 0
            ? Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () {
                    editListActions();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0, bottom: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        border: Border.all(
                          color: Colors.orangeAccent,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Icon(
                          Icons.view_list,
                          color: Colors.orange,
                          size: MediaQuery.of(context).size.width / 12,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : Container()
      ],
    );
  }

  addGameActionToList() {
    displayBottomSheetModal();
  }

  displayBottomSheetModal() {
    showModalBottomSheet(
      backgroundColor: Colors.black,
      context: context,
      builder: (context) => Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        decoration: new BoxDecoration(
            color: Colors.black,
            border: Border.all(width: 1.0, style: BorderStyle.solid),
            borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(20.0),
                topRight: const Radius.circular(20.0))),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Theme(
              data: ThemeData(primaryColor: Colors.orangeAccent),
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
                child: Transform.scale(
                  scale: .8,
                  child: TextFormField(
                    style: TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: MediaQuery.of(context).size.width / 20),
                    controller: _actionNameController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.mode_edit,
                          color: Colors.orangeAccent,
                        ),
                        hintText: "Nome da Lista",
                        hintStyle: TextStyle(
                            color: Colors.orangeAccent,
                            fontSize: MediaQuery.of(context).size.width / 20)),
                  ),
                ),
              ),
            ),
            Theme(
              data: ThemeData(primaryColor: Colors.orangeAccent),
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
                child: Transform.scale(
                  scale: .8,
                  child: TextFormField(
                    style: TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: MediaQuery.of(context).size.width / 20),
                    controller: _actionDescriptionController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.chat,
                          color: Colors.orangeAccent,
                        ),
                        hintText: "Nome da Lista",
                        hintStyle: TextStyle(
                            color: Colors.orangeAccent,
                            fontSize: MediaQuery.of(context).size.width / 20)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: BorderSide(color: Colors.orange)),
                color: Colors.black,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                    "Adicionar",
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: MediaQuery.of(context).size.width / 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                onPressed: () {
                  if (_actionNameController.text.isNotEmpty &&
                      _actionDescriptionController.text.isNotEmpty) {
                    setState(() {
                      widget.gameList.gameActions.add(GameAction(
                          _actionNameController.text,
                          _actionDescriptionController.text));

                      _actionNameController.clear();
                      _actionDescriptionController.clear();
                    });
                    Navigator.pop(context);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  editListActions() {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => ActionsListEditPage(
          widget.gameList.gameActions,
        ),
      ),
    );
  }
}
