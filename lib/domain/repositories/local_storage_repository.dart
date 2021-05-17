import 'package:freelance_app/domain/models/account.dart';

abstract class LocalRepositoryInterface{
  Future<String> getToken();
  Future<void> clearAllData();
  Future saveAccount(Account account);
  Future<Account> getAccount();
  Future<String> saveToken(String token);
}