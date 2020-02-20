import 'package:flutter/material.dart';

class Player {
  String name;
  String id;
  String response;
  bool ready;
  int score;

  Player({
    @required this.name,
    this.id,
    this.response = '',
    this.ready: false,
    this.score = 0
  });

  Player.fromJson(Map data) {
    this.id = data['id'];
    this.name = data['name'];
    this.response = data['response'];
    this.ready = data['ready'];
    this.score = data['score'];
  }
}

enum GameStatus {
  lobby,
  writing,
  voting,
  scoreboard,
  finished
}

class GameState {
  bool owner;
  String pin;
  Player you;
  String imageUrl;
  Map<String, Player> players;
  int round;
  GameStatus status;
  Function(String, Map<String, dynamic>) send;

  GameState({
    this.pin,
    this.you,
    this.imageUrl,
    this.owner,
    this.round,
    this.status,
    @required this.players,
    @required this.send
  });

  GameState updateWith(data) {
    print(data['status']);
    this.pin = data['pin'];
    this.owner = data['owner'] == (this.you?.id)?? false;
    this.imageUrl = data['imageUrl'];
    this.players = Map<String, Object>.from(data['players']).map((k, v) => MapEntry(k, Player.fromJson(v)));
    this.round = data['round'];
    this.status = GameStatus.values[data['status']];

    return this;
  }
}