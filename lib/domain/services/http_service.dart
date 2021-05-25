import 'dart:convert';
import 'dart:io';

import 'package:freelance_app/domain/models/freelancer.dart';
import 'package:http/http.dart' as http;

const DOMAIN = '10.0.2.2:5001';

const LOGIN = '/api/Login';
const REGISTER = '/api/Register';
const ACCOUNT = '/api/Accounts';
const AVATAR = '/api/Images/avatars';
const SPECIALTIES = '/api/Specialties';
const JOB = '/api/Jobs';
const TYPE_OF_WORKS = '/api/TypeOfWorks';
const SKILLS = '/api/Skills';
const PAY_FORMS = '/api/Payforms';
const FORM_OF_WORKS = '/api/FormOfWorks';
const CAPACITY_PROFILES = '/api/CapacityProfiles';
const SPECIALTY_SERVICE = '/api/SpecialtyServices/getservices';
const SERVICE = '/api/Services';
const PROVINCES = '/api/Provinces';
const IMAGE = 'https://10.0.2.2:5001/api/Images';
const LEVELS = 'api/Levels';
const CAPACITY_PROFILE = 'api/CapacityProfiles';
const ACCOUNT_PAGINATION = '/api/Accounts/pagination';
const OFFER_HISTORIES = '/api/OfferHistories';

// ignore: non_constant_identifier_names
String TOKEN = '';

class HttpService {
  static Future<http.Response> post(String url, Map<String, dynamic> body,
      {String bearerToken, Map<String, dynamic> parameters}) async {
    var uri = Uri.https(DOMAIN, url, parameters);
    print('HTTP POST: $uri');
    return (await http.post(uri, body: jsonEncode(body), headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $bearerToken',
    }));
  }

  static Future<http.Response> put(String url, Map<String, dynamic> body,
      {String bearerToken, Map<String, dynamic> parameters}) async {
    var uri = Uri.https(DOMAIN, url, parameters);
    print('HTTP PUT: $uri');
    return (await http.put(uri, body: jsonEncode(body), headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $bearerToken'
    }));
  }

  static Future<http.Response> get(String url,
      {String bearerToken, Map<String, dynamic> parameters}) async {
    var uri = Uri.https(DOMAIN, url, parameters);
    print("urllll: $uri");
    return await http.get(uri,
        headers: {HttpHeaders.authorizationHeader: 'Bearer $bearerToken'});
  }
}
