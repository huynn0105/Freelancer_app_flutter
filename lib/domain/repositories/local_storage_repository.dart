import 'package:freelance_app/domain/models/account.dart';

abstract class LocalRepositoryInterface{
  Future<String> getToken();
  Future<void> clearData();
  Future<String> saveToken(String token);
  Future saveAccount(Account account);
  Future<Account> getAccount();
}