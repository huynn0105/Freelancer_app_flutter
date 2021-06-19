import 'package:freelance_app/domain/models/account.dart';
import 'package:freelance_app/domain/models/capacity_profile.dart';
import 'package:freelance_app/domain/models/service.dart';
import 'package:freelance_app/domain/models/specialty.dart';
import 'package:freelance_app/domain/requests/account_request.dart';
import 'package:freelance_app/domain/requests/bank_account_request.dart';
import 'package:freelance_app/domain/requests/image_request.dart';
import 'package:freelance_app/domain/requests/login_request.dart';
import 'package:freelance_app/domain/requests/offer_request.dart';
import 'package:freelance_app/domain/requests/post_job_request.dart';
import 'package:freelance_app/domain/requests/rating_request.dart';
import 'package:freelance_app/domain/requests/register_request.dart';
import 'package:freelance_app/domain/requests/search_request.dart';

abstract class ApiRepositoryInterface{

  Future<Account> getAccountFromToken();
  Future<dynamic> login(LoginRequest loginRequest);
  Future<void> logout();
  Future<dynamic> register(RegisterRequest registerRequest);
  Future<dynamic> uploadAvatar(ImageRequest imageRequest);
  Future<dynamic> updateProfile(Account account);
  Future<dynamic> getSpecialties();
  Future<dynamic> postSpecialty(String name,String imageName, String imageBase64, List<Service> services);
  Future<dynamic> putSpecialty(int id, String name,String imageName, String imageBase64,List<Service> services);
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
  Future<dynamic> deleteCapacityProfile(int capacityProfileId);
  Future<dynamic> getAccounts();
  Future<dynamic> getAccountFromId(int id);
  Future<dynamic> postOfferHistories(OfferRequest offerRequest);
  Future<dynamic> getJobRenters(int id);
  Future<dynamic> getJobRentersWaiting(int id);
  Future<dynamic> getJobRentersInProgress(int id);
  Future<dynamic> getJobRentersPast(int id);
  Future<dynamic> getJobFreelancers(int id);
  Future<dynamic> getJobFreelancersInProgress(int id);
  Future<dynamic> getJobFreelancersPast(int id);
  Future<dynamic> getOfferHistories(int id);
  Future<dynamic> putOnReady(int id);
  Future<dynamic> getBanks();
  Future<dynamic> getBankAccounts();
  Future<dynamic> postBankAccounts(BankAccountRequest request);
  Future<dynamic> postSkill(String name);
  Future<dynamic> putSkill(int id,String name);
  Future<dynamic> postService(String name, List<Specialty> specialties);
  Future<dynamic> putService(int id, String name, List<Specialty> specialties);
  Future<dynamic> searchJob(SearchRequest request);
  Future<dynamic> searchFreelancer(SearchRequest request);
  Future<dynamic> getJobOffer(int id);
  Future<dynamic> putJobOfferChoose(int jobId, int freelancerId);
  Future<dynamic> postRating(RatingRequest request);
  Future<dynamic> putJobClose(int id);
  Future<dynamic> putJobRequestFinish(int id);
  Future<dynamic> putJobRequestRework(int id);
  Future<dynamic> putJobDone(int id);
  Future<dynamic> putJobCancel(int id);
  Future<dynamic> getMessageUser();
  Future<dynamic> getMessageChat(int jobId, int freelancerId);



}