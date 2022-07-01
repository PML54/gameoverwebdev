import 'dart:core';
import 'package:flutter/material.dart';
class Games {
  int gameid = 0; // Auto
  int gamecode = 0;
  int gamemode = 0;
  int gamestatus = 0;
  String gamename = "";
  String gamedate = "2022-05-05";
  int gmid = 0; // GameMAster
  int gamenbgamers = 0;
  int gamenbgamersactifs = 0;
  int gamenbphotos = 0;
  int gamefilter = 0;
  int gametimememe = 0;

  int gametimevote = 0;
  int gametimer = 0;

  int gameopen = 0;

  Games(
      {required this.gameid,
      required this.gamecode,
      required this.gamemode,
      required this.gamestatus,
      required this.gamename,
      required this.gamedate,
      required this.gmid,
      required this.gamenbgamers,
      required this.gamenbphotos,
      required this.gamenbgamersactifs,
      required this.gamefilter,
      required this.gametimememe,
      required this.gametimevote,
      required this.gametimer,
      required this.gameopen});

  factory Games.fromJson(Map<String, dynamic> json) {
    return Games(
      gameid: int.parse(json['GAMEID']),
      gamecode: int.parse(json['GAMECODE']),
      gamemode: int.parse(json['GAMEMODE']),
      gamestatus: int.parse(json['GAMESTATUS']),
      gamename: json['GAMENAME'] as String,
      gamedate: json['GAMEDATE'] as String,
      gmid: int.parse(json['GMID']),
      gamenbgamers: int.parse(json['GAMENBGAMERS']),
      gamenbphotos: int.parse(json['GAMENBPHOTOS']),
      gamenbgamersactifs: int.parse(json['GAMENBGAMERSACTIFS']),
      gamefilter: int.parse(json['GAMEFILTER']),
      gametimememe: int.parse(json['GAMETIMEMEME']),
      gametimevote: int.parse(json['GAMETIMEVOTE']),
      gametimer: int.parse(json['GAMETIMER']),
      gameopen: int.parse(json['GAMEOPEN']),
    );
  }
} // Games

//------------>  GameMasters N°2
class GameMasters {
  int gmid = 0; // Auto
  String gmpseudo = "XXXX";
  String gmname = "zzzzz";
  String gmpwd = "YYYYY";
  String gmlast = "2022-05-05";
  String gmipv4 = "**.**.**.**";

  GameMasters(
      {required this.gmid,
      required this.gmpseudo,
      required this.gmname,
      required this.gmpwd,
      required this.gmlast,
      required this.gmipv4});

  factory GameMasters.fromJson(Map<String, dynamic> json) {
    return GameMasters(
        gmid: int.parse(json['GMID']),
        gmpseudo: json['GMPSEUDO'] as String,
        gmname: json['GMNAME'] as String,
        gmpwd: json['GMPWD'] as String,
        gmlast: json['GMLAST'] as String,
        gmipv4: json['GMIPV4'] as String);
  }
}

//------------>  GameUsers N°3
class GameUsers {
  int guid = 0;
  int gamecode = 0;
  int gustatus = 0;
  String guipv4 = "**.**.**.**";
  String gudate = "05-05-2022";
  String gupseudo = "FFFF";

  GameUsers({
    required this.guid,
    required this.gamecode,
    required this.gustatus,
    required this.guipv4,
    required this.gudate,
    required this.gupseudo,
  });

  factory GameUsers.fromJson(Map<String, dynamic> json) {
    return GameUsers(
      guid: int.parse(json['GUID']),
      gamecode: int.parse(json['GAMECODE']),
      gustatus: int.parse(json['GUSTATUS']),
      guipv4: json['GUIPV4'] as String,
      gudate: json['GULAST'] as String,
      gupseudo: json['GUPSEUDO'] as String,
    );
  }
}

//------------>  PhotoBase  N°4
class PhotoBase {
  int photofilesize = 0;
  int photoheight = 0;
  int photoid = 0;
  int photoinode = 0;
  int photowidth = 0;
  String photocat = "NOT";
  String photouploader = "YYY";
  String photodate = "05-05-2022";
  String photofilename = "FFFF";
  String photofiletype = "TTT";
  String memetempo = ""; // <TODO> Le ptit plu
  // Add
  bool isSelected = false;
  double extraWidth = 100;
  double extraHeight = 100;
  Color extraColor = Colors.grey;

  PhotoBase({
    required this.photofilesize,
    required this.photoheight,
    required this.photoid,
    required this.photoinode,
    required this.photowidth,
    required this.photocat,
    required this.photouploader,
    required this.photodate,
    required this.photofilename,
    required this.photofiletype,
  });

  factory PhotoBase.fromJson(Map<String, dynamic> json) {
    return PhotoBase(
      photofilesize: int.parse(json['PHOTOFILESIZE']),
      photoheight: int.parse(json['PHOTOHEIGHT']),
      photoid: int.parse(json['PHOTOID']),
      photoinode: int.parse(json['PHOTOINODE']),
      photowidth: int.parse(json['PHOTOWIDTH']),
      photocat: json['PHOTOCAT'] as String,
      photouploader: json['PHOTOUPLOADER'] as String,
      photodate: json['PHOTODATE'] as String,
      photofilename: json['PHOTOFILENAME'] as String,
      photofiletype: json['PHOTOFILETYPE'] as String,
    );
  }
}

//------------>  Memes N°5
class Memes {
  int memeid = 0;
  int photoid = 0;
  int gamecode = 0;
  String gupseudo = "XXX";
  String memetext = "";

  Memes({
    required this.memeid,
    required this.photoid,
    required this.gamecode,
    required this.gupseudo,
    required this.memetext,
  });

  factory Memes.fromJson(Map<String, dynamic> json) {
    return Memes(
      memeid: int.parse(json['MEMEID']),
      photoid: int.parse(json['PHOTOID']),
      gamecode: int.parse(json['GAMECODE']),
      gupseudo: json['GUPSEUDO'] as String,
      memetext: json['MEMETEXT'] as String,
    );
  }
}

//------------>  Evaluations N°6
class Evaluations {
  int evalpoints = 0;
  int gameid = 0;
  int memeid = 0;
  String guimarker = "XXX";
  String guiwriter = "XXX";

  Evaluations({
    required this.evalpoints,
    required this.gameid,
    required this.memeid,
    required this.guimarker,
    required this.guiwriter,
  });

  factory Evaluations.fromJson(Map<String, dynamic> json) {
    return Evaluations(
      evalpoints: int.parse(json['EVALPOINTS']),
      gameid: int.parse(json['GAMEID']),
      memeid: int.parse(json['MEMEID']),
      guimarker: json['GUIMARKER'] as String,
      guiwriter: json['GUIWRITER'] as String,
    );
  }
}

//------------>   ClefCodes N°7
class ClefCodes {
  String clefcode = "XXX";
  int clefcodeid = 0;

  ClefCodes({
    required this.clefcode,
    required this.clefcodeid,
  });

  factory ClefCodes.fromJson(Map<String, dynamic> json) {
    return ClefCodes(
      clefcode: json['CLEFCODE'] as String,
      clefcodeid: int.parse(json['CLEFCODEID']),
    );
  }
}

//------------>  GamePhotoSelect N°8
class GamePhotoSelect {
  int gameid = 0;
  int photoid = 0;

  GamePhotoSelect({
    required this.gameid,
    required this.photoid,
  });

  factory GamePhotoSelect.fromJson(Map<String, dynamic> json) {
    return GamePhotoSelect(
      gameid: int.parse(json['GAMEID']),
      photoid: int.parse(json['PHOTOID']),
    );
  }
}

//------------>    PhotoClefs  N°9
class PhotoClefs {
  int photoid = 0;
  int clefcodeid = 0;

  PhotoClefs({
    required this.photoid,
    required this.clefcodeid,
  });

  factory PhotoClefs.fromJson(Map<String, dynamic> json) {
    return PhotoClefs(
      photoid: int.parse(json['PHOTOID']),
      clefcodeid: int.parse(json['CLEFCODEID']),
    );
  }
}

//------------>  GameMasters N°2
class PhotoCat {
  String photocat = "XXXX";
  String photocast = "XXXX";
  int nbphotos = 0;
  int selected = 0;
  int firstphotoid = 0;

  PhotoCat({
    required this.photocat,
  });

  factory PhotoCat.fromJson(Map<String, dynamic> json) {
    return PhotoCat(
      photocat: json['PHOTOCAT'] as String,
    );
  }

  supMM() {
    photocast = photocat.substring(3);
  }

  setphotoid(_thatphotoid) {
    firstphotoid = _thatphotoid;
  }

  setSelected(int _selected) {
    selected = _selected;
  }

  setNumber(int _number) {
    nbphotos = _number;
  }
}

class PhotoRandomLive {
  int photoid = 0;
  String photomemelive = "XXXX";

