import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/account.dart';
import 'package:freelance_app/domain/models/chat_message.dart';
import 'package:freelance_app/domain/models/dash_board_admin.dart';
import 'package:freelance_app/domain/models/job.dart';
import 'package:freelance_app/domain/models/service.dart';
import 'package:freelance_app/domain/models/skill.dart';
import 'package:freelance_app/domain/models/specialty.dart';
import 'package:freelance_app/domain/repositories/api_repository.dart';
import 'package:freelance_app/domain/repositories/local_storage_repository.dart';
import 'package:freelance_app/domain/services/http_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signalr_core/signalr_core.dart';

class AdminController extends GetxController {
  final ApiRepositoryInterface apiRepositoryInterface;
  final LocalRepositoryInterface localRepositoryInterface;

  AdminController({this.apiRepositoryInterface, this.localRepositoryInterface});

  RxList<Specialty> specialties = <Specialty>[].obs;

  RxList<Skill> skills = <Skill>[].obs;

  RxInt indexSelected = 0.obs;

  Rx<DashboardAdmin> dashboard = DashboardAdmin().obs;

  var progressState = sState.loading.obs;

  RxList<Job> jobs = <Job>[].obs;
  RxList<Job> requests = <Job>[].obs;
  HubConnection connection;
  Rx<Job> job = Job().obs;

  RxList<Service> services = <Service>[].obs;
  Rx<Account> admin = Account().obs;

  RxList<ChatMessage> chatMessages = <ChatMessage>[].obs;

  Future loadDashboard()async{
    await apiRepositoryInterface.getAdminDashboard().then((value) => dashboard(value));
  }

  Future<void> createSignalRConnection() async {
    try {
      connection = HubConnectionBuilder().withUrl(CHAT_HUB).build();
      await connection.start();
      await connectUser();
      print('đã kết nối ${connection.state}');



    } catch (e) {
      print('lỗi $e');
      print('trạng thái: ${connection.state}');

    }
  }

  Future connectUser() async {
    if (connection.state == HubConnectionState.connected) {
      await connection.invoke("Connect", args: <Object>[CURRENT_ID]);
    }
  }


  Future loadMessageChat(int jobId) async {
    try {
      await apiRepositoryInterface
          .getAdminJobsRequestId(jobId)
          .then((value) => chatMessages.assignAll(value));
    } catch (e) {
      print('Lỗi mess: $e');
    }
  }


  Future loadAccountLocal() async {
    progressState(sState.loading);
    await localRepositoryInterface.getAccount().then(
          (value) {
        if(value!=null){
          admin(value);
          CURRENT_ID = admin.value.id;
        }

      },
    );
    progressState(sState.initial);
  }

  RxList<Account> freelancers = <Account>[].obs;


  final ctrlName = TextEditingController();
  final ctrlSubName = TextEditingController();

  RxList<Service> servicesSelected = <Service>[].obs;
  RxList<Specialty> specialtiesSelected = <Specialty>[].obs;

  RxString base64img = ''.obs;
  RxString nameImage = ''.obs;

  Future uploadImage() async {
    try {
      var pickedFile =
          await ImagePicker().getImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        base64img(base64Encode(bytes));
        nameImage(pickedFile.path.split("/").last);
      }
    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }

  Future loadServices() async {
    services.clear();
    try {
      await apiRepositoryInterface.getServices().then((value){
        services.assignAll(value);
        if(servicesSelected.isNotEmpty)
        services.forEach((element) {
          specialtiesSelected.forEach((e) {
            if (e.id == element.id) {
              element.isValue = true;
              return;
            }
          });
        });
      });

    } catch (e) {
      print('lỗi ${e.toString()}');

    }
  }

  Future banAccount(int id)async{
    await apiRepositoryInterface.deleteAccount(id);
  }

  @override
  void onReady() {
    loadDashboard();
    loadAccountLocal();
    super.onReady();
  }
  @override
  void onInit() {
    createSignalRConnection();
    super.onInit();
  }

  void updateIndexSelected(int index) {
    print(indexSelected.value);
    indexSelected(index);
  }

