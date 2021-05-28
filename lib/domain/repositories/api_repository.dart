import 'package:freelance_app/domain/models/account.dart';
import 'package:freelance_app/domain/models/capacity_profile.dart';
import 'package:freelance_app/domain/requests/account_request.dart';
import 'package:freelance_app/domain/requests/image_request.dart';
import 'package:freelance_app/domain/requests/login_request.dart';
import 'package:freelance_app/domain/requests/offer_request.dart';
import 'package:freelance_app/domain/requests/post_job_request.dart';
import 'package:freelance_app/domain/requests/register_request.dart';

abstract class ApiRepositoryInterface{

  Future<Account> getAccountFromToken();
  Future<dynamic> login(LoginRequest loginRequest);
  Future<void> logout();
  Future<dynamic> register(RegisterRequest registerRequest);
  Future<dynamic> uploadAvatar(ImageRequest imageRequest);
  Future<dynamic> updateProfile(Account account);
  Future<dynamic> getSpecialties();
  Future<dynamic> postJob(PostJobRequest postJobRequest);
  Future<dynamic> getJobs();
  Future<dynamic> getJobFromId(int id);
  Future<dynamic> getTypeOfWorks();
  Future<dynamic> getSkills();
  Future<dynamic> getPayForms();
  Future<dynamic> getFormOfWorks();
  Future<dynamic> getServices();
  Future<dynamic> getSpecialtyServices(int specialtyId);
  Future<dynamic> getProvinces();
  Future<dynamic> getLevels();
  Future<dynamic> putAccount(int id, AccountRequest request);
  Future<dynamic> postCapacityProfile(CapacityProfile capacityProfile);
  Future<dynamic> putCapacityProfile(int id,CapacityProfile capacityProfile);
  Future<dynamic> getCapacityProfiles(int freelancerId);
  Future<dynamic> getAccounts();
  Future<dynamic> getAccountFromId(int id);
  Future<dynamic> postOfferHistories(OfferRequest offerRequest);

}