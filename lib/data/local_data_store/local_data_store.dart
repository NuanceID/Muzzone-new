import 'package:shared_preferences/shared_preferences.dart';

class LocalDataStore {
  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ?? await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  static Future<SharedPreferences?> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  final String _kNotificationTime = 'NOTIFICATION_TIME';
  final String _kTimerVolumeMusic = 'TIMER_VOLUME_MUSIC';
  final String _kTheme = 'THEME';
  final String _kNeedOnboard = 'NEED_ONBOARD';
  final String _kAvatarImagePath = 'AVATAR_IMAGE_PATH';
  final String _kRegisterDate = 'REGISTER_DATE';
  final String _kUserName = 'USER_NAME';
  final String _kPhoneNumber = 'PHONE_NUMBER';
  final String _kDurationTimeBetweenPress = 'DURATION_TIME_BETWEEN_PRESS';

  void setDurationTimeBetweenPress(String duration) async {
    await _prefsInstance?.setString(_kDurationTimeBetweenPress, duration);
  }

  String getDurationTimeBetweenPress() {
    return _prefsInstance?.getString(_kDurationTimeBetweenPress) ?? '';
  }

  void setUserName(String name) {
    _prefsInstance?.setString(_kUserName, name);
  }

  String getUserName() {
    return _prefsInstance?.getString(_kUserName) ?? 'Пользователь';
  }

  void setPhoneNumber(String phone) async {
    await _prefsInstance?.setString(_kPhoneNumber, phone);
  }

  String getPhoneNumber() {
    return _prefsInstance?.getString(_kPhoneNumber) ?? '+998 000 00 00';
  }

  void setRegisterDate(String registerDate) async {
    await _prefsInstance?.setString(_kRegisterDate, registerDate);
  }

  String getRegisterDate() {
    return _prefsInstance?.getString(_kRegisterDate) ??
        'firstStart';
  }

  void setAvatarImagePath(String path) async {
    await _prefsInstance?.setString(_kAvatarImagePath, path);
  }

  String getAvatarImagePath() {
    return _prefsInstance?.getString(_kAvatarImagePath) ?? '';
  }

  void setNeedOnboard(bool needOnboard) async {
    await _prefsInstance?.setBool(_kNeedOnboard, needOnboard);
  }

  bool getNeedOnboard() {
    return _prefsInstance?.getBool(_kNeedOnboard) ?? true;
  }

  void setTheme(bool isLightTheme) async {
    await _prefsInstance?.setBool(_kTheme, isLightTheme);
  }

  bool getTheme() {
    return _prefsInstance?.getBool(_kTheme) ?? true;
  }

  void setTimerVolumeMusic(double volume) async {
    await _prefsInstance?.setDouble(_kTimerVolumeMusic, volume);
  }

  double getTimerVolumeMusic() {
    return _prefsInstance?.getDouble(_kTimerVolumeMusic) ?? 0.0;
  }

  void removeTimerDuration() async {
    await _prefsInstance?.remove("TIMER_DURATION");
  }

  void setNotificationTime(String notificationTime) async {
    await _prefsInstance?.setString(_kNotificationTime, notificationTime);
  }

  String getNotificationTime() {
    return _prefsInstance?.getString(_kNotificationTime) ??
        '2022-10-06 00:00:00.000';
  }

  void removeNotificationTime() async {
    await _prefsInstance?.remove('NOTIFICATION_TIME');
  }

  final String _kFavouriteSongsList = 'FAVOURITE_SONGS';

  List<int> getFavouriteSongsList() {
    return _prefsInstance
        ?.getStringList(_kFavouriteSongsList)
        ?.map((e) => int.parse(e))
        .toList() ??
        [];
  }

  void setFavouriteSongsList(List<int> value) async {
    await _prefsInstance?.setStringList(
        _kFavouriteSongsList, value.map((e) => e.toString()).toList());
  }

  void removeFavouriteList() async {
    await _prefsInstance?.remove('FAVOURITE_SONGS');
  }

  void removeNotificationDaysList() async {
    await _prefsInstance?.remove('FAVOURITE_SONGS');
  }
}