  Future<Job> loadJobFromId(jobId) async {
    try {
      await apiRepositoryInterface.getJobFromId(jobId).then((value) {
        if(value!=null)
        job(value);
      });
      return job.value;
    } catch (e) {
      print('Lỗi $e');
      return null;
    }
  }

  Future loadJobs() async {
    progressState(sState.loading);
    try {
      await apiRepositoryInterface.getAdminJobs().then((value){
        jobs.assignAll(value);
        progressState(sState.initial);
      });
    } catch (e) {
      progressState(sState.failure);
      print('Lỗi $e');
    }
  }

  Future loadSpecialties() async {
    specialties.clear();
    try {
      await apiRepositoryInterface.getSpecialties().then((value){
        specialties.assignAll(value);
        if(specialtiesSelected.isNotEmpty)
        value.forEach((element) {
          servicesSelected.forEach((e) {
            if (e.id == element.id) {
              element.isValue = true;
              return;
            }
          });
        });
      });

    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }

  void sendSpecialty() async {
    try {
      await apiRepositoryInterface.postSpecialty(
          ctrlName.text, nameImage.value, base64img.value, servicesSelected);
    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }

  Future sendService() async {
    try {
      await apiRepositoryInterface.postService(
          ctrlName.text, specialtiesSelected);
    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }

  Future sendSkill() async {
    try {
      await apiRepositoryInterface.postSkill(
          ctrlName.text);
    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }

  Future updateSkill(int id) async {
    try {
      await apiRepositoryInterface.putSkill(id,
          ctrlName.text);
    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }


  Future updateService(int id) async {
    try {
      await apiRepositoryInterface.putService(id,
          ctrlName.text,specialtiesSelected);
    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }

  Future updateSpecialty(int id) async {
    try {
      await apiRepositoryInterface.putSpecialty(id, ctrlName.text,
          nameImage.value, base64img.value, servicesSelected);
    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }

  Future<void> logOut() async {
    await apiRepositoryInterface.logout();
    await localRepositoryInterface.clearData();
  }

  void changeValueService(Service service) {
    final List<Service> updatedSkill = services.map((e) {
      return e.id == service.id ? service : e;
    }).toList();
    services.assignAll(updatedSkill);
  }

  void changeValueSpecialty(Specialty specialty) {
    final List<Specialty> updatedSpecialty = specialties.map((e) {
      return e.id == specialty.id ? specialty : e;
    }).toList();
    specialties.assignAll(updatedSpecialty);
  }

  void selectedList(List listSelected, List list) {
    listSelected.clear();
    final List updatedServices = list.where((e) => e.isValue == true).toList();
    listSelected.assignAll(updatedServices);
  }

  Future loadFreelancers() async {
    progressState(sState.loading);
    try {
      await apiRepositoryInterface.getAdminAccounts().then((value){
        if (value != null) {
          freelancers.assignAll(value);
        }
        progressState(sState.initial);
      });
    } catch (e) {
      progressState(sState.failure);
    }
  }

  Future loadFreelancerFromId(int freelancerId) async {
    try {
      return await apiRepositoryInterface.getAccountFromId(freelancerId);
    } catch (e) {
      print('lỗi: ${e.toString()}');
    }
  }

  Future sendConfirmRequest(int jobId, String status, int adminId,String message) async {
    if (connection.state == HubConnectionState.connected) {
      await connection.invoke("SendConfirmRequest", args: <Object>[jobId,status,adminId,message]);
    }
  }

  Future loadRequest()async{
    progressState(sState.loading);
    try{
      await apiRepositoryInterface.getAdminJobsRequest().then((value) => requests.assignAll(value));
      progressState(sState.initial);
    }catch(e){
      print('lỗi: ${e.toString()}');
      progressState(sState.initial);
    }
  }




  Future loadSkills() async {
    progressState(sState.loading);
    try {
      await apiRepositoryInterface.getSkills().then((value){
        skills.assignAll(value);
        progressState(sState.initial);
      });
    } catch (e) {
      print('lỗi ${e.toString()}');
      progressState(sState.failure);
    }
  }
}
