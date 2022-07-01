import 'dart:convert';
import 'dart:core';

import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:gameover/configgamephl.dart';
import 'package:gameover/gamephlclass.dart';
import 'package:gameover/phlcommons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Memolike extends StatefulWidget {
  const Memolike({Key? key}) : super(key: key);

  @override
  State<Memolike> createState() => _MemolikeState();
}

class _MemolikeState extends State<Memolike> {
  TextEditingController legendeController = TextEditingController();
  String mafoto = 'assets/oursmacron.png';
  bool myBool = false;
  String ipv4name = "**.**.**";
  String memeLegende = "";
  bool getMemolikeState = false;
  int getMemolikeError = 0;
  List<MemoLike> listMemoLike = [];
  List<int> listCountEmo = [];
  List<CheckVotePlus> listCheckVote = [];
  int thatFavori = 1;
  int cestCeluiLa = 0;
  bool repaintPRL = true;
  bool boolTexfield = true;
  bool booLike = false;
  final now = DateTime.now();
  int thatSum = 0;
  int thatCount = 0;
  double thatAverage = 0;
  late int myUid;

  @override
  Widget build(BuildContext context) {
    final myPerso = ModalRoute.of(context)!.settings.arguments as GameCommons;
    myUid = myPerso.myUid;

    return MaterialApp(
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
                Text(
                  myPerso.myPseudo + " ",
                  style: GoogleFonts.averageSans(fontSize: 18.0),
                ),
                Visibility(
                  visible: booLike,
                  child: IconButton(
                      icon: const Icon(Icons.sunny),
                      iconSize: 35,
                      color: Colors.yellowAccent,
                      tooltip: 'Not Like',
                      onPressed: () {
                        // createMemeSolo();
                      }),
                ),
                Slider(
                    label: '% Like ',
                    activeColor: Colors.red,
                    divisions: 20,
                    min: 0,
                    max: 50,
                    value: thatAverage.toDouble(),
                    onChanged: (double newValue) {}),
              ],
            ),
          ),
        ]),
        body: getMemolikeState
            ? SafeArea(
                child: Column(children: <Widget>[
                  Container(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        listMemoLike[cestCeluiLa].memostock,
                        style: GoogleFonts.averageSans(fontSize: 18.0),
                      )),
                  Container(
                    alignment: Alignment.center,
                    child: Image.network(
                      "upload/" +
                          listMemoLike[cestCeluiLa].photofilename +
                          "." +
                          listMemoLike[cestCeluiLa].photofiletype,
                    ),
                  ),
                  Row(children: <Widget>[
                    //🤣
                    Column(
                      children: [
                        TextButton(
                          onPressed: () => {pressEmoticone(myUid, 0)},
                          child: const Text(
                            '🙁',
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                        Text((listCountEmo[0]).toString())
                      ],
                    ),
                    Column(
                      children: [
                        TextButton(
                          onPressed: () => {pressEmoticone(myUid, 1)},
                          child: const Text(
                            '😐',
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                        Text((listCountEmo[1]).toString())
                      ],
                    ),
                    Column(
                      children: [
                        TextButton(
                          onPressed: () => {pressEmoticone(myUid, 2)},
                          child: const Text(
                            '🙂',
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                        Text((listCountEmo[2]).toString())
                      ],
                    ),
                    Column(
                      children: [
                        TextButton(
                          onPressed: () => {pressEmoticone(myUid, 3)},
                          child: const Text(
                            '😄',
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                        Text((listCountEmo[3]).toString())
                      ],
                    ),
                    Column(
                      children: [
                        TextButton(
                          onPressed: () => {pressEmoticone(myUid, 4)},
                          child: const Text(
                            '😆',
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                        Text((listCountEmo[4]).toString())
                      ],
                    ),
                    Column(
                      children: [
                        TextButton(
                          onPressed: () => {pressEmoticone(myUid, 5)},
                          child: const Text(
                            '🤣',
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                        Text((listCountEmo[5]).toString())
                      ],
                    ),
                  ]),
                Center(child: Text('By '+listMemoLike[cestCeluiLa].memolikeuser)),

                ]),

              )
            : Text(''),
        bottomNavigationBar: Row(children: [
          IconButton(
              icon: const Icon(Icons.arrow_back),
              iconSize: 35,
              color: Colors.blue,
              tooltip: 'Prev',
              onPressed: () {
                prevPRL();
                //createMeme();
                //stopTimer();
              }),
          Text(
            (cestCeluiLa + 1).toString() + '/' + listMemoLike.length.toString(),
            style: GoogleFonts.averageSans(fontSize: 18.0),
          ),
          IconButton(
              icon: const Icon(Icons.arrow_forward),
              iconSize: 35,
              color: Colors.blue,
              tooltip: 'Next',
              onPressed: () {
                nextPRL();
              }),
          Text(
            " Uid =" + myPerso.myUid.toString(),
            style: GoogleFonts.averageSans(fontSize: 18.0),
          ),
          Text(
            " Moyenne = " + thatAverage.toString(),
            style: GoogleFonts.averageSans(fontSize: 15.0),
          ),
        ]),
      ),
    );
  }

  Future createMemolikeVote(int _myUid, int _points) async {
    Uri url = Uri.parse(pathPHP + "createMLV.php");

    var data = {
      "MLVPOINTS": _points.toString(),
      "MLVDATE": now.toString(),
      "MEMOLIKEID": listMemoLike[cestCeluiLa].memolikeid.toString(),
      "UID": _myUid.toString()
    };
    var res = await http.post(url, body: data);
    var datamysql = jsonDecode(res.body) as List;
    setState(() {
      listCheckVote =
          datamysql.map((xJson) => CheckVotePlus.fromJson(xJson)).toList();
      updateThisMli(listMemoLike[cestCeluiLa].memolikeid);
      thatAverage =
          (updateThisMli(listMemoLike[cestCeluiLa].memolikeid)).toDouble();
    });
  }

  Future getIP() async {
    final ipv4 = await Ipify.ipv4();

    setState(() {
      ipv4name = ipv4;
    });
  }

  Future getMemolikeVote() async {
    Uri url = Uri.parse(pathPHP + "getMLV.php");
    var data = {
      "MEMOLIKEID": listMemoLike[cestCeluiLa].memolikeid.toString(),
    };

    var res = await http.post(url, body: data);
    var datamysql = jsonDecode(res.body) as List;
    setState(() {

      listCheckVote =
          datamysql.map((xJson) => CheckVotePlus.fromJson(xJson)).toList();


      thatAverage =
          (updateThisMli(listMemoLike[cestCeluiLa].memolikeid)).toDouble();

    });
  }

  @override
  void initState() {
    super.initState();
    cestCeluiLa = 0;
    getIP();
    readMemolike();
    listCountEmo.clear();
    for (int i = 0; i < 6; i++) {
      listCountEmo.add(0);
    }
  }

  nextPRL() {
    setState(() {
      thatSum = 0;
      thatCount = 0;
      booLike = false;
      cestCeluiLa++;
      if (cestCeluiLa >= listMemoLike.length) {
        cestCeluiLa = listMemoLike.length - 1;
      }

      getMemolikeVote();
      repaintPRL = true;
      updateThisMli(listMemoLike[cestCeluiLa].memolikeid);
    });
  }

  pressEmoticone(int _myUid, int lequel) {
    setState(() {
      createMemolikeVote(_myUid, lequel);
    });
  }

  prevPRL() {
    setState(() {
      thatSum = 0;
      thatCount = 0;
      booLike = false;

      cestCeluiLa--;
      if (cestCeluiLa < 0) cestCeluiLa = 0;
      getMemolikeVote();
      repaintPRL = true;
      updateThisMli(listMemoLike[cestCeluiLa].memolikeid);
    });
  }

  Future readMemolike() async {
    Uri url = Uri.parse(pathPHP + "readMEMOLIKE.php");
    getMemolikeState = false;
    http.Response response = await http.post(url);
    if (response.body.toString() == 'ERR_1001') {
      getMemolikeError = 1001; //Not Found
    }
    if (response.statusCode == 200 && (getMemolikeError != 1001)) {
      var datamysql = jsonDecode(response.body) as List;
      setState(() {
        getMemolikeError = 0;
        listMemoLike =
            datamysql.map((xJson) => MemoLike.fromJson(xJson)).toList();
        getMemolikeState = true;
      });
    } else {}
  }

  int updateThisMli(int _memolikeid) {
    int _thatNote = 0;
    int inote = 0;
    listCountEmo.clear();
    for (int i = 0; i < 6; i++) {
      listCountEmo.add(0);
    }
    for (CheckVotePlus _cvp in listCheckVote) {
      if (_cvp.memolikeid == _memolikeid) {
        int suiCi = _cvp.mlvpoints;
        _thatNote = _thatNote + suiCi;
        inote++;
        listCountEmo[suiCi] = _cvp.cumu;
      }
    }
    if (inote == 0) inote = 1;
    int calcul = (_thatNote * 10 / inote).toInt();
    return (calcul);
  }
}
