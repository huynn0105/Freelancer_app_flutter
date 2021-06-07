import 'dart:convert';
import 'package:freelance_app/domain/models/account.dart';
import 'package:freelance_app/domain/models/bank.dart';
import 'package:freelance_app/domain/models/capacity_profile.dart';
import 'package:freelance_app/domain/models/form_of_work.dart';
import 'package:freelance_app/domain/models/job.dart';
import 'package:freelance_app/domain/models/level.dart';
import 'package:freelance_app/domain/models/pay_form.dart';
import 'package:freelance_app/domain/models/payment_method.dart';
import 'package:freelance_app/domain/models/province.dart';
import 'package:freelance_app/domain/models/service.dart';
import 'package:freelance_app/domain/models/skill.dart';
import 'package:freelance_app/domain/models/specialty.dart';
import 'package:freelance_app/domain/models/type_of_work.dart';
import 'package:freelance_app/domain/repositories/api_repository.dart';
import 'package:freelance_app/domain/requests/account_request.dart';
import 'package:freelance_app/domain/requests/bank_account_request.dart';
import 'package:freelance_app/domain/requests/image_request.dart';
import 'package:freelance_app/domain/requests/login_request.dart';
import 'package:freelance_app/domain/requests/offer_request.dart';
import 'package:freelance_app/domain/requests/post_job_request.dart';
import 'package:freelance_app/domain/requests/register_request.dart';
import 'package:freelance_app/domain/services/http_service.dart';

class ApiRepositoryImpl extends ApiRepositoryInterface {
  @override
  Future<Account> getAccountFromToken() async {
    var rs = await HttpService.get('$ACCOUNT/fromtoken', bearerToken: TOKEN);
    print("codeAccount: ${rs.statusCode}");
    if (rs.statusCode == 200) {
      var jsonObject = jsonDecode(rs.body);
      Account account = Account.fromJson(jsonObject);
      return account;
    }
    return null;
  }

  @override
  Future login(LoginRequest loginRequest) async {
    Map<String, String> accountInput = {
      "email": loginRequest.username,
      "password": loginRequest.password
    };
    return await HttpService.post(LOGIN, accountInput);


  }

  @override
  Future<void> logout() async {
    print('remove token from server $TOKEN');
    return;
  }

  @override
  Future register(RegisterRequest registerRequest) async {
    Map<String, dynamic> accountInput = {
      'name': registerRequest.name,
      'phone': '0909091341',
      'email': registerRequest.email,
      'roleID': registerRequest.role,
      'password': registerRequest.password,
    };
    print('input: $accountInput');
    return await HttpService.post(REGISTER, accountInput);

  }

  @override
  Future uploadAvatar(ImageRequest imageRequest) async {
    Map<String, String> input = {
      'name': imageRequest.name,
      'imageBase64': imageRequest.imageBase64
    };

    var rs = await HttpService.post(AVATAR, input, bearerToken: TOKEN);
    print('codeAvatar ${rs.statusCode}');
    if (rs.statusCode == 200) {
      var jsonObject = jsonDecode(rs.body);
      return jsonObject['url'];
    }
    return null;
  }

  @override
  Future updateProfile(Account account) async {
    Map<String, dynamic> parameters = {
      'id': account.id,
    };
    var rs = await HttpService.put(
        ACCOUNT, body: account.toJson(), bearerToken: TOKEN, parameters: parameters);
    print('codeUpdateProfile ${rs.statusCode}');
  }

  @override
  Future getSpecialties() async {
    var rs = await HttpService.get(SPECIALTIES, bearerToken: TOKEN);
    print('codeSpecialties ${rs.statusCode}');
    if (rs.statusCode == 200) {
      var jsonList = jsonDecode(rs.body) as List;
      var specialties = jsonList.map((e) => Specialty.fromJson(e)).toList();
      return specialties;
    }
    return null;
  }


  @override
  Future getSpecialtyServices(int specialtyId) async {
    var rs = await HttpService.get('$SPECIALTIES/$specialtyId/services', bearerToken: TOKEN);
    print('codeSpecialtiesServices ${rs.statusCode}');
    if (rs.statusCode == 200) {
      var jsonList = jsonDecode(rs.body) as List;
      var services = jsonList.map((e) => Service.fromJson(e)).toList();
      return services;
    }
    return null;
  }

  @override
  Future getServices() async {
    var rs = await HttpService.get(SERVICE, bearerToken: TOKEN);
    print('codeServices: ${rs.statusCode}');
    if (rs.statusCode == 200) {
      var jsonList = jsonDecode(rs.body) as List;
      var services = jsonList.map((e) => Service.fromJsonNoValue(e)).toList();
      return services;
    }
    return null;
  }

  @override
  Future postJob(PostJobRequest postJobRequest) async {

    var rs = await HttpService.post(
        JOB, postJobRequest.toJson(), bearerToken: TOKEN);
    print('codeJob: ${rs.statusCode}');
    if(rs.statusCode==200)
      return true;
    return false;

  }

  @override
  Future getJobs() async {
    var rs = await HttpService.get(JOB, bearerToken: TOKEN);
    print('codeJobs: ${rs.statusCode}');
    if (rs.statusCode == 200) {
      var jsonList = jsonDecode(rs.body) as List;
      var jobs = jsonList.map((e) => Job.fromJson(e)).toList();
      return jobs;
    }
    return null;
  }
  @override
  Future getJobFromId(int id) async {
    var rs = await HttpService.get('$JOB/$id', bearerToken: TOKEN);
    print('codeJobId: ${rs.statusCode}');
    if (rs.statusCode == 200) {
      var jsonObject = jsonDecode(rs.body);
      var job = Job.fromJson(jsonObject);
      return job;
    }
    return null;
  }

  @override
  Future getFormOfWorks() async {
    var rs = await HttpService.get(FORM_OF_WORKS, bearerToken: TOKEN);
    print('codeFormOfWorks: ${rs.statusCode}');
    if (rs.statusCode == 200) {
      var jsonList = jsonDecode(rs.body) as List;
      var formOfWorks = jsonList.map((e) => FormOfWork.fromJson(e)).toList();
      return formOfWorks;
    }
    return null;
  }

  @override
  Future getPayForms() async {
    var rs = await HttpService.get(PAY_FORMS, bearerToken: TOKEN);
    print('codePayForms: ${rs.statusCode}');
    if (rs.statusCode == 200) {
      var jsonList = jsonDecode(rs.body) as List;
      var payForms = jsonList.map((e) => PayForm.fromJson(e)).toList();
      return payForms;
    }
    return null;
  }

  @override
  Future getSkills() async {
    var rs = await HttpService.get(SKILLS, bearerToken: TOKEN);
    print('codeSkill: ${rs.statusCode}');
    if (rs.statusCode == 200) {
      var jsonList = jsonDecode(rs.body) as List;
      var skills = jsonList.map((e) => Skill.fromJsonNoValue(e)).toList();
      return skills;
    }
    return null;
  }

  @override
  Future getTypeOfWorks() async {
    var rs = await HttpService.get(TYPE_OF_WORKS, bearerToken: TOKEN);
    print('codeTypeOfWorks: ${rs.statusCode}');
    if (rs.statusCode == 200) {
      var jsonList = jsonDecode(rs.body) as List;
      var typeOfWorks = jsonList.map((e) => TypeOfWork.fromJson(e)).toList();
      return typeOfWorks;
    }
    return null;
  }

  @override
  Future getProvinces() async {
    var rs = await HttpService.get(PROVINCES, bearerToken: TOKEN);
    print('codeProvinces ${rs.statusCode}');
    if (rs.statusCode == 200) {
      var jsonList = jsonDecode(rs.body) as List;
      var provinces = jsonList.map((e) => Province.fromJson(e)).toList();
      return provinces;
    }
    return null;
  }



  @override
  Future putAccount(int id, AccountRequest request) async {
    var rs = await HttpService.put('api/Accounts/$id', body: request.toJson(),bearerToken: TOKEN);
    print('putAccount ${request.toJson()}');
    print('codePutAccount ${rs.statusCode}');
  }

  @override
  Future putOnReady(int id) async {
    var rs = await HttpService.put('$ACCOUNT/$id/onready',bearerToken: TOKEN);
    print('code onReady ${rs.statusCode}');
  }

  @override
  Future getLevels() async {
    var rs = await HttpService.get(LEVELS, bearerToken: TOKEN);
    print('codeLV ${rs.statusCode}');
    if (rs.statusCode == 200) {
      var jsonList = jsonDecode(rs.body) as List;
      var level = jsonList.map((e) => Level.fromJson(e)).toList();
      return level;
    }
  }


  @override
  Future postCapacityProfile(CapacityProfile capacityProfile) async{
    var rs = await HttpService.post(CAPACITY_PROFILE,capacityProfile.toJson(), bearerToken: TOKEN);
    print('codeCapacityProfiles ${rs.statusCode}');
  }

  @override
  Future putCapacityProfile(int id,CapacityProfile capacityProfile) async{
    var rs = await HttpService.put('$CAPACITY_PROFILE/$id',body:capacityProfile.toJson(), bearerToken: TOKEN);
    print('js :${capacityProfile.imageName}');
    print('codeCapacityProfiles ${rs.statusCode}');
  }

  @override
  Future getCapacityProfiles(int freelancerId) async{
    var rs = await HttpService.get('$CAPACITY_PROFILE/freelancer/$freelancerId', bearerToken: TOKEN);
    print('codeCapacityProfiles ${rs.statusCode}');
    if (rs.statusCode == 200) {
      var jsonList = jsonDecode(rs.body) as List;
      var capacityProfiles = jsonList.map((e) => CapacityProfile.fromJson(e)).toList();
      return capacityProfiles;
    }
    return null;
  }

  @override
  Future getAccounts() async{
    var rs = await HttpService.get(ACCOUNT, bearerToken: TOKEN);
    print('codeAccounts ${rs.statusCode}');
    if(rs.statusCode == 200){
      var jsonList = jsonDecode(rs.body) as List;
      var accounts = jsonList.map((e) => Account.fromJson(e)).toList();
      return accounts;
    }
    return null;
  }

  @override
  Future getAccountFromId(int id) async {
    var rs = await HttpService.get('$ACCOUNT/$id', bearerToken: TOKEN);
    print('codeAccountId: ${rs.statusCode}');
    if (rs.statusCode == 200) {
      var jsonObject = jsonDecode(rs.body);
      var account = Account.fromJson(jsonObject);
      return account;
    }
    return null;
  }

  @override
  Future postOfferHistories(OfferRequest offerRequest)async {
    var rs = await HttpService.post(OFFER_HISTORIES,offerRequest.toJson(), bearerToken: TOKEN);
    print('codeOfferHistories ${rs.statusCode}');
    print('OfferHistories ${rs.body}');
  }

  @override
  Future deleteCapacityProfile(int capacityProfileId)async {
    var rs = await HttpService.get('$CAPACITY_PROFILE/$capacityProfileId', bearerToken: TOKEN);
    print('codeDeleteCap ${rs.statusCode}');
  }

  Future<dynamic> getJobRenters(int id) async{
    var rs = await HttpService.get('$ACCOUNT/$id/jobrenters', bearerToken: TOKEN);
    print('code Job Renter: ${rs.statusCode}');
    if (rs.statusCode == 200) {
      var jsonList = jsonDecode(rs.body) as List;
      var jobs = jsonList.map((e) => Job.fromJson(e)).toList();
      return jobs;
    }
    return null;
  }

  Future<dynamic> getJobRentersWaiting(int id) async{
    var rs = await HttpService.get('$ACCOUNT/$id/jobrenters/waiting', bearerToken: TOKEN);
    print('code Job Renter Waiting: ${rs.statusCode}');
    if (rs.statusCode == 200) {
      var jsonList = jsonDecode(rs.body) as List;
      var jobs = jsonList.map((e) => Job.fromJson(e)).toList();
      return jobs;
    }
    return null;
  }

  Future<dynamic> getJobRentersInProgress(int id) async{
    var rs = await HttpService.get('$ACCOUNT/$id/jobrenters/inprogress', bearerToken: TOKEN);
    print('code Job Renter InProgress: ${rs.statusCode}');
    if (rs.statusCode == 200) {
      var jsonList = jsonDecode(rs.body) as List;
      var jobs = jsonList.map((e) => Job.fromJson(e)).toList();
      return jobs;
    }
    return null;
  }

  Future<dynamic> getJobRentersPast(int id) async{
    var rs = await HttpService.get('$ACCOUNT/$id/jobrenters/past', bearerToken: TOKEN);
    print('code Job Renter Past: ${rs.statusCode}');
    if (rs.statusCode == 200) {
      var jsonList = jsonDecode(rs.body) as List;
      var jobs = jsonList.map((e) => Job.fromJson(e)).toList();
      return jobs;
    }
    return null;
  }


  Future<dynamic> getJobFreelancers(int id) async{
    var rs = await HttpService.get('$ACCOUNT/$id/jobfreelancers', bearerToken: TOKEN);
    print('code Job Freelancer Part: ${rs.statusCode}');
    if (rs.statusCode == 200) {
      var jsonList = jsonDecode(rs.body) as List;
      var jobs = jsonList.map((e) => Job.fromJson(e)).toList();
      return jobs;
    }
    return null;
  }

  Future<dynamic> getJobFreelancersInProgress(int id) async{
    var rs = await HttpService.get('$ACCOUNT/$id/jobfreelancers/inprogress', bearerToken: TOKEN);
    print('code Job freelancers inprogress: ${rs.statusCode}');
    if (rs.statusCode == 200) {
      var jsonList = jsonDecode(rs.body) as List;
      var jobs = jsonList.map((e) => Job.fromJson(e)).toList();
      return jobs;
    }
    return null;
  }

  Future<dynamic> getJobFreelancersPast(int id) async{
    var rs = await HttpService.get('$ACCOUNT/$id/jobfreelancers/past', bearerToken: TOKEN);
    print('code Job freelancers past: ${rs.statusCode}');
    if (rs.statusCode == 200) {
      var jsonList = jsonDecode(rs.body) as List;
      var jobs = jsonList.map((e) => Job.fromJson(e)).toList();
      return jobs;
    }
    return null;
  }

  Future<dynamic> getOfferHistories(int id) async{
    var rs = await HttpService.get('$ACCOUNT/$id/offerhistories', bearerToken: TOKEN);
    print('code Job OfferHistories: ${rs.statusCode}');
    if (rs.statusCode == 200) {
      var jsonList = jsonDecode(rs.body) as List;
      var jobs = jsonList.map((e) => Job.fromJson(e)).toList();
      return jobs;
    }
    return null;
  }

  @override
  Future getBanks() async {
    var rs = await HttpService.get(BANKS, bearerToken: TOKEN);
    print('codeBank ${rs.statusCode}');
    if (rs.statusCode == 200) {
      var jsonList = jsonDecode(rs.body) as List;
      var banks = jsonList.map((e) => Bank.fromJson(e)).toList();
      return banks;
    }
  }
  @override
  Future getBankAccounts() async {
    var rs = await HttpService.get(BANK_ACCOUNT, bearerToken: TOKEN);
    print('code Payment Method ${rs.statusCode}');
    if (rs.statusCode == 200) {
      var jsonList = jsonDecode(rs.body) as List;
      var paymentMethods = jsonList.map((e) => PaymentMethod.fromJson(e)).toList();
      return paymentMethods;
    }
  }

  @override
  Future postBankAccounts(BankAccountRequest request) async{
    var rs = await HttpService.post(BANK_ACCOUNT,request.toJson(), bearerToken: TOKEN);
    print('code Bank Account ${rs.statusCode}');
  }
}