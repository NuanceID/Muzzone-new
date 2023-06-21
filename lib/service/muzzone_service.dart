// To parse this JSON data, do
//
//     final track = trackFromJson(jsonString);

import 'dart:convert';

Track trackFromJson(String str) => Track.fromJson(json.decode(str));

String trackToJson(Track data) => json.encode(data.toJson());

class Track {
  Track({
    required this.id,
    required this.type,
    required this.name,
    required this.image,
    required this.link,
    this.trackPopular = false,
    this.trackNew = false,
    required this.artist,
    this.album,
    this.playlists,
    this.genres,
  });

  int id;
  String type;
  String name;
  String image;
  String link;
  bool? trackPopular;
  bool? trackNew;
  Album artist;
  Album? album;
  List<Album>? playlists;
  List<Album>? genres;

  factory Track.fromJson(Map<String, dynamic> json) => Track(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        image: json["image"],
        link: json["link"],
        trackPopular: json["trackPopular"],
        trackNew: json["trackNew"],
        artist: Album.fromJson(json["artist"]),
        album: Album.fromJson(json["album"]),
        playlists:
            List<Album>.from(json["playlists"].map((x) => Album.fromJson(x))),
        genres: List<Album>.from(json["genres"].map((x) => Album.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "name": name,
        "image": image,
        "link": link,
        "trackPopular": trackPopular,
        "trackNew": trackNew,
        "artist": artist.toJson(),
        "album": album!.toJson(),
        "playlists": List<dynamic>.from(playlists!.map((x) => x.toJson())),
        "genres": List<dynamic>.from(genres!.map((x) => x.toJson())),
      };
}

class Album {
  Album({
    required this.id,
    required this.type,
    required this.name,
    required this.image,
    required this.tracklist,
  });

  int id;
  String type;
  String name;
  String image;
  List<int> tracklist;

  factory Album.fromJson(Map<String, dynamic> json) => Album(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        image: json["image"],
        tracklist: List<int>.from(json["tracklist"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "name": name,
        "image": image,
        "tracklist": tracklist == null
            ? null
            : List<dynamic>.from(tracklist.map((x) => x)),
      };
}

var ttt = {
  "id": 0,
  "type": "track",
  "name": "Znaesh li ti",
  "image": "maksim_znaesh_li_ty_image",
  "link": "https//",
  "trackPopular": false,
  "trackNew": true,
  "artist": {
    "id": 10,
    "type": "artist",
    "name": "Maksim",
    "image": "https.image",
    "tracklist": [234, 1, 23]
  },
  "album": {
    "id": 20,
    "type": "album",
    "name": "name",
    "image": "image",
    "tracklist": [22, 55, 34]
  },
  "playlists": [
    {"id": 30, "type": "playlist", "name": "best russia", "image": "http//"},
    {}
  ],
  "genres": [
    {"id": 40, "type": "genre", "image": "https//image", "name": "rus"},
    {}
  ]
};
