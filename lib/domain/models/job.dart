import 'package:freelance_app/domain/models/form_of_work.dart';
import 'package:freelance_app/domain/models/province.dart';
import 'package:freelance_app/domain/models/type_of_work.dart';

import 'pay_form.dart';

class Job {
  final int id;
  final int renterId;
  final int freelancerId;
  final String name;
  final String details;
  final int typeId;
  final int formId;
  final int workAtId;
  final int payFormId;
  final int deadline;
  final int floorPrice;
  final int cellingPrice;
  final int isPrivate;
  final int specialtyId;
  final int serviceId;
  final String provinceId;
  final String status;
  final FormOfWork form;
  final PayForm payform;
  final Province province;
  final TypeOfWork type;


  Job({
    this.id,
    this.renterId,
    this.freelancerId,
    this.name,
    this.details,
    this.typeId,
    this.formId,
    this.workAtId,
    this.payFormId,
    this.deadline,
    this.floorPrice,
    this.cellingPrice,
    this.isPrivate,
    this.specialtyId,
    this.serviceId,
    this.province,
    this.provinceId,
    this.type,
    this.form,
    this.payform,
    this.status
  });
}
