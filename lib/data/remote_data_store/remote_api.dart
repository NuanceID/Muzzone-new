import 'package:dio/dio.dart';
import 'package:muzzone/config/constants/constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class RemoteApi {
  static final dio = Dio();

  static final RemoteApi _remoteApiInstance = RemoteApi._internal();

  factory RemoteApi() {
    return _remoteApiInstance;
  }

  RemoteApi._internal() {
    dio.options.baseUrl = BASE_URL;
    dio.options.connectTimeout = const Duration(seconds: 150);
    dio.options.receiveTimeout = const Duration(seconds: 150);

    dio.options.headers = {
      'Accept': 'application/json',
      'Accept-Encoding': 'application/json'
    };

    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
        maxWidth: 90));
  }

  Future<Response> getAlbums(String accessToken) async {
    dio.options.headers = {'Authorization': 'Bearer $accessToken'};

    Response response = await dio.get('/api/v1/');
    return response;
  }

  Future<Response> getAlbum(String accessToken, String album) async {
    dio.options.headers = {'Authorization': 'Bearer $accessToken'};

    Response response = await dio.get('/api/v1/albums/$album');
    return response;
  }

  Future<Response> getArtists(String accessToken) async {
    dio.options.headers = {'Authorization': 'Bearer $accessToken'};

    Response response = await dio.get('/api/v1/artists');
    return response;
  }

  Future<Response> getArtist(String accessToken, String artist) async {
    dio.options.headers = {'Authorization': 'Bearer $accessToken'};

    Response response = await dio.get('/api/v1/artists/$artist');
    return response;
  }

  Future<Response> getCategories(String accessToken) async {
    dio.options.headers = {'Authorization': 'Bearer $accessToken'};

    Response response = await dio.get('/api/v1/categories');
    return response;
  }

  Future<Response> getCategory(String accessToken, String category) async {
    dio.options.headers = {'Authorization': 'Bearer $accessToken'};

    Response response = await dio.get('/api/v1/categories/$category');
    return response;
  }

  Future<Response> getGenres(String accessToken) async {
    dio.options.headers = {'Authorization': 'Bearer $accessToken'};

    Response response = await dio.get('/api/v1/genres');
    return response;
  }

  Future<Response> getGenre(String accessToken, String genre) async {
    dio.options.headers = {'Authorization': 'Bearer $accessToken'};

    Response response = await dio.get('/api/v1/genres/$genre');
    return response;
  }

  Future<Response> postLogin(String phoneNumber) async {
    Response response =
        await dio.post('/api/v1/login', data: {'phone': phoneNumber});
    return response;
  }

  Future<Response> getPlaylists(String accessToken) async {
    dio.options.headers = {'Authorization': 'Bearer $accessToken'};

    Response response = await dio.get('/api/v1/playlists');
    return response;
  }

  Future<Response> getPlaylist(String accessToken, String playlist) async {
    dio.options.headers = {'Authorization': 'Bearer $accessToken'};

    Response response = await dio.get('/api/v1/playlists/$playlist');
    return response;
  }

  Future<Response> postSmsCheck(String phoneNumber, String authCode) async {
    Response response = await dio.post('/api/v1/sms-check',
        data: {'phone': phoneNumber, 'auth_code': authCode});
    return response;
  }

  Future<Response> getTracks(String accessToken) async {
    dio.options.headers = {'Authorization': 'Bearer $accessToken'};

    Response response = await dio.get('/api/v1/tracks');
    return response;
  }

  Future<Response> getTrack(String accessToken, String track) async {
    dio.options.headers = {'Authorization': 'Bearer $accessToken'};

    Response response = await dio.get('/api/v1/tracks/$track');
    return response;
  }

  Future<Response> getMoreGenres(String accessToken, String page) async {
    dio.options.headers = {'Authorization': 'Bearer $accessToken'};

    Response response = await dio.get('/api/v1/genres?page=$page');
    return response;
  }

  Future<Response> getMorePlaylists(String accessToken, String page) async {
    dio.options.headers = {'Authorization': 'Bearer $accessToken'};

    Response response = await dio.get('/api/v1/playlists?page=$page');
    return response;
  }

  Future<Response> getMoreAlbums(String accessToken, String page) async {
    dio.options.headers = {'Authorization': 'Bearer $accessToken'};

    Response response = await dio.get('/api/v1/albums?page=$page');
    return response;
  }

  Future<Response> getMoreCategories(String accessToken, String page) async {
    dio.options.headers = {'Authorization': 'Bearer $accessToken'};

    Response response = await dio.get('/api/v1/categories?page=$page');
    return response;
  }

  Future<Response> getMoreArtists(String accessToken, String page) async {
    dio.options.headers = {'Authorization': 'Bearer $accessToken'};

    Response response = await dio.get('/api/v1/artists?page=$page');
    return response;
  }

  Future<Response> getMoreTracks(String accessToken, String page) async {
    dio.options.headers = {'Authorization': 'Bearer $accessToken'};

    Response response = await dio.get('/api/v1/tracks?page=$page');
    return response;
  }

  Future<Response> getFindArtist(String accessToken, String name) async {
    dio.options.headers = {'Authorization': 'Bearer $accessToken'};

    Response response = await dio.get('/api/v1/artists?name=$name');
    return response;
  }

  Future<Response> getFindTrack(String accessToken, String name) async {
    dio.options.headers = {'Authorization': 'Bearer $accessToken'};

    Response response = await dio.get('/api/v1/tracks?name=$name');
    return response;
  }

  Future<Response> getFindGenre(String accessToken, String name) async {
    dio.options.headers = {'Authorization': 'Bearer $accessToken'};

    Response response = await dio.get('/api/v1/genres?name=$name');
    return response;
  }

  Future<Response> getFindCategory(String accessToken, String name) async {
    dio.options.headers = {'Authorization': 'Bearer $accessToken'};

    Response response = await dio.get('/api/v1/categories?name=$name');
    return response;
  }

  Future<Response> getFindBackendPlaylist(String accessToken, String name) async {
    dio.options.headers = {'Authorization': 'Bearer $accessToken'};

    Response response = await dio.get('/api/v1/playlists?name=$name');
    return response;
  }

  Future<Response> getFindAlbum(String accessToken, String name) async {
    dio.options.headers = {'Authorization': 'Bearer $accessToken'};

    Response response = await dio.get('/api/v1/albums?name=$name');
    return response;
  }
}
