import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:muzzone/config/network_state/network_state.dart';
import 'package:muzzone/data/remote_data_store/remote_api.dart';

class BackendRepository {
  BackendRepository();

  Future<NetworkState<Response>> getAlbums(String accessToken) async {
    try {
      Response albumsResponse = await RemoteApi().getAlbums(accessToken);
      if(albumsResponse.statusCode == 200){
        return NetworkStateSuccess(albumsResponse);
      }else{
        return const NetworkStateFailed('Network failed');
      }
    } catch (_) {
      return const NetworkStateFailed('Network failed');
    }
  }

  Future<NetworkState<Response>> getAlbum(String accessToken, String album) async {
    try {
      Response albumResponse = await RemoteApi().getAlbum(accessToken, album);
      if(albumResponse.statusCode == 200){
        return NetworkStateSuccess(albumResponse);
      }else{
        return const NetworkStateFailed('Network failed');
      }
    } catch (_) {
      return const NetworkStateFailed('Network failed');
    }
  }

  Future<NetworkState<Response>> getArtists(String accessToken) async {
    try {
      Response artistsResponse = await RemoteApi().getArtists(accessToken);
      if(artistsResponse.statusCode == 200){
        return NetworkStateSuccess(artistsResponse);
      }else{
        return const NetworkStateFailed('Network failed');
      }
    } catch (_) {
      return const NetworkStateFailed('Network failed');
    }
  }

  Future<NetworkState<Response>> getArtist(String accessToken, String artist) async {
    try {
      Response artistResponse = await RemoteApi().getArtist(accessToken, artist);
      if(artistResponse.statusCode == 200){
        return NetworkStateSuccess(artistResponse);
      }else{
        return const NetworkStateFailed('Network failed');
      }
    } catch (_) {
      return const NetworkStateFailed('Network failed');
    }
  }

  Future<NetworkState<Response>> getCategories(String accessToken) async {
    try {
      Response categoriesResponse = await RemoteApi().getCategories(accessToken);
      if(categoriesResponse.statusCode == 200){
        return NetworkStateSuccess(categoriesResponse);
      }else{
        return const NetworkStateFailed('Network failed');
      }
    } catch (_) {
      return const NetworkStateFailed('Network failed');
    }
  }

  Future<NetworkState<Response>> getCategory(String accessToken, String category) async {
    try {
      Response categoryResponse = await RemoteApi().getCategory(accessToken, category);
      if(categoryResponse.statusCode == 200){
        return NetworkStateSuccess(categoryResponse);
      }else{
        return const NetworkStateFailed('Network failed');
      }
    } catch (_) {
      return const NetworkStateFailed('Network failed');
    }
  }

  Future<NetworkState<Response>> getGenres(String accessToken) async {
    try {
      Response genresResponse = await RemoteApi().getGenres(accessToken);
      if(genresResponse.statusCode == 200){
        return NetworkStateSuccess(genresResponse);
      }else{
        return const NetworkStateFailed('Network failed');
      }
    } catch (_) {
      return const NetworkStateFailed('Network failed');
    }
  }

  Future<NetworkState<Response>> getGenre(String accessToken, String genre) async {
    try {
      Response genreResponse = await RemoteApi().getGenre(accessToken, genre);
      if(genreResponse.statusCode == 200){
        return NetworkStateSuccess(genreResponse);
      }else{
        return const NetworkStateFailed('Network failed');
      }
    } catch (_) {
      return const NetworkStateFailed('Network failed');
    }
  }

  Future<NetworkState<Response>> postLogin(String phoneNumber) async {
    try {
      Response loginResponse = await RemoteApi().postLogin(phoneNumber);
      if(loginResponse.statusCode == 200){
        return NetworkStateSuccess(loginResponse);
      }else{
        return const NetworkStateFailed('Network failed');
      }
    } catch (_) {
      return const NetworkStateFailed('Network failed');
    }
  }

  Future<NetworkState<Response>> getPlaylists(String accessToken) async {
    try {
      Response playlistsResponse = await RemoteApi().getPlaylists(accessToken);
      if(playlistsResponse.statusCode == 200){
        return NetworkStateSuccess(playlistsResponse);
      }else{
        return const NetworkStateFailed('Network failed');
      }
    } catch (_) {
      return const NetworkStateFailed('Network failed');
    }
  }

  Future<NetworkState<Response>> getPlaylist(String accessToken, String playlist) async {
    try {
      Response playlistResponse = await RemoteApi().getPlaylist(accessToken, playlist);
      if(playlistResponse.statusCode == 200){
        return NetworkStateSuccess(playlistResponse);
      }else{
        return const NetworkStateFailed('Network failed');
      }
    } catch (_) {
      return const NetworkStateFailed('Network failed');
    }
  }

  Future<NetworkState<Response>> postSmsCheck(String phoneNumber, String authCode) async {
    try {
      Response smsCheckResponse = await RemoteApi().postSmsCheck(phoneNumber, authCode);
      if(smsCheckResponse.statusCode == 200){
        return NetworkStateSuccess(smsCheckResponse);
      }else{
        return const NetworkStateFailed('Network failed');
      }
    } catch (_) {
      return const NetworkStateFailed('Network failed');
    }
  }

  Future<NetworkState<Response>> getTracks(String accessToken) async {
    try {
      Response tracksResponse = await RemoteApi().getTracks(accessToken);
      if(tracksResponse.statusCode == 200){
        return NetworkStateSuccess(tracksResponse);
      }else{
        return const NetworkStateFailed('Network failed');
      }
    } catch (_) {
      return const NetworkStateFailed('Network failed');
    }
  }

