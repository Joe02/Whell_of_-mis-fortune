import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_wheel_of_fortune/utils/models/game_action.dart';
import 'package:my_wheel_of_fortune/utils/widgets/actions_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  String listName = "Pejão";
  List<String> actionsList = [];
  List<String> actionsDescriptionList = [];
  final _prefs = SharedPreferences.getInstance();
  var prefs;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        backgroundColor: Colors.black54,
        body: buildHomePageBackground(Stack(
          children: <Widget>[
            buildActionsListWheel(),
            buildActions(),
          ],
        )));
  }

  buildAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 1,
      centerTitle: true,
      title: Text(
        listName,
        style: TextStyle(fontSize: 25),
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
    var index = 0;
    List<GameAction> finalActionsList = [];

    for (index = 0; index < actionsList.length; index++) {
      finalActionsList
          .add(GameAction(actionsList[index], actionsDescriptionList[index]));
    }

    return ActionsList(finalActionsList);
  }

  buildActions() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Align(
          alignment: Alignment.bottomRight,
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
              child: FloatingActionButton(
                backgroundColor: Colors.black12,
                onPressed: () {
                  addGameActionToList();
                },
                child: Icon(
                  Icons.add,
                  color: Colors.orange,
                  size: 50,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
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
              child: FloatingActionButton(
                backgroundColor: Colors.black12,
                onPressed: () {},
                child: Icon(
                  Icons.view_list,
                  color: Colors.orange,
                  size: 35,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  addGameActionToList() {
    displayBottomSheetModal();
    var verification = false;
    var count = 0;
//    while (verification != true) {
//      if (prefs.containsKey("ListAction$count")) {
//        var oldList = prefs.getStringList("ListAction$count");
//        var oldDescription = prefs.getStringList("ListDescription$count");
//
//        ///TODO Get's Action name and description from form.
//        oldList.add("Peje2");
//        oldDescription.add("Descrição do peje2");
//
//        prefs.setStringList("ListAction$count", oldList);
//        prefs.setStringList("ListDescription$count", oldDescription);
//      } else {
//
//        ///TODO Get's Action name and description from form.
//        var newList = ["Peje1"];
//        var newDescriptionList = ["Descrição do peje1"]
//
//        prefs.setStringList("ListAction$count", newList);
//        prefs.setStringList("ListDescription$count", newDescriptionList);
//      }
//    }

    setState(() {
      actionsList.add("Pejeeeee");
      actionsDescriptionList.add("Pejão");
    });
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
            border: Border.all(
                color: Colors.orange, width: 1.0, style: BorderStyle.solid),
            borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(20.0),
                topRight: const Radius.circular(20.0))),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Theme(
              data: ThemeData(primaryColor: Colors.orangeAccent),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: Colors.orangeAccent)),
                      prefixIcon: Icon(
                        Icons.mode_edit,
                        color: Colors.orangeAccent,
                      ),
                      hintText: "Nome do Desafio",
                      hintStyle:
                          TextStyle(color: Colors.orangeAccent, fontSize: 19)),
                ),
              ),
            ),
            Theme(
              data: ThemeData(primaryColor: Colors.orangeAccent),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: Colors.orangeAccent)),
                      prefixIcon: Icon(
                        Icons.chat,
                        color: Colors.orangeAccent,
                      ),
                      hintText: "Descrição do Desafio",
                      hintStyle:
                          TextStyle(color: Colors.orangeAccent, fontSize: 19)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                color: Colors.orange,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    "Adicionar",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                ),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
