import 'package:localstorage/localstorage.dart';

class Storage {
  static LocalStorage localStorage = LocalStorage('quizcraft_user_info.json');

  static Future<void> createTokens() async {
    await localStorage.ready;
    localStorage.setItem('tokens', <String, dynamic>{});
  }

  static Future<void> deleteTokens() async {
    await localStorage.ready;
    if (localStorage.getItem('tokens') == null) {
      await createTokens();
    }
    await localStorage.deleteItem('tokens');
  }

  static Future<void> updateRefresh(String refresh) async {
    await localStorage.ready;
    if (localStorage.getItem('tokens') == null) {
      await createTokens();
    }
    Map<String, dynamic> m = localStorage.getItem('tokens');
    m['refresh'] = refresh;
    await localStorage.setItem('tokens', m);
    print('updateRefresh. Success');
  }

  static Future<void> updateAccess(String access) async {
    await localStorage.ready;
    if (localStorage.getItem('tokens') == null) {
      await createTokens();
    }
    Map<String, dynamic> m = localStorage.getItem('tokens');
    m['access'] = access;
    await localStorage.setItem('tokens', m);
    print('updateAccess. Success');
  }

  static Future<String> getRefresh() async {
    await localStorage.ready;
    if (localStorage.getItem('tokens') == null) {
      await createTokens();
    }
    Map<String, dynamic> m = localStorage.getItem('tokens');
    return m['refresh'];
  }

  static Future<String> getAccess() async {
    await localStorage.ready;
    if (localStorage.getItem('tokens') == null) {
      await createTokens();
    }
    Map<String, dynamic> m = localStorage.getItem('tokens');
    return m['access'];
  }
}