  PhotoRandomLive({
    required this.photoid,
    required this.photomemelive,
  });
}

class Memoto {
  // En cours
  int memostockid = 0;
  String memostock = "..";
  String memocat = "..";

  Memoto({
    required this.memostockid,
    required this.memostock,
    required this.memocat,
  });

  factory Memoto.fromJson(Map<String, dynamic> json) {
    return Memoto(
      memostockid: int.parse(json['MEMOSTOCKID']),
      memostock: json['MEMOSTOCK'] as String,
      memocat: json['MEMOCAT'] as String,
    );
  }
}

///PHOTOID | MEMOSTOCKID | PHOTOFILENAME                  | PHOTOFILETYPE | MEMOSTOCK
class MemoLike {
  // En cours
  int memolikeid=0;
  int memostockid = 0;
  int photoid = 0;
  String memostock = "..";
  String photofilename = "FFFF";
  String photofiletype = "TTT";
  String memolikeuser = "MEMOLIKEUSER";

  MemoLike(
      {required this.memolikeid,
        required this.memostockid,
      required this.photoid,
      required this.memostock,
      required this.photofilename,
      required this.photofiletype,
      required this.memolikeuser});

  factory MemoLike.fromJson(Map<String, dynamic> json) {
    return MemoLike(
      memolikeid: int.parse(json['MEMOLIKEID']),
      memostockid: int.parse(json['MEMOSTOCKID']),
      photoid: int.parse(json['PHOTOID']),
      memostock: json['MEMOSTOCK'] as String,
      photofilename: json['PHOTOFILENAME'] as String,
      photofiletype: json['PHOTOFILETYPE'] as String,
      memolikeuser: json['MEMOLIKEUSER'] as String,
    );
  }
}

class MemopolUsers {
  int uid = 0;
  int ustatus = 0;
  int uprofile = 0;
  String uname = "UNAMEX";
  String upass = "PASSWX";
  String upseudo = "AAAAX";
  String umail = "AAA@WW.ZZZ";
  String uipcreate = "FF.FF.FF.FF.FF";
  String uiptoday = "FF.FF.FF.FF.FF";
  String ucdate = "06-06-2022";
  String uldate = "06-06-2022";
  String messadmin = "";

  // 64  Admin 32  Game Manager  16 Game User  4 Invited 2 nothing bit 1 : O  =0
  MemopolUsers(
      {required this.uid,
      required this.ustatus,
      required this.uprofile,
      required this.uname,
      required this.upass,
      required this.upseudo,
      required this.umail,
      required this.uipcreate,
      required this.uiptoday,
      required this.ucdate,
      required this.uldate,
      required this.messadmin});

  factory MemopolUsers.fromJson(Map<String, dynamic> json) {
    return MemopolUsers(
      uid: int.parse(json['UID']),
      ustatus: int.parse(json['USTATUS']),
      uprofile: int.parse(json['UPROFILE']),
      uname: json['UNAME'] as String,
      upass: json['UPASS'] as String,
      upseudo: json['UPSEUDO'] as String,
      umail: json['UMAIL'] as String,
      uipcreate: json['UIPCREATE'] as String,
      uiptoday: json['UIPTODAY'] as String,
      ucdate: json['UCDATE'] as String,
      uldate: json['ULDATE'] as String,
      messadmin: json['MESSADMIN'] as String,
    );
  }
}

class CheckVote {
  int cosum = 0;


  CheckVote({
    required this.cosum,

  });

  factory CheckVote.fromJson(Map<String, dynamic> json) {
    return CheckVote(
      cosum: int.parse(json['COSUM']),

    );
  }


}

class CheckVotePlus {
  //
  // SELECT MEMOLIKEID ,MLVPOINTS, COUNT(MLVPOINTS) AS 'CUMU'
  // from MEMOLIKEVOTE GROUP BY MEMOLIKEID,MLVPOINTS
  // order by MEMOLIKEID,MLVPOINTS;
  int memolikeid = 0;
  int mlvpoints =0;
  int cumu=0; //nb Votes avec cette nore

CheckVotePlus({
required this.memolikeid,
required this.mlvpoints,
required this.cumu
  });

  factory CheckVotePlus.fromJson(Map<String, dynamic> json) {
    return CheckVotePlus(
      memolikeid: int.parse(json['MEMOLIKEID']),
      mlvpoints: int.parse(json['MLVPOINTS']),
      cumu: int.parse(json['CUMU']),

    );
  }


}
