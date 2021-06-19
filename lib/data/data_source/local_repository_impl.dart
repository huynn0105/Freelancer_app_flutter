import 'dart:convert';
import 'package:freelance_app/domain/models/account.dart';
import 'package:freelance_app/domain/repositories/local_storage_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _pref_token = 'TOKEN';
const _pref_login = 'LOGIN';



class LocalRepositoryImpl extends LocalRepositoryInterface {
  @override
  Future<void> clearData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(_pref_token);
    sharedPreferences.remove(_pref_login);

  }

  @override
  Future<String> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_pref_token);
  }

  @override
  Future<String> saveToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_pref_token, token);
    return token;
  }



  @override
  Future saveAccount(Account account) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var rs =  pref.setString(_pref_login, jsonEncode(account));
  }

  @override
  Future<Account> getAccount() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var account = pref.getString(_pref_login);
    if (account != null) {
      var a = Account.fromJson(jsonDecode(account));
      return a;
    }
    return null;
  }


}
