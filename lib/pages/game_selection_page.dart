import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_wheel_of_fortune/pages/game_screen_page.dart';
import 'package:my_wheel_of_fortune/utils/models/game_action.dart';
import 'package:my_wheel_of_fortune/utils/models/game_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameSelectionPage extends StatefulWidget {
  @override
  GameSelectionPageState createState() => GameSelectionPageState();
}

class GameSelectionPageState extends State<GameSelectionPage> {
  final _prefs = SharedPreferences.getInstance();
  final _listNameController = TextEditingController();
  List<GameList> gamesList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Suas Listas",
          style: TextStyle(fontSize: 30),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 20.0, bottom: 10),
        child: Card(
          elevation: 5,
          color: Colors.white70,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.black38,
                  width: 2
            ),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              elevation: 0,
              backgroundColor: Colors.white,
              onPressed: () {
                displayBottomSheetModal();
              },
              child: Icon(
                Icons.add,
                color: Colors.black,
                size: 50,
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: getLocalLists(),
        builder: (context, snapsthot) => GridView.count(
          crossAxisCount: MediaQuery.of(context).orientation == Orientation.portrait ? 3 : 4,
          children: List.generate(
            gamesList.length,
            (index) => InkWell(
              onTap: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => GameScreen(
                      gamesList[index],
                    ),
                  ),
                );
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
                child: Card(
                  color: Colors.orange,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: ListTile(
                        title: Text(
                          gamesList[index].gameListName,
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                         gamesList[index].gameActions.length > 0 ?  "Possui ${gamesList[index].gameActions.length} cards" : "Lista vazia :(",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  getLocalLists() async {
    List<GameList> lists = [];
    var counter = 0;

    var prefs = await _prefs;

    while (prefs.containsKey("GameList$counter")) {
      ///TODO Get's list

      counter++;
    }
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
                  style: TextStyle(color: Colors.orangeAccent),
                  controller: _listNameController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: Colors.orangeAccent)),
                      prefixIcon: Icon(
                        Icons.mode_edit,
                        color: Colors.orangeAccent,
                      ),
                      hintText: "Nome da Lista",
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
                onPressed: () {
                  if (_listNameController.text.isNotEmpty) {
                    setState(() {
                      List<GameAction> emptyList = [];
                      gamesList.add(GameList(
                          _listNameController.text,
                        emptyList
                          ));

                      _listNameController.clear();
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
}