  Future<NetworkState<Response>> getTrack(String accessToken, String track) async {
    try {
      Response trackResponse = await RemoteApi().getTrack(accessToken, track);
      if(trackResponse.statusCode == 200){
        return NetworkStateSuccess(trackResponse);
      }else{
        return const NetworkStateFailed('Network failed');
      }
    } catch (_) {
      return const NetworkStateFailed('Network failed');
    }
  }

  Future<NetworkState<Response>> getMoreGenres(String accessToken, String page) async {
    try {
      Response genresResponse = await RemoteApi().getMoreGenres(accessToken, page);
      if(genresResponse.statusCode == 200){
        return NetworkStateSuccess(genresResponse);
      }else{
        return const NetworkStateFailed('Network failed');
      }
    } catch (_) {
      return const NetworkStateFailed('Network failed');
    }
  }

  Future<NetworkState<Response>> getMorePlaylists(String accessToken, String page) async {
    try {
      Response playlistsResponse = await RemoteApi().getMorePlaylists(accessToken, page);
      if(playlistsResponse.statusCode == 200){
        return NetworkStateSuccess(playlistsResponse);
      }else{
        return const NetworkStateFailed('Network failed');
      }
    } catch (_) {
      return const NetworkStateFailed('Network failed');
    }
  }

  Future<NetworkState<Response>> getMoreAlbums(String accessToken, String page) async {
    try {
      Response albumsResponse = await RemoteApi().getMoreAlbums(accessToken, page);
      if(albumsResponse.statusCode == 200){
        return NetworkStateSuccess(albumsResponse);
      }else{
        return const NetworkStateFailed('Network failed');
      }
    } catch (_) {
      return const NetworkStateFailed('Network failed');
    }
  }

  Future<NetworkState<Response>> getMoreCategories(String accessToken, String page) async {
    try {
      Response categoriesResponse = await RemoteApi().getMoreCategories(accessToken, page);
      if(categoriesResponse.statusCode == 200){
        return NetworkStateSuccess(categoriesResponse);
      }else{
        return const NetworkStateFailed('Network failed');
      }
    } catch (_) {
      return const NetworkStateFailed('Network failed');
    }
  }

  Future<NetworkState<Response>> getMoreArtists(String accessToken, String page) async {
    try {
      Response artistsResponse = await RemoteApi().getMoreArtists(accessToken, page);
      if(artistsResponse.statusCode == 200){
        return NetworkStateSuccess(artistsResponse);
      }else{
        return const NetworkStateFailed('Network failed');
      }
    } catch (_) {
      return const NetworkStateFailed('Network failed');
    }
  }

  Future<NetworkState<Response>> getMoreTracks(String accessToken, String page) async {
    try {
      Response tracksResponse = await RemoteApi().getMoreTracks(accessToken, page);
      if(tracksResponse.statusCode == 200){
        return NetworkStateSuccess(tracksResponse);
      }else{
        return const NetworkStateFailed('Network failed');
      }
    } catch (_) {
      return const NetworkStateFailed('Network failed');
    }
  }


  Future<NetworkState<Response>> getFindArtist(String accessToken, String name) async {
    try {
      Response artistResponse = await RemoteApi().getFindArtist(accessToken, name);
      if(artistResponse.statusCode == 200){
        return NetworkStateSuccess(artistResponse);
      }else{
        return const NetworkStateFailed('Network failed');
      }
    } catch (_) {
      return const NetworkStateFailed('Network failed');
    }
  }

  Future<NetworkState<Response>> getFindTrack(String accessToken, String name) async {
    try {
      Response trackResponse = await RemoteApi().getFindTrack(accessToken, name);
      if(trackResponse.statusCode == 200){
        return NetworkStateSuccess(trackResponse);
      }else{
        return const NetworkStateFailed('Network failed');
      }
    } catch (_) {
      return const NetworkStateFailed('Network failed');
    }
  }

  Future<NetworkState<Response>> getFindGenre(String accessToken, String name) async {
    try {
      Response genreResponse = await RemoteApi().getFindGenre(accessToken, name);
      if(genreResponse.statusCode == 200){
        return NetworkStateSuccess(genreResponse);
      }else{
        return const NetworkStateFailed('Network failed');
      }
    } catch (_) {
      return const NetworkStateFailed('Network failed');
    }
  }

  Future<NetworkState<Response>> getFindCategory(String accessToken, String name) async {
    try {
      Response categoryResponse = await RemoteApi().getFindCategory(accessToken, name);
      if(categoryResponse.statusCode == 200){
        return NetworkStateSuccess(categoryResponse);
      }else{
        return const NetworkStateFailed('Network failed');
      }
    } catch (_) {
      return const NetworkStateFailed('Network failed');
    }
  }

  Future<NetworkState<Response>> getFindBackendPlaylist(String accessToken, String name) async {
    try {
      Response playlistResponse = await RemoteApi().getFindBackendPlaylist(accessToken, name);
      if(playlistResponse.statusCode == 200){
        return NetworkStateSuccess(playlistResponse);
      }else{
        return const NetworkStateFailed('Network failed');
      }
    } catch (_) {
      return const NetworkStateFailed('Network failed');
    }
  }

  Future<NetworkState<Response>> getFindAlbum(String accessToken, String name) async {
    try {
      Response albumResponse = await RemoteApi().getFindAlbum(accessToken, name);
      if(albumResponse.statusCode == 200){
        return NetworkStateSuccess(albumResponse);
      }else{
        return const NetworkStateFailed('Network failed');
      }
    } catch (_) {
      return const NetworkStateFailed('Network failed');
    }
  }

  String _prettyPrint(Map<String, dynamic> json) {
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
    String pretty = encoder.convert(json);
    return pretty;
  }
}