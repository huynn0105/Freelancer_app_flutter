import 'dart:convert';
import 'package:freelance_app/domain/models/account.dart';
import 'package:freelance_app/domain/models/bank.dart';
import 'package:freelance_app/domain/models/capacity_profile.dart';
import 'package:freelance_app/domain/models/chat.dart';
import 'package:freelance_app/domain/models/chat_message.dart';
import 'package:freelance_app/domain/models/form_of_work.dart';
import 'package:freelance_app/domain/models/job.dart';
import 'package:freelance_app/domain/models/job_offer.dart';
import 'package:freelance_app/domain/models/level.dart';
import 'package:freelance_app/domain/models/offer.dart';
import 'package:freelance_app/domain/models/pay_form.dart';
import 'package:freelance_app/domain/models/payment_method.dart';
import 'package:freelance_app/domain/models/province.dart';
import 'package:freelance_app/domain/models/rating.dart';
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
import 'package:freelance_app/domain/requests/search_request.dart';
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
    return await HttpService.post(LOGIN, body: accountInput);
  }

  @override
  Future<void> logout() async {
    print('remove token from server $TOKEN');
    return;
  }

  @override
  Future register(RegisterRequest registerRequest) async {

    print('register: ${registerRequest.toJson()}');
    return await HttpService.post(REGISTER, body: registerRequest.toJson());
  }

  @override
  Future uploadAvatar(ImageRequest imageRequest) async {
    Map<String, String> input = {
      'name': imageRequest.name,
      'imageBase64': imageRequest.imageBase64
    };

    var rs = await HttpService.post(AVATAR, body: input, bearerToken: TOKEN);
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
    var rs = await HttpService.put(ACCOUNT,
        body: account.toJson(), bearerToken: TOKEN, parameters: parameters);
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
  Future postSpecialty(String name, String imageName, String imageBase64,
      List<Service> services) async {
    Map<String, dynamic> input = {
      'name': name,
      'imageName': imageName,
      'imageBase64': imageBase64,
      'services': services,
    };

    var rs =
        await HttpService.post(SPECIALTIES, body: input, bearerToken: TOKEN);
    print('POST Specialty ${rs.statusCode}');
  }

  @override
  Future putSpecialty(int id, String name, String imageName, String imageBase64,
      List<Service> services) async {
    Map<String, dynamic> input = {
      'name': name,
      'imageName': imageName,
      'imageBase64': imageBase64,
      'services': services,
    };

    var rs = await HttpService.put('$SPECIALTIES/$id',
        body: input, bearerToken: TOKEN);
    print('PUT Specialty $id ${rs.statusCode}');
  }

  @override
  Future getSpecialtyServices(int specialtyId) async {
    var rs = await HttpService.get('$SPECIALTIES/$specialtyId/services',
        bearerToken: TOKEN);
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
    var rs = await HttpService.post(JOB,
        body: postJobRequest.toJson(), bearerToken: TOKEN);
    print('codeJob: ${rs.statusCode}');
    print('time: ${postJobRequest.deadline}');
    if (rs.statusCode == 200) return true;
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
    var rs = await HttpService.put('api/Accounts/$id',
        body: request.toJson(), bearerToken: TOKEN);
    print(rs.statusCode);
    return rs.statusCode;
  }

  @override
  Future putOnReady(int id) async {
    var rs = await HttpService.put('$ACCOUNT/$id/onready', bearerToken: TOKEN);
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
  Future postCapacityProfile(CapacityProfile capacityProfile) async {
    var rs = await HttpService.post(CAPACITY_PROFILE,
        body: capacityProfile.toJson(), bearerToken: TOKEN);
    print('codeCapacityProfiles ${rs.statusCode}');
  }

  @override
  Future putCapacityProfile(int id, CapacityProfile capacityProfile) async {
    var rs = await HttpService.put('$CAPACITY_PROFILE/$id',
        body: capacityProfile.toJson(), bearerToken: TOKEN);
    print('js :${capacityProfile.imageName}');
    print('codeCapacityProfiles ${rs.statusCode}');
  }

  @override
  Future getCapacityProfiles(int freelancerId) async {
    var rs = await HttpService.get('$ACCOUNT/$freelancerId/capacityprofiles',
        bearerToken: TOKEN);
    print('codeCapacityProfiles ${rs.statusCode}');
    if (rs.statusCode == 200) {
      var jsonList = jsonDecode(rs.body) as List;
      var capacityProfiles =
          jsonList.map((e) => CapacityProfile.fromJson(e)).toList();
      return capacityProfiles;
    }
    return null;
  }

  @override
  Future getAccounts() async {
    var rs = await HttpService.get(ACCOUNT, bearerToken: TOKEN);
    print('codeAccounts ${rs.statusCode}');
    if (rs.statusCode == 200) {
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
  Future postOfferHistories(OfferRequest offerRequest) async {
    var rs = await HttpService.post(OFFER_HISTORIES,
        body: offerRequest.toJson(), bearerToken: TOKEN);
    print('codeOfferHistories ${rs.statusCode}');
    print('OfferHistories ${rs.body}');
    if (rs.statusCode == 200) return true;
    return false;
  }

  @override
  Future deleteCapacityProfile(int capacityProfileId) async {
    var rs = await HttpService.delete('$CAPACITY_PROFILE/$capacityProfileId',
        bearerToken: TOKEN);
    print('codeDeleteCap ${rs.statusCode}');
    if (rs.statusCode == 200) return true;
    return false;

  }
  @override
  Future<dynamic> getJobRenters(int id) async {
    var rs =
        await HttpService.get('$ACCOUNT/$id/jobrenters', bearerToken: TOKEN);
    print('code Job Renter: ${rs.statusCode}');
    if (rs.statusCode == 200) {
      var jsonList = jsonDecode(rs.body) as List;
      var jobs = jsonList.map((e) => Job.fromJson(e)).toList();
      return jobs;
    }
    return null;
  }
  @override
  Future<dynamic> getJobRentersWaiting(int id) async {
    var rs = await HttpService.get('$ACCOUNT/$id/jobrenters/waiting',
        bearerToken: TOKEN);
    print('code Job Renter Waiting: ${rs.statusCode}');
    if (rs.statusCode == 200) {
      var jsonList = jsonDecode(rs.body) as List;
      var jobs = jsonList.map((e) => Job.fromJson(e)).toList();
      return jobs;
    }
    return null;
  }
  @override
  Future<dynamic> getJobRentersInProgress(int id) async {
    var rs = await HttpService.get('$ACCOUNT/$id/jobrenters/inprogress',
        bearerToken: TOKEN);
    print('code Job Renter InProgress: ${rs.statusCode}');
    if (rs.statusCode == 200) {
      var jsonList = jsonDecode(rs.body) as List;
      var jobs = jsonList.map((e) => Job.fromJson(e)).toList();
      return jobs;
    }
    return null;
  }
  @override
  Future<dynamic> getJobRentersPast(int id) async {
    var rs = await HttpService.get('$ACCOUNT/$id/jobrenters/past',
        bearerToken: TOKEN);
    print('code Job Renter Past: ${rs.statusCode}');
    if (rs.statusCode == 200) {
      var jsonList = jsonDecode(rs.body) as List;
      var jobs = jsonList.map((e) => Job.fromJson(e)).toList();
      return jobs;
    }
    return null;
  }
  @override
  Future<dynamic> getJobFreelancers(int id) async {
    var rs = await HttpService.get('$ACCOUNT/$id/jobfreelancers',
        bearerToken: TOKEN);
    print('code Job Freelancer Part: ${rs.statusCode}');
    if (rs.statusCode == 200) {
      var jsonList = jsonDecode(rs.body) as List;
      var jobs = jsonList.map((e) => Job.fromJson(e)).toList();
      return jobs;
    }
    return null;
  }
  @override
  Future<dynamic> getJobFreelancersInProgress(int id) async {
    var rs = await HttpService.get('$ACCOUNT/$id/jobfreelancers/inprogress',
        bearerToken: TOKEN);
    print('code Job freelancers inprogress: ${rs.statusCode}');
    if (rs.statusCode == 200) {
      var jsonList = jsonDecode(rs.body) as List;
      var jobs = jsonList.map((e) => Job.fromJson(e)).toList();
      return jobs;
    }
    return null;
  }
  @override
  Future<dynamic> getJobFreelancersPast(int id) async {
    var rs = await HttpService.get('$ACCOUNT/$id/jobfreelancers/past',
        bearerToken: TOKEN);
    print('code Job freelancers past: ${rs.statusCode}');
    if (rs.statusCode == 200) {
      var jsonList = jsonDecode(rs.body) as List;
      var jobs = jsonList.map((e) => Job.fromJson(e)).toList();
      return jobs;
    }
    return null;
  }
  @override
  Future<dynamic> getOfferHistories(int id) async {
    var rs = await HttpService.get('$ACCOUNT/$id/offerhistories',
        bearerToken: TOKEN);
    print('code Job OfferHistories: ${rs.statusCode}');
    if (rs.statusCode == 200) {
      var jsonList = jsonDecode(rs.body) as List;
      var jobsOffer = jsonList.map((e) => JobOffer.fromJson(e)).toList();
      return jobsOffer;
    }
    return null;
  }

  @override
  Future<dynamic> getOfferHistoriesWaiting(int id) async {
    var rs = await HttpService.get('$ACCOUNT/$id/offerhistories/waiting',
        bearerToken: TOKEN);
    print('code Job OfferHistories waiting: ${rs.statusCode}');
    if (rs.statusCode == 200) {
      var jsonList = jsonDecode(rs.body) as List;
      var jobsOffer = jsonList.map((e) => JobOffer.fromJson(e)).toList();
      return jobsOffer;
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
      var paymentMethods =
          jsonList.map((e) => PaymentMethod.fromJson(e)).toList();
      return paymentMethods;
    }
  }

  @override
  Future postBankAccounts(BankAccountRequest request) async {
    var rs = await HttpService.post(BANK_ACCOUNT,
        body: request.toJson(), bearerToken: TOKEN);
    print('code Bank Account ${rs.statusCode}');
  }

  @override
  Future postSkill(String name) async {
    var rs = await HttpService.post(SKILLS,body: {'name':name}, bearerToken: TOKEN);
    print('code post skill ${rs.statusCode}');
  }

  @override
  Future putSkill(int id,String name) async {
    var rs = await HttpService.put('$SKILLS/$id',body: {'name':name}, bearerToken: TOKEN);
    print('code put skill ${rs.statusCode}');
  }

  @override
  Future postService(String name, List<Specialty> specialties) async {
    Map<String,dynamic> input = {
      "name": name,
      "specialties" : specialties,
    };
    var rs = await HttpService.post(SERVICE,body: input, bearerToken: TOKEN);
    print('cod post Service ${rs.statusCode}');
  }

  @override
  Future putService(int id,String name, List<Specialty> specialties) async {
    Map<String,dynamic> input = {
      "name": name,
      "specialties" : specialties,
    };
    var rs = await HttpService.put('$SERVICE/$id',body: input, bearerToken: TOKEN);
    print('cod put Service ${rs.statusCode}');
  }

  @override
  Future searchJob(SearchRequest request) async{
   var rs = await HttpService.get('$JOB/search',parameters:request.toJsonJob(),bearerToken: TOKEN);
   print('code Search Job ${rs.statusCode}');
   if(rs.statusCode == 200){
     var jsonList = jsonDecode(rs.body) as List;
     var jobs = jsonList.map((e) => Job.fromJson(e)).toList();
     return jobs;
   }
  }

  @override
  Future searchFreelancer(SearchRequest request) async{
    var rs = await HttpService.get('$ACCOUNT/search',parameters:request.toJsonFreelancer(),bearerToken: TOKEN);
    print('code Search ${rs.statusCode}');
    if (rs.statusCode == 200) {
      var jsonList = jsonDecode(rs.body) as List;
      var accounts = jsonList.map((e) => Account.fromJson(e)).toList();
      return accounts;
    }
  }



  @override
  Future getJobOffer(int id) async {
    var rs = await HttpService.get('$JOB/$id/offerhistories',bearerToken: TOKEN);
    print('code Job Offer : ${rs.statusCode}');
    if(rs.statusCode == 200){
      var jsonList = jsonDecode(rs.body) as List;
      var offer = jsonList.map((e) => Offer.fromJson(e)).toList();
      return offer;
    }
  }

  @override
  Future putJobOfferChoose(int jobId, int freelancerId) async {

    var rs = await HttpService.put('$JOB/$jobId/offerhistories/$freelancerId/choose', bearerToken: TOKEN);
    print('code job offerhistories choose ${rs.statusCode}');
    if(rs.statusCode == 200){
      print('dulieu: ${rs.body}');
    }
  }

  @override
  Future postRating(request) async {
    var rs = await HttpService.post(RATING,body: request.toJson(),bearerToken: TOKEN);
    print('code rating ${rs.statusCode}');
    if(rs.statusCode == 200){
      print('dulieu: ${rs.body}');
    }
  }

  @override
  Future putJobClose(int id) async {
    var rs = await HttpService.put('$JOB/$id/close', bearerToken: TOKEN);
    print('code put JobClose ${rs.statusCode}');
  }

  @override
  Future putJobCancel(int id) async {
    var rs = await HttpService.put('$JOB/$id/requestcancellation', bearerToken: TOKEN);
    print('code put requestcancellation ${rs.statusCode}');
    return rs.statusCode;
  }

  @override
  Future putJobDone(int id) async{

    var rs = await HttpService.put('$JOB/$id/done', bearerToken: TOKEN);
    print('code put done ${rs.statusCode}');
    return rs.statusCode;
  }

  @override
  Future putJobRequestRework(int id) async{
    var rs = await HttpService.put('$JOB/$id/requestrework', bearerToken: TOKEN);
    print('code put requestrework ${rs.statusCode}');
    return rs.statusCode;
  }

  @override
  Future putJobRequestFinish(int id)async {
    var rs = await HttpService.put('$JOB/$id/requestfinish', bearerToken: TOKEN);
    print('code put requestfinish ${rs.statusCode}');
    return rs.statusCode;
  }

  @override
  Future getMessageUser() async {
    var rs = await HttpService.get(MESSAGE_USER, bearerToken: TOKEN);
    print('code message user: ${rs.statusCode}');
    if(rs.statusCode==200){
      var jsonList = jsonDecode(rs.body) as List;
      var chats = jsonList.map((e) => Chat.fromJson(e)).toList();
      return chats;
    }
  }

  @override
  Future getMessageChat(int jobId, int freelancerId) async {
    Map<String,String> param = {'jobId':'$jobId', 'freelancerId':'$freelancerId'};
    var rs = await HttpService.get(MESSAGES,parameters: param, bearerToken: TOKEN);
    print('code message chat: ${rs.statusCode}');
    if(rs.statusCode==200){
      var jsonList = jsonDecode(rs.body) as List;
      var chatMessages = jsonList.map((e) => ChatMessage.fromJson(e)).toList();
      return chatMessages;
    }
  }

  @override
  Future getRatingsFreelancerId(int freelancerId) async{
    var rs = await HttpService.get('$ACCOUNT/$freelancerId/ratings',bearerToken: TOKEN);
    print('code get rating ${rs.statusCode}');
    if(rs.statusCode==200){
      var jsonList = jsonDecode(rs.body) as List;
      var ratings = jsonList.map((e) => Rating.fromJson(e)).toList();
      return ratings;
    }

  }

  @override
  Future putDeposit(int money) async {
    var rs = await HttpService.put('$ACCOUNT/deposit/$money', bearerToken: TOKEN);
    print('code put money ${rs.statusCode}');
    return rs.statusCode;
  }

  @override
  Future getCheckAssign(int jobId, int freelancerId) async{
    Map<String,String> param = {'jobId': '$jobId','freelancerId': '$freelancerId'};
    var rs = await HttpService.get('$MESSAGE_USER/checkassign',parameters: param,bearerToken: TOKEN);
    print('code get check assign ${rs.statusCode}');
    if(rs.statusCode==200){
      var jsonObject = jsonDecode(rs.body);
      bool canAssign = jsonObject['canAssign'];
      return canAssign;
    }

  }

  @override
  Future getCheckRequest(int jobId, int freelancerId) async{
    Map<String,String> param = {'jobId': '$jobId','freelancerId': '$freelancerId'};
    var rs = await HttpService.get('$MESSAGE_USER/checkrequest',parameters: param,bearerToken: TOKEN);
    print('code get check canRequest ${rs.statusCode}');
    if(rs.statusCode==200){
      var jsonObject = jsonDecode(rs.body);
      bool canRequest = jsonObject['canRequest'];
      return canRequest;
    }

  }

}
