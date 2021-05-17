import 'dart:convert';
import 'package:freelance_app/domain/models/account.dart';
import 'package:freelance_app/domain/models/form_of_work.dart';
import 'package:freelance_app/domain/models/level.dart';
import 'package:freelance_app/domain/models/pay_form.dart';
import 'package:freelance_app/domain/models/province.dart';
import 'package:freelance_app/domain/models/service.dart';
import 'package:freelance_app/domain/models/skill.dart';
import 'package:freelance_app/domain/models/specialty.dart';
import 'package:freelance_app/domain/models/type_of_work.dart';
import 'package:freelance_app/domain/repositories/api_repository.dart';
import 'package:freelance_app/domain/requests/account_request.dart';
import 'package:freelance_app/domain/requests/image_request.dart';
import 'package:freelance_app/domain/requests/login_request.dart';
import 'package:freelance_app/domain/requests/post_job_request.dart';
import 'package:freelance_app/domain/requests/register_request.dart';
import 'package:freelance_app/domain/services/http_service.dart';

class ApiRepositoryImpl extends ApiRepositoryInterface {
  @override
  Future<Account> getAccountFromToken() async {
    var rs = await HttpService.get(ACCOUNT, bearerToken: TOKEN);
    print("code: ${rs.statusCode}");
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
    print('code ${rs.statusCode}');
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
        ACCOUNT, account.toJson(), bearerToken: TOKEN, parameters: parameters);
    if (rs.statusCode == 200) {
      var jsonObject = jsonDecode(rs.body);
      print('Dữ liệu, ${jsonObject.toString()}');
    }
  }

  @override
  Future getSpecialties() async {
    var rs = await HttpService.get(SPECIALTIES, bearerToken: TOKEN);
    if (rs.statusCode == 200) {
      var jsonList = jsonDecode(rs.body) as List;
      var specialties = jsonList.map((e) => Specialty.fromJson(e)).toList();
      return specialties;
    }
    return null;
  }


  @override
  Future getSpecialtyServices(int specialtyId) async {
    var rs = await HttpService.get('$SPECIALTYSERVICE/$specialtyId', bearerToken: TOKEN);
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
    print('code: ${rs.statusCode}');
    if (rs.statusCode == 200) {
      var jsonList = jsonDecode(rs.body) as List;
      var services = jsonList.map((e) => Service.fromJson(e)).toList();
      return services;
    }
    return null;
  }

  @override
  Future postJob(PostJobRequest postJobRequest) async {
    print('data: ${postJobRequest.toJson()}');
    var rs = await HttpService.post(
        JOB, postJobRequest.toJson(), bearerToken: TOKEN);
    if (rs.statusCode == 201) {
      print("Thành công: ${rs.body}");
      return true;
    }
    return false;
  }

  @override
  Future getFormOfWorks() async {
    var rs = await HttpService.get(FORMOFWORKS, bearerToken: TOKEN);
    if (rs.statusCode == 200) {
      var jsonList = jsonDecode(rs.body) as List;
      var formOfWorks = jsonList.map((e) => FormOfWork.fromJson(e)).toList();
      return formOfWorks;
    }
    return null;
  }

  @override
  Future getPayForms() async {
    var rs = await HttpService.get(PAYFORMS, bearerToken: TOKEN);
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
      var skills = jsonList.map((e) => Skill.fromJson(e)).toList();
      return skills;
    }
    return null;
  }

  @override
  Future getTypeOfWorks() async {
    var rs = await HttpService.get(TYPEOFWORKS, bearerToken: TOKEN);
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
    if (rs.statusCode == 200) {
      var jsonList = jsonDecode(rs.body) as List;
      var provinces = jsonList.map((e) => Province.fromJson(e)).toList();
      return provinces;
    }
    return null;
  }

  @override
  Future getImage(String url) async {
    var rs = await HttpService.get('$IMAGE/$url', bearerToken: TOKEN);
    print('code ${rs.statusCode}');
    if (rs.statusCode == 200) {
      // var json = jsonDecode(rs.body) ;
      // print('response ${json}');
      return rs.body;
    }
  }

  @override
  Future putAccount(int id, AccountRequest request) async {
    var rs = await HttpService.put('api/Accounts/$id', request.toJson(),bearerToken: TOKEN);
    print('code ${rs.statusCode}');
    print('body ${request.toJson()}');
    if(rs.statusCode == 204){

    }
  }

  @override
  Future getLevels() async {
    var rs = await HttpService.get(LEVELS, bearerToken: TOKEN);
    print('code ${rs.statusCode}');
    if (rs.statusCode == 200) {
      var jsonList = jsonDecode(rs.body) as List;
      var level = jsonList.map((e) => Level.fromJson(e)).toList();
      return level;
    }
  }
  @override
  Future getLevelFromId(int id) async {
    var rs = await HttpService.get('$LEVELS/$id', bearerToken: TOKEN);
    print('codeLV ${rs.statusCode}');
    if (rs.statusCode == 200) {
      var js = jsonDecode(rs.body);
      var level = Level.fromJson(js);
      return level;
    }
    return null;
  }

}