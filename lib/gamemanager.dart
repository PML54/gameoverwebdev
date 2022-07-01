import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:gameover/configgamephl.dart';
import 'package:gameover/gamephlclass.dart';
import 'package:gameover/phlcommons.dart';
import 'package:gameover/selectphotos.dart';
import 'package:http/http.dart' as http;
import 'package:clipboard/clipboard.dart';
class GameManager extends StatefulWidget {
  const GameManager({Key? key}) : super(key: key);

  @override
  State<GameManager> createState() => _GameManagerState();
}
class _GameManagerState extends State<GameManager> {
  Color  colorOK =Colors.green;
  Color  colorKO=Colors.red;
  bool myBool = false;

  bool isGameActif = false; // Pas de Game Acfig
  bool isPublic = true;
  bool isGameValidated = false;
  int nbGmGames = 0; //: Nb de Games pour cr GameGM
  List<Games> listGmGames = []; // Games of that _GM connected
  TextEditingController gameNameController = TextEditingController();
  TextEditingController gameNbGamersController = TextEditingController();
  String thatGameName = ""; //<TODO>
  int thatGameCode = 0;
  String thatGM = PhlCommons.listThatGM[0].gmpseudo;
  int thatGmid = PhlCommons.listThatGM[0].gmid;
  double nbGamers = 2;
  double nbPhotos = 1;
  double nbSecMeme = 20;
  double nbSecVote = 30;
  String dispNbFotosGame = "";
  String thatGameCodeString = "";
  //
  bool timeOut = false;

  bool getGmGamesState  = false;
  int getGmGamesError = -1;

  bool createGameState  = false;
  int createGameError = -1;
  //
  Duration countDownGameDuration = const Duration(seconds: 40);
  Duration durationGame = const Duration();
  Timer? timerGame;
  bool countDownGame = true;
//

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: thatGM,
        home: Scaffold(
          appBar: AppBar(actions: <Widget>[
            Expanded(
              child: Row(
                children: [
                  ElevatedButton(
                      onPressed: () => {Navigator.pop(context)},
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5),
                          textStyle: const TextStyle(
                              fontSize: 14,
                              backgroundColor: Colors.red,
                              fontWeight: FontWeight.bold)),
                      child: const Text('Exit')),
                  ElevatedButton(
                    onPressed: () => {null},
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10),
                        textStyle: const TextStyle(
                            fontSize: 10,
                            backgroundColor: Colors.green,
                            fontWeight: FontWeight.bold)),
                    child: Text('' + thatGM + " ",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.normal,
                        )),
                  ),
                  Row(
                    children: [
                      Tooltip(
                        message: 'Copy',
                        child: ElevatedButton(
                            onPressed: () => { copyClipBoard(thatGameCodeString)},

                            style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 5),
                                textStyle: const TextStyle(
                                    fontSize: 14,
                                    backgroundColor: Colors.red,
                                    fontWeight: FontWeight.bold)),
                            //child: Text(thatGameName +'' + thatGameCodeString )),
                            child: Text(  thatGameCodeString )
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
          //  ECRAN PRINCIP
          body: Column(
            children: [
              SafeArea(
                child: Column(children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      width: 180,
                      height: 80,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextField(
                          controller: gameNameController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: "Game",
                            fillColor: Colors.blue,
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 2.0),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                          onChanged: (text) {
                            setState(() {
                              if (gameNameController.text.isNotEmpty) {
                                thatGameName =
                                    gameNameController.text.toUpperCase();
                              }
                              if (thatGameName.length > 8) {
                                thatGameName = thatGameName.substring(0, 8);
                              }
                            });
                          },
                          onSubmitted: (text) {
                            setState(() {
                              gameNameController.text = thatGameName;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        const Text('Public'),
                        Checkbox(
                          value: isPublic,
                          onChanged: (value) {
                            setState(() {
                              isPublic = !isPublic;
                            });
                          },
                        ),
                        const Text('Private'),
                        Checkbox(
                          value: !isPublic,
                          onChanged: (value) {
                            setState(() {
                              isPublic = !isPublic;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    // Slider N°1 Gamers
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Text(nbGamers.toString() + " Gamers"),
                        Slider(
                          label: 'Gamers ',
                          activeColor: Colors.orange,
                          divisions: 20,
                          min: 1,
                          max: 20,
                          value: nbGamers,
                          onChanged: (double newValue) {
                            setState(() {
                              newValue = newValue.round() as double;
                              if (newValue != nbGamers) nbGamers = newValue;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    // Slider N°2 Photos
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Text(nbPhotos.toString() + " Photos"),
                        Slider(
                          label: 'Photos ',
                          activeColor: Colors.orange,
                          divisions: 10,
                          min: 1,
                          max: 10,
                          value: nbPhotos,
                          onChanged: (double newValue) {
                            setState(() {
                              newValue = newValue.round() as double;
                              if (newValue != nbPhotos) nbPhotos = newValue;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    // Slider N° 3   Sec/Mem
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Text(nbSecMeme.toString() + " Sec/Mem"),
                        Slider(
                          label: 'Sec/ Meme ',
                          activeColor: Colors.orange,
                          divisions: 20,
                          min: 20,
                          max: 420,
                          value: nbSecMeme,
                          onChanged: (double newValue) {
                            setState(() {
                              //     dispNbFotosGame = PhlCommons.nbFotosGame.toString(); // <TODO>
                              newValue = newValue.round() as double;
                              if (newValue != nbSecMeme) nbSecMeme = newValue;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    // Slider N° 4   Sec/ Vote
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Text(nbSecVote.toString() + " Sec /Vote"),
                        Slider(
                          label: 'Votes ',
                          activeColor: Colors.orange,
                          divisions: 20,
                          min: 10,
                          max: 110,
                          value: nbSecVote,
                          onChanged: (double newValue) {
                            setState(() {
                              newValue = newValue.round() as double;
                              if (newValue != nbSecVote) nbSecVote = newValue;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                          onPressed: () => {overSelectPhotosPhl()},
                          style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              textStyle: const TextStyle(
                                  fontSize: 10,
                                  backgroundColor: Colors.red,
                                  fontWeight: FontWeight.bold)),
                          child: const Text('PHOTOS')),
                      Visibility(
                        visible: nbPhotos == PhlCommons.nbFotosGame &&
                            nbPhotos > 0 &&
                            thatGameName.length > 2 &&
                            !isGameValidated,
                        child: ElevatedButton(
                          onPressed: () => {newGame()},
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 10),
                              textStyle: const TextStyle(
                                  fontSize: 10,
                                  backgroundColor: Colors.green,
                                  fontWeight: FontWeight.bold)),
                          child: const Text('Valider',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                fontStyle: FontStyle.normal,
                              )),
                        ),
                        //createGameState


                      ),
                      Text(createGameState.toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                          )),
                    ],
                  ),
                ]),
              ),
              // Container(child: dispMyGames())
            ],
          ),
        ));
  }
  Expanded dispMyGames() {
    //if (!feuVert) return (const Expanded(child: Text("Je Joue ........")));
    // Lire ous les Games  de ce gamers
    setState(() {});
    if (listGmGames.isEmpty) {
      return (const Expanded(child: Text(' No GAMES !!! for GM')));
    }
    var listView = ListView.builder(
        itemCount: listGmGames.length,
        controller: ScrollController(),
        itemBuilder: (context, index) {
          return ListTile(
              dense: true,
              title: Row(children: [
                Text(listGmGames[index].gamename +
                    ":" +
                    listGmGames[index].gamecode.toString() +
                    " " +
                    statusGame[listGmGames[index].gamestatus])
              ]),
              onTap: () {
                setState(() {});
              });
        });
    return (Expanded(child: listView));
  }
  Future getGmGames() async {
    Uri url = Uri.parse(pathPHP+"getGMGAMES.php");
    var data = {
      "GMID": thatGmid.toString(),
    };
    getGmGamesState  = false;
    getGmGamesError = -1;

    http.Response response = await http.post(url, body: data);

    if (response.body.toString() == 'ERR_1001') {
      nbGmGames = 0;
      getGmGamesError=1001; //Not Found

    }

    if (response.statusCode == 200 && (getGmGamesError!=1001 )) {
      var datamysql = jsonDecode(response.body) as List;
      getGmGamesError = 0;
      setState(() {
        getGmGamesError=0;

        listGmGames = datamysql.map((xJson) => Games.fromJson(xJson)).toList();


        getGmGamesState  = true;
      });
    } else {}
  }
  @override
  void initState() {
    super.initState();
    setState(() {
      thatGM = PhlCommons.listThatGM[0].gmpseudo;
      thatGmid = PhlCommons.listThatGM[0].gmid;
      getGmGames();
      dispNbFotosGame = PhlCommons.nbFotosGame.toString();
      genCodeGame();
      PhlCommons.thisGameCode=thatGameCode;

    });
  }

  copyClipBoard(String copire){

  //  Clipboard.setData(ClipboardData(text: "your text"));
    FlutterClipboard.copy(copire).then(( value ) =>
        print('copied'));
  }
  majCommonGame(
      //  Mettre en Common Le Game Actif
      int _gameCode,
      int _gameMode,
      int _gameStatus,
      String _gameName,
      String _gameDate,
      int _gmid,
      int _gameNbGamers,
      int _gameNbPhotos,
      int _gameNbGamersActifs,
      int _gameFilter,
      int _gameTimeMeme,
      int _gameTimeVote,
      int _gameTimer,
      int _gameOpen) {
    PhlCommons.gameActif.gamecode = _gameCode;
    PhlCommons.gameActif.gamemode = _gameMode;
    PhlCommons.gameActif.gamestatus = _gameStatus;
    PhlCommons.gameActif.gamename = _gameName;
    PhlCommons.gameActif.gamedate = _gameDate;
    PhlCommons.gameActif.gmid = _gmid;
    PhlCommons.gameActif.gamenbgamers = _gameNbGamers;
    PhlCommons.gameActif.gamenbphotos = _gameNbPhotos;
    PhlCommons.gameActif.gamenbgamersactifs = _gameNbGamersActifs;
    PhlCommons.gameActif.gamefilter = _gameFilter;
    PhlCommons.gameActif.gametimememe = _gameTimeMeme;
    PhlCommons.gameActif.gametimevote = _gameTimeVote;
    PhlCommons.gameActif.gametimer = _gameTimer;
    PhlCommons.gameActif.gameopen = _gameOpen;
    //  gameid: -1,
  }
  Future newGame() async {


    int _gameStatus = 1; // PHOTOCLOSED
    int _gameNbGamersActifs = 0;
    int _gameFilter = 0;
    int _thatMode = 0;
    int _gameTimer = 0;
    int _gameOpen = 0;
    if (isPublic) _thatMode = 1;

    isGameValidated = true; // OK on a preque valid
    // Mise en Common
    String _today = DateTime.now().toString();


    majCommonGame(
      thatGameCode,
      _thatMode,
      _gameStatus,
      thatGameName,
      _today,
      thatGmid,
      nbGamers.toInt(),
      nbPhotos.toInt(),
      _gameNbGamersActifs,
      _gameFilter,
      nbSecMeme.toInt(),
      nbSecVote.toInt(),
      _gameTimer,
      _gameOpen,
    );
    Uri url = Uri.parse(pathPHP+"createGAME.php");
    createGameState  = false;
    createGameError = -1;
// Mise au Propre
    var data = {
      "GAMECODE": PhlCommons.gameActif.gamecode.toString(),
      "GAMEMODE": PhlCommons.gameActif.gamemode.toString(),
      "GAMESTATUS": PhlCommons.gameActif.gamestatus.toString(),
      "GAMENAME": PhlCommons.gameActif.gamename,
      "GAMEDATE": PhlCommons.gameActif.gamedate,
      "GMID": PhlCommons.gameActif.gmid.toString(),
      "GAMENBGAMERS": PhlCommons.gameActif.gamenbgamers.toString(),
      "GAMENBPHOTOS": PhlCommons.gameActif.gamenbphotos.toString(),
      "GAMENBGAMERSACTIFS": PhlCommons.gameActif.gamenbgamersactifs.toString(),
      "GAMEFILTER": PhlCommons.gameActif.gamefilter.toString(),
      "GAMETIMEMEME": PhlCommons.gameActif.gametimememe.toString(),
      "GAMETIMEVOTE": PhlCommons.gameActif.gametimevote.toString(),
      "GAMETIMER": PhlCommons.gameActif.gametimer.toString(),
      "GAMEOPEN": PhlCommons.gameActif.gameopen.toString(),
    };
    var response = await http.post(url, body: data);

    if (response.body.toString() == 'ERR_1001') {
    nbGmGames = 0;
    createGameState  = false;
   createGameError = 1001;


    }

    if (response.statusCode == 200 && (createGameError!=1001 )) {
    var datamysql = jsonDecode(response.body) as List;
    createGameError = 0;
    setState(() {
    createGameError=0;
    listGmGames = datamysql.map((xJson) => Games.fromJson(xJson)).toList();
    createGameState  = true;
    });
    } else {}
  //  getGmGames();
  }
  Future overSelectPhotosPhl() async {
    await (Navigator.push(
        context, MaterialPageRoute(builder: (context) => SelectPhotosPhl())));
    setState(() {
      dispNbFotosGame = PhlCommons.nbFotosGame.toString(); // <TODO>
    });
  }
  genCodeGame()
  {
    var rng = Random();
    var rand1 = rng.nextInt(8) + 1;
    var rand2 = rng.nextInt(1000000);
    setState(() {
      thatGameCode = rand1 * 10000000 + rand2;
      thatGameCodeString = thatGameCode.toString();
    });

  }
  //   CHRONO
  void reset() {
    if (countDownGame) {
      setState(() => durationGame = countDownGameDuration);
    } else {
      setState(() => durationGame = const Duration());
    }
  }
  void startTimer() {
    timerGame = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }
  void addTime() {
    final addSeconds = countDownGame ? -1 : 1;
    setState(() {
      final seconds = durationGame.inSeconds + addSeconds;
      if (seconds < 0) {
        timerGame?.cancel();
        timeOut = true;
      } else {
        durationGame = Duration(seconds: seconds);
      }
    });
  }
  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    setState(() => timerGame?.cancel());
  }
  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final minutes = twoDigits(durationGame.inMinutes.remainder(60));
    final seconds = twoDigits(durationGame.inSeconds.remainder(60));
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      /* buildTimeCard(time: hours, header:''),
          SizedBox(width: 8,),*/
      buildTimeCard(time: minutes, header: ''),
      const SizedBox(
        width: 8,
      ),
      buildTimeCard(time: seconds, header: ''),
    ]);
  }
  Widget buildTimeCard({required String time, required String header}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Text(
              time,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Text(header, style: const TextStyle(color: Colors.black45)),
        ],
      );
  Widget buildButtons() {
    final isRunning = timerGame == null ? false : timerGame!.isActive;
    final isCompleted = durationGame.inSeconds == 0;
    return isRunning || isCompleted
        ? Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ButtonWidget(
            text: 'STOP',
            onClicked: () {
              if (isRunning) {
                stopTimer(resets: false);
              }
            }),
        const SizedBox(
          width: 12,
        ),
        ButtonWidget(text: "CANCEL", onClicked: stopTimer),
      ],
    )
        : ButtonWidget(
        text: "Start Timer!",
        color: Colors.black,
        backgroundColor: Colors.white,
        onClicked: () {
          startTimer();
        });
  }
}
class ButtonWidget extends StatelessWidget {
  final String text;
  final Color color;
  final Color backgroundColor;
  final VoidCallback onClicked;

  const ButtonWidget(
      {Key? key,
        required this.text,
        required this.onClicked,
        this.color = Colors.white,
        this.backgroundColor = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
      onPressed: onClicked,
      child: Text(
        text,
        style: TextStyle(fontSize: 20, color: color),
      ));
}
