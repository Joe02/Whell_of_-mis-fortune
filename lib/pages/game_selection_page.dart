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
          style: TextStyle(fontSize: MediaQuery.of(context).size.width / 22),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 10.0, bottom: 10),
        child: Transform.scale(
          scale: 0.8,
          child: FloatingActionButton(
            elevation: 0,
            backgroundColor: Colors.white,
            onPressed: () {
              displayBottomSheetModal();
            },
            child: Icon(
              Icons.add,
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: getLocalLists(),
        builder: (context, snapshot) => GridView.count(
          crossAxisCount: MediaQuery.of(context).size.width ~/ 100,
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
              child: Card(
                color: Colors.orange,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Center(
                    child: ListTile(
                      title: Text(
                        gamesList[index].gameListName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 24,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          gamesList[index].gameActions.length > 0
                              ? "Possui ${gamesList[index].gameActions.length} cards"
                              : "Lista vazia :(",
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width / 28,
                              fontWeight: FontWeight.w600),
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
                    controller: _listNameController,
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
            Padding(
              padding: const EdgeInsets.only(right: 40, left: 40, bottom: 10),
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
                  if (_listNameController.text.isNotEmpty) {
                    setState(() {
                      List<GameAction> emptyList = [];
                      gamesList
                          .add(GameList(_listNameController.text, emptyList));

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
