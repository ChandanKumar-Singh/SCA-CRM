/*
// To parse this JSON data, do
//
//     final leadsModel = leadsModelFromJson(jsonString);

import 'dart:convert';

LeadsModel leadsModelFromJson(String str) =>
    LeadsModel.fromJson(json.decode(str));

String leadsModelToJson(LeadsModel data) => json.encode(data.toJson());

class LeadsModel {
  LeadsModel({
    required this.success,
    required this.count,
    required this.data,
    required this.message,
  });

  int success;
  int count;
  List<Datum> data;
  String message;

  factory LeadsModel.fromJson(Map<String, dynamic> json) => LeadsModel(
        success: json["success"],
        count: json["count"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "count": count,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class Lead {
  Lead({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.altPhone,
    required this.date,
    required this.dob,
    required this.source,
    required this.priority,
    required this.comment,
    //required this.additionalComment,
    //required this.customerId,
    //    required this.developerId,
    //    required this.propertyId,
    //    required this.propertyPreference,
    //    required this.jobProfile,
    required this.avgIncome,
    //    required this.status,
    //    required this.attachment,
    //    required this.type,
    required this.amount,
    //    required this.closedDate,
    //    required this.closeBy,
    //    required this.leadId,
    //   required  this.agentId,
    //    required this.review,
    //    required this.createdBy,
    //    required this.assignLeadsCount,
    //    required this.customer,
    //    //required this.developer,
    // //   required this.property,
        required this.agents,
        //required this.statuses,
    //    required this.leadUser,
    required this.sources,
    //required this.notes,
    required this.newComments,
  });

  int id;
  String name;
  String? email;
  String phone;
  String? altPhone;
  DateTime date;
  String? dob;

  String? source;
  String? priority;
  String? comment;

//   dynamic additionalComment;
//   dynamic customerId;
//   int? developerId;
//   int? propertyId;
//   dynamic propertyPreference;
//   dynamic jobProfile;
  String? avgIncome;

//   int? status;
//   dynamic attachment;
//   String? type;
  String? amount;

//   DateTime closedDate;
//   int? closeBy;
//   String? leadId;
//   int? agentId;
//   dynamic review;
//   int? createdBy;
//   int? assignLeadsCount;
//   dynamic customer;
//   //Developer? developer;
// //  Property property;
  List<Agent> agents;
   //Statuses statuses;
//   Datum leadUser;
  Sources sources;

  //List<Note> notes;
  List<NewComment> newComments;

  factory Lead.fromJson(Map<String, dynamic> json) => Lead(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        altPhone: json["alt_phone"] ?? 'No Alternate Number',
        date: DateTime.parse(json["date"]),
        dob: json["dob"],
        source: json["source"],
        priority: json["priority"],
        comment: json["comment"],
//    additionalComment: json["additional_comment"],
//     customerId: json["customer_id"],
//     developerId:  json["developer_id"],
//     propertyId:  json["property_id"],
//     propertyPreference: json["property_preference"],
//     jobProfile: json["job_profile"],
        avgIncome: json["avg_income"]??'No Data Available',
//     status: json["status"],
//     attachment: json["attachment"],
//     type: json["type"],
        amount: json["amount"],
//     closedDate: DateTime.parse(json["closed_date"]),
//     closeBy: json["close_by"],
//     leadId: json["lead_id"],
//     agentId:  json["agent_id"],
//     review: json["review"],
//     createdBy: json["created_by"],
//     assignLeadsCount: json["assign_leads_count"],
//     customer: json["customer"],
//     //developer:  Developer.fromJson(json["developer"]),
//    // property:  Property.fromJson(json["property"]),
     agents: List<Agent>.from(json["agents"].map((x) => Agent.fromJson(x))),
     //statuses: Statuses.fromJson(json["statuses"]),
//     leadUser: Datum.fromJson(json["lead_user"]),
        sources: Sources.fromJson(json["sources"]??{}),
        //notes: List<Note>.from(json["notes"].map((x) => Note.fromJson(x))),
        newComments: List<NewComment>.from(
            json["new_comments"].map((x) => NewComment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "alt_phone": altPhone,
        "date": date.toIso8601String(),
        "dob": dob,
        "source": source,
        "priority": priority,
        "comment": comment,
//     "additional_comment": additionalComment,
//     "customer_id": customerId,
//     "developer_id":  developerId,
//     "property_id":  propertyId,
//     "property_preference": propertyPreference,
//     "job_profile": jobProfile,
        "avg_income": avgIncome,
//     "status": status,
//     "attachment": attachment,
//     "type": type,
//     "amount": amount,
//     "closed_date": closedDate.toIso8601String(),
//     "close_by": closeBy,
//     "lead_id": leadId,
//     "agent_id":  agentId,
//     "review": review,
//     "created_by": createdBy,
//     "assign_leads_count": assignLeadsCount,
//     "customer": customer,
//  //   "developer": developer?.toJson(),
// //    "property": property.toJson(),
    "agents": List<dynamic>.from(agents.map((x) => x.toJson())),
     //"statuses": statuses.toJson(),
//     "lead_user": leadUser.toJson(),
        "sources": sources.toJson(),
       // "notes": List<dynamic>.from(notes.map((x) => x.toJson())),
        "new_comments": List<dynamic>.from(newComments.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.leadId,
    required this.userId,
    required this.lead,
  });

  int id;
  int leadId;
  int userId;
  Lead? lead;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        leadId: json["lead_id"],
        userId: json["user_id"],
        lead: Lead.fromJson(json["lead"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lead_id": leadId,
        "user_id": userId,
        "lead": lead?.toJson(),
      };
}

class Agent {
  Agent({
    required this.id,
    required this.designationId,
    required this.firstName,
    required this.lastName,
    required this.email,
    */
/*required this.dob,
    required this.phone,
    required this.reportingPerson,
    required this.atContact,
    required this.address,
    required this.oldPassword,
    required this.deviceToken,
    required this.userProfile,
    required this.deviceId,
    required this.isExcluded,
    required this.permissionMenu,
    required this.dataOfJoining,
    required this.bloodGroup,
    required this.emergencyContactNumber,
    required this.emergencyContactName,
    required this.emergencyContactRelationship,
    required this.addressInUae,
    required this.nationality,
    required this.medicalConditions,
    required this.maritalStatus,
    required this.visaType,
    required this.educationDetails,
    required this.createdBy,
    required this.createdAt,
    required this.pivot,
    required this.metaData,*/ /*

  });

  int id;
  int designationId;
  String firstName;
  String lastName;
  String email;
  */
/*dynamic dob;
  int phone;
  int reportingPerson;
  dynamic atContact;
  String address;
  String oldPassword;
  String deviceToken;
  String userProfile;
  dynamic deviceId;
  int isExcluded;
  int permissionMenu;
  dynamic dataOfJoining;
  dynamic bloodGroup;
  dynamic emergencyContactNumber;
  dynamic emergencyContactName;
  String emergencyContactRelationship;
  dynamic addressInUae;
  dynamic nationality;
  dynamic medicalConditions;
  String maritalStatus;
  dynamic visaType;
  String educationDetails;
  dynamic createdBy;
  DateTime createdAt;
  Pivot pivot;
  MetaData metaData;*/ /*


  factory Agent.fromJson(Map<String, dynamic> json) => Agent(
        id: json["id"],
        designationId: json["designation_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        */
/*dob: json["dob"],
        phone: json["phone"],
        reportingPerson: json["reporting_person"],
        atContact: json["at_contact"],
        address: json["address"],
        oldPassword: json["old_password"],
        deviceToken: json["device_token"],
        userProfile: json["user_profile"],
        deviceId: json["device_id"],
        isExcluded: json["is_excluded"],
        permissionMenu: json["permission_menu"],
        dataOfJoining: json["data_of_joining"],
        bloodGroup: json["blood_group"],
        emergencyContactNumber: json["emergency_contact_number"],
        emergencyContactName: json["emergency_contact_name"],
        emergencyContactRelationship: json["emergency_contact_relationship"],
        addressInUae: json["address_in_uae"],
        nationality: json["nationality"],
        medicalConditions: json["medical_conditions"],
        maritalStatus: json["marital_status"],
        visaType: json["visa_type"],
        educationDetails: json["education_details"],
        createdBy: json["created_by"],
        createdAt: DateTime.parse(json["created_at"]),
        pivot: Pivot.fromJson(json["pivot"]),
        metaData: MetaData.fromJson(json["meta_data"]),*/ /*

      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "designation_id": designationId,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
       */
/* "dob": dob,
        "phone": phone,
        "reporting_person": reportingPerson,
        "at_contact": atContact,
        "address": address,
        "old_password": oldPassword,
        "device_token": deviceToken,
        "user_profile": userProfile,
        "device_id": deviceId,
        "is_excluded": isExcluded,
        "permission_menu": permissionMenu,
        "data_of_joining": dataOfJoining,
        "blood_group": bloodGroup,
        "emergency_contact_number": emergencyContactNumber,
        "emergency_contact_name": emergencyContactName,
        "emergency_contact_relationship": emergencyContactRelationship,
        "address_in_uae": addressInUae,
        "nationality": nationality,
        "medical_conditions": medicalConditions,
        "marital_status": maritalStatus,
        "visa_type": visaType,
        "education_details": educationDetails,
        "created_by": createdBy,
        "created_at": createdAt.toIso8601String(),
        "pivot": pivot.toJson(),
        "meta_data": metaData.toJson(),*/ /*

      };
}

class MetaData {
  MetaData({
    required this.indianNumber,
    required this.personalEmail,
    required this.emergencyNumber,
    required this.passportNumber,
    required this.passportExpiryDate,
    required this.visaNumber,
    required this.visaExpiryDate,
    required this.bankName,
    required this.bankIfsc,
    required this.accountNumber,
    required this.dob,
    required this.bloodGroup,
    required this.dataOfJoining,
    required this.addressInUae,
    required this.emergencyContactName,
    required this.emergencyContactRelationship,
    required this.nationality,
    required this.medicalConditions,
    required this.maritalStatus,
    required this.visaType,
    required this.educationDetails,
  });

  String indianNumber;
  dynamic personalEmail;
  dynamic emergencyNumber;
  dynamic passportNumber;
  dynamic passportExpiryDate;
  dynamic visaNumber;
  dynamic visaExpiryDate;
  dynamic bankName;
  dynamic bankIfsc;
  dynamic accountNumber;
  dynamic dob;
  dynamic bloodGroup;
  dynamic dataOfJoining;
  dynamic addressInUae;
  dynamic emergencyContactName;
  String emergencyContactRelationship;
  dynamic nationality;
  dynamic medicalConditions;
  String maritalStatus;
  dynamic visaType;
  String educationDetails;

  factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
        indianNumber: json["indian_number"],
        personalEmail: json["personal_email"],
        emergencyNumber: json["emergency_number"],
        passportNumber: json["passport_number"],
        passportExpiryDate: json["passport_expiry_date"],
        visaNumber: json["visa_number"],
        visaExpiryDate: json["visa_expiry_date"],
        bankName: json["bank_name"],
        bankIfsc: json["bank_ifsc"],
        accountNumber: json["account_number"],
        dob: json["dob"],
        bloodGroup: json["blood_group "],
        dataOfJoining: json["data_of_joining "],
        addressInUae: json["address_in_uae"],
        emergencyContactName: json["emergency_contact_name"],
        emergencyContactRelationship: json["emergency_contact_relationship"],
        nationality: json["nationality"],
        medicalConditions: json["medical_conditions"],
        maritalStatus: json["marital_status"],
        visaType: json["visa_type"],
        educationDetails: json["education_details"],
      );

  Map<String, dynamic> toJson() => {
        "indian_number": indianNumber,
        "personal_email": personalEmail,
        "emergency_number": emergencyNumber,
        "passport_number": passportNumber,
        "passport_expiry_date": passportExpiryDate,
        "visa_number": visaNumber,
        "visa_expiry_date": visaExpiryDate,
        "bank_name": bankName,
        "bank_ifsc": bankIfsc,
        "account_number": accountNumber,
        "dob": dob,
        "blood_group ": bloodGroup,
        "data_of_joining ": dataOfJoining,
        "address_in_uae": addressInUae,
        "emergency_contact_name": emergencyContactName,
        "emergency_contact_relationship": emergencyContactRelationship,
        "nationality": nationality,
        "medical_conditions": medicalConditions,
        "marital_status": maritalStatus,
        "visa_type": visaType,
        "education_details": educationDetails,
      };
}

class NewComment {
  NewComment({
    required this.id,
    required this.leadId,
    required this.agentId,
    required this.date,
    required this.time,
    required this.newComments,
    required this.createdAt,
    required this.updatedAt,
  });

  int? id;
  int? leadId;
  int? agentId;
  DateTime date;
  String? time;
  String? newComments;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory NewComment.fromJson(Map<String, dynamic> json) => NewComment(
        id: json["id"],
        leadId: json["lead_id"],
        agentId: json["agent_id"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
        newComments: json["new_comments"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lead_id": leadId,
        "agent_id": agentId,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "time": time,
        "new_comments": newComments,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class Note {
  Note({
    required this.id,
    required this.relId,
    required this.relType,
    required this.description,
    required this.dateContacted,
    required this.addedfrom,
    required this.dateadded,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int relId;
  String relType;
  String description;
  dynamic dateContacted;
  int addedfrom;
  DateTime dateadded;
  DateTime createdAt;
  DateTime updatedAt;

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json["id"],
        relId: json["rel_id"],
        relType: json["rel_type"],
        description: json["description"],
        dateContacted: json["date_contacted"],
        addedfrom: json["addedfrom"],
        dateadded: DateTime.parse(json["dateadded"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rel_id": relId,
        "rel_type": relType,
        "description": description,
        "date_contacted": dateContacted,
        "addedfrom": addedfrom,
        "dateadded": dateadded.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Pivot {
  Pivot({
    required this.leadId,
    required this.userId,
  });

  int leadId;
  int userId;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        leadId: json["lead_id"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "lead_id": leadId,
        "user_id": userId,
      };
}

class Developer {
  Developer({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String phone;
  String address;
  DateTime createdAt;
  DateTime updatedAt;

  factory Developer.fromJson(Map<String, dynamic> json) => Developer(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "address": address,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Property {
  Property({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.cityId,
    required this.address,
    required this.developerId,
    required this.budget,
    required this.image,
    required this.featuredProperty,
    required this.createdAt,
    required this.updatedAt,
    required this.ameneties,
  });

  int id;
  String name;
  String slug;
  dynamic description;
  int cityId;
  String address;
  int developerId;
  String budget;
  String image;
  String featuredProperty;
  DateTime createdAt;
  DateTime updatedAt;
  List<dynamic> ameneties;

  factory Property.fromJson(Map<String, dynamic> json) => Property(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        description: json["description"],
        cityId: json["city_id"],
        address: json["address"],
        developerId: json["developer_id"],
        budget: json["budget"],
        image: json["image"],
        featuredProperty: json["featured_property"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        ameneties: List<dynamic>.from(json["ameneties"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "description": description,
        "city_id": cityId,
        "address": address,
        "developer_id": developerId,
        "budget": budget,
        "image": image,
        "featured_property": featuredProperty,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "ameneties": List<dynamic>.from(ameneties.map((x) => x)),
      };
}

class Sources {
  Sources({
    required this.id,
    required this.name,
    required this.status,
   */
/* required this.createdAt,
    required this.updatedAt,*/ /*

  });

  int? id;
  String? name;
  String? status;
  */
/*DateTime? createdAt;
  DateTime? updatedAt;*/ /*


  factory Sources.fromJson(Map<String, dynamic> json) => Sources(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        */
/*createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),*/ /*

      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        */
/*"created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),*/ /*

      };
}

class Statuses {
  Statuses({
    required this.id,
    required this.name,
    //   required this.statusorder,
    required this.color,
    required this.isdefault,
    //required this.createdAt,
    //required this.updatedAt,
  });

  int id;
  String name;

  // int statusorder;
  String color;
  int isdefault;
  //DateTime createdAt;
  //DateTime updatedAt;

  factory Statuses.fromJson(Map<String, dynamic> json) => Statuses(
        id: json["id"],
        name: json["name"],
        //   statusorder: json["statusorder"] == null ? null : json["statusorder"],
        color: json["color"],
        isdefault: json["isdefault"],
        //createdAt: DateTime.parse(json["created_at"]),
        //updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        //  "statusorder": statusorder == null ? null : statusorder,
        "color": color,
        "isdefault": isdefault,
        //"created_at": createdAt.toIso8601String(),
        //"updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
*/

import 'dart:convert';

LeadsModel leadsModelFromJson(String str) =>
    LeadsModel.fromJson(json.decode(str));

String leadsModelToJson(LeadsModel data) => json.encode(data.toJson());

class LeadsModel {
  LeadsModel({
    required this.success,
    required this.count,
    required this.data,
    required this.message,
  });

  int success;
  int count;
  Data data;
  String message;

  factory LeadsModel.fromJson(Map<String, dynamic> json) => LeadsModel(
        success: json["success"],
        count: json["count"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "count": count,
        "data": data.toJson(),
        "message": message,
      };
}

class Data {
  Data({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
    required this.total,
  });

  int currentPage;
  List<Lead> data;
  var firstPageUrl;
  int from;
  int lastPage;
  var lastPageUrl;
  var nextPageUrl;
  var path;
  var perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: List<Lead>.from(json["data"].map((x) => Lead.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Lead {
  int? id;
  String? loanAgreementNo;
  String? applicationId;
  String? customername;
  String? month;
  String? flowRecovery;
  String? securedUnsecured;
  String? bkt;
  String? actualBkt;
  String? lmbBkt;
  String? tmCode;
  String? branch;
  String? branchid;
  String? stateName;
  String? ncms;
  String? repaymentMode;
  String? collectionManager;
  String? clusterManager;
  String? stateManager;
  String? tmName;
  String? rcms;
  String? top125;
  String? category;
  String? agencyCat;
  String? agencyNameWithCode;
  String? fosName;
  String? eReceiptId;
  String? mobNumber;
  String? feedback;
  String? code;
  String? remove;
  String? reasonOfBounce;
  String? standardReason;
  String? assetMake;
  String? registrationNo;
  String? productflag;
  String? prod;
  int? loanAmount;
  String? loanBookingDate;
  String? loanMaturityDate;
  String? disbursalDate;
  String? dueDate;
  String? emiAmount;
  String? emiDue;
  String? bounceChargeDue;
  String? lppDue;
  String? tos;
  String? pos;
  String? collAmt;
  String? dcr;
  String? rorColl;
  String? short;
  String? piColl;
  String? pgt;
  String? bistStatus;
  String? clr;
  String? status;
  String? rb;
  String? sb;
  String? firstEmiDueDate;
  String? allocationDate;
  String? scheme;
  String? supplier;
  String? tenure;
  String? referenceNames;
  String? referenceNames2;
  String? referenceNames3;
  String? referenceAddress;
  String? referenceAddress3;
  String? referenceAddress2;
  String? customerAddPhone1;
  String? custEreceiptMobileNo;
  String? customerAddMobile;
  String? customerAddPhone2;
  String? customerAddress;
  String? custPermanentAddress;
  String? custOfficeAddress;
  String? custOfficeAddZipcode;
  String? custPermanentAddZipcode;
  String? primaryCustomerFathername;
  String? techNonTech;
  String? nonstartercases;
  String? zone;
  String? dealerCode;
  String? grossLtv;
  String? netLtv;
  String? seName;
  String? seCode;
  String? customerCategory;
  String? riskBand;
  String? contactabilityIndex;
  String? digitalAffinity;
  String? loanStatus;
  String? dpd;
  String? emiBilled;
  String? date;
  String? type;
  String? priority;
  String? e_receipting_ids;
  String? strategy;
  String? loan_age;
  String? color_code;
  String? mob;
  String? mob_type;
  String? recovery_no;
  String? priority_pool;
  int? source;
  List<Agents>? agents;
  Statuses? statuses;
  LeadUser? leadUser;
  Sources? sources;
  List<NewComment>? newComments;

  Lead(
      {this.id,
      this.loanAgreementNo,
      this.applicationId,
      this.customername,
      this.month,
      this.flowRecovery,
      this.securedUnsecured,
      this.bkt,
      this.actualBkt,
      this.lmbBkt,
      this.tmCode,
      this.branch,
      this.branchid,
      this.stateName,
      this.ncms,
      this.repaymentMode,
      this.collectionManager,
      this.clusterManager,
      this.stateManager,
      this.tmName,
      this.rcms,
      this.top125,
      this.category,
      this.agencyCat,
      this.agencyNameWithCode,
      this.fosName,
      this.eReceiptId,
      this.mobNumber,
      this.feedback,
      this.code,
      this.remove,
      this.reasonOfBounce,
      this.standardReason,
      this.assetMake,
      this.registrationNo,
      this.productflag,
      this.prod,
      this.loanAmount,
      this.loanBookingDate,
      this.loanMaturityDate,
      this.disbursalDate,
      this.dueDate,
      this.emiAmount,
      this.emiDue,
      this.bounceChargeDue,
      this.lppDue,
      this.tos,
      this.pos,
      this.collAmt,
      this.dcr,
      this.rorColl,
      this.short,
      this.piColl,
      this.pgt,
      this.bistStatus,
      this.clr,
      this.status,
      this.rb,
      this.sb,
      this.firstEmiDueDate,
      this.allocationDate,
      this.scheme,
      this.supplier,
      this.tenure,
      this.referenceNames,
      this.referenceNames2,
      this.referenceNames3,
      this.referenceAddress,
      this.referenceAddress3,
      this.referenceAddress2,
      this.customerAddPhone1,
      this.custEreceiptMobileNo,
      this.customerAddMobile,
      this.customerAddPhone2,
      this.customerAddress,
      this.custPermanentAddress,
      this.custOfficeAddress,
      this.custOfficeAddZipcode,
      this.custPermanentAddZipcode,
      this.primaryCustomerFathername,
      this.techNonTech,
      this.nonstartercases,
      this.zone,
      this.dealerCode,
      this.grossLtv,
      this.netLtv,
      this.seName,
      this.seCode,
      this.customerCategory,
      this.riskBand,
      this.contactabilityIndex,
      this.digitalAffinity,
      this.loanStatus,
      this.dpd,
      this.emiBilled,
      this.date,
      this.type,
      this.priority,
      this.source,
      this.e_receipting_ids,
      this.strategy,
      this.loan_age,
      this.color_code,
      this.mob,
      this.mob_type,
      this.recovery_no,
      this.priority_pool,
      this.agents,
      this.statuses,
      this.leadUser,
      this.sources,
      this.newComments});

  Lead.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    loanAgreementNo = json['loan_agreement_no'];
    applicationId = json['application_id'];
    customername = json['customername'];
    month = json['month'];
    flowRecovery = json['flow_recovery'];
    securedUnsecured = json['secured_unsecured'];
    bkt = json['bkt'];
    actualBkt = json['actual_bkt'];
    lmbBkt = json['lmb_bkt'];
    tmCode = json['tm_code'];
    branch = json['branch'];
    branchid = json['branchid'];
    stateName = json['state_name'];
    ncms = json['ncms'];
    repaymentMode = json['repayment_mode'];
    collectionManager = json['collection_manager'];
    clusterManager = json['cluster_manager'];
    stateManager = json['state_manager'];
    tmName = json['tm_name'];
    rcms = json['rcms'];
    top125 = json['top_125'];
    category = json['category'];
    agencyCat = json['agency_cat'];
    agencyNameWithCode = json['agency_name_with_code'];
    fosName = json['fos_name'];
    eReceiptId = json['e_receipt_id'];
    mobNumber = json['mob_number'];
    feedback = json['feedback'];
    code = json['code'];
    remove = json['remove'];
    reasonOfBounce = json['reason_of_bounce'];
    standardReason = json['standard_reason'];
    assetMake = json['asset_make'];
    registrationNo = json['registration_no'];
    productflag = json['productflag'];
    prod = json['prod'];
    loanAmount = json['loan_amount'];
    loanBookingDate = json['loan_booking_date'];
    loanMaturityDate = json['loan_maturity_date'];
    disbursalDate = json['disbursal_date'];
    dueDate = json['due_date'];
    emiAmount = json['emi_amount'];
    emiDue = json['emi_due'];
    bounceChargeDue = json['bounce_charge_due'];
    lppDue = json['lpp_due'];
    tos = json['tos'];
    pos = json['pos'];
    collAmt = json['coll_amt'];
    dcr = json['dcr'];
    rorColl = json['ror_coll'];
    short = json['short'];
    piColl = json['pi_coll'];
    pgt = json['pgt'];
    bistStatus = json['bist_status'];
    clr = json['clr'];
    status = json['status'];
    rb = json['rb'];
    sb = json['sb'];
    firstEmiDueDate = json['first_emi_due_date'];
    allocationDate = json['allocation_date'];
    scheme = json['scheme'];
    supplier = json['supplier'];
    tenure = json['tenure'];
    referenceNames = json['reference_names'];
    referenceNames2 = json['reference_names2'];
    referenceNames3 = json['reference_names3'];
    referenceAddress = json['reference_address'];
    referenceAddress3 = json['reference_address3'];
    referenceAddress2 = json['reference_address2'];
    customerAddPhone1 = json['customer_add_phone_1'];
    custEreceiptMobileNo = json['cust_ereceipt_mobile_no'];
    customerAddMobile = json['customer_add_mobile'];
    customerAddPhone2 = json['customer_add_phone_2'];
    customerAddress = json['customer_address'];
    custPermanentAddress = json['cust_permanent_address'];
    custOfficeAddress = json['cust_office_address'];
    custOfficeAddZipcode = json['cust_office_add_zipcode'];
    custPermanentAddZipcode = json['cust_permanent_add_zipcode'];
    primaryCustomerFathername = json['primary_customer_fathername'];
    techNonTech = json['tech_non_tech'];
    nonstartercases = json['nonstartercases'];
    zone = json['zone'];
    dealerCode = json['dealer_code'];
    grossLtv = json['gross_ltv'];
    netLtv = json['net_ltv'];
    seName = json['se_name'];
    seCode = json['se_code'];
    customerCategory = json['customer_category'];
    riskBand = json['risk_band'];
    contactabilityIndex = json['contactability_index'];
    digitalAffinity = json['digital_affinity'];
    loanStatus = json['loan_status'];
    dpd = json['dpd'];
    emiBilled = json['emi_billed'];
    date = json['date'];
    type = json['type'];
    priority = json['priority'];
    source = json['source'];
    strategy = json['strategy'];
    loan_age = json['loan_age'];
    color_code = json['color_code'];
    mob = json['mob'];
    mob_type = json['mob_type'];
    recovery_no = json['recovery_no'];
    priority_pool = json['priority_pool'];
    e_receipting_ids = json['e_receipting_ids'];
    source = json['source'];
    if (json['agents'] != null) {
      agents = <Agents>[];
      json['agents'].forEach((v) {
        agents!.add(Agents.fromJson(v));
      });
    }
    statuses =
        json['statuses'] != null ? Statuses.fromJson(json['statuses']) : null;
    leadUser =
        json['lead_user'] != null ? LeadUser.fromJson(json['lead_user']) : null;
    sources =
        json['sources'] != null ? Sources.fromJson(json['sources']) : null;
    if (json['new_comments'] != null) {
      newComments = <NewComment>[];
      json['new_comments'].forEach((v) {
        newComments!.add(NewComment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['loan_agreement_no'] = loanAgreementNo;
    data['application_id'] = applicationId;
    data['customername'] = customername;
    data['month'] = month;
    data['flow_recovery'] = flowRecovery;
    data['secured_unsecured'] = securedUnsecured;
    data['bkt'] = bkt;
    data['actual_bkt'] = actualBkt;
    data['lmb_bkt'] = lmbBkt;
    data['tm_code'] = tmCode;
    data['branch'] = branch;
    data['branchid'] = branchid;
    data['state_name'] = stateName;
    data['ncms'] = ncms;
    data['repayment_mode'] = repaymentMode;
    data['collection_manager'] = collectionManager;
    data['cluster_manager'] = clusterManager;
    data['state_manager'] = stateManager;
    data['tm_name'] = tmName;
    data['rcms'] = rcms;
    data['top_125'] = top125;
    data['category'] = category;
    data['agency_cat'] = agencyCat;
    data['agency_name_with_code'] = agencyNameWithCode;
    data['fos_name'] = fosName;
    data['e_receipt_id'] = eReceiptId;
    data['mob_number'] = mobNumber;
    data['feedback'] = feedback;
    data['code'] = code;
    data['remove'] = remove;
    data['reason_of_bounce'] = reasonOfBounce;
    data['standard_reason'] = standardReason;
    data['asset_make'] = assetMake;
    data['registration_no'] = registrationNo;
    data['productflag'] = productflag;
    data['prod'] = prod;
    data['loan_amount'] = loanAmount;
    data['loan_booking_date'] = loanBookingDate;
    data['loan_maturity_date'] = loanMaturityDate;
    data['disbursal_date'] = disbursalDate;
    data['due_date'] = dueDate;
    data['emi_amount'] = emiAmount;
    data['emi_due'] = emiDue;
    data['bounce_charge_due'] = bounceChargeDue;
    data['lpp_due'] = lppDue;
    data['tos'] = tos;
    data['pos'] = pos;
    data['coll_amt'] = collAmt;
    data['dcr'] = dcr;
    data['ror_coll'] = rorColl;
    data['short'] = short;
    data['pi_coll'] = piColl;
    data['pgt'] = pgt;
    data['bist_status'] = bistStatus;
    data['clr'] = clr;
    data['status'] = status;
    data['rb'] = rb;
    data['sb'] = sb;
    data['first_emi_due_date'] = firstEmiDueDate;
    data['allocation_date'] = allocationDate;
    data['scheme'] = scheme;
    data['supplier'] = supplier;
    data['tenure'] = tenure;
    data['reference_names'] = referenceNames;
    data['reference_names2'] = referenceNames2;
    data['reference_names3'] = referenceNames3;
    data['reference_address'] = referenceAddress;
    data['reference_address3'] = referenceAddress3;
    data['reference_address2'] = referenceAddress2;
    data['customer_add_phone_1'] = customerAddPhone1;
    data['cust_ereceipt_mobile_no'] = custEreceiptMobileNo;
    data['customer_add_mobile'] = customerAddMobile;
    data['customer_add_phone_2'] = customerAddPhone2;
    data['customer_address'] = customerAddress;
    data['cust_permanent_address'] = custPermanentAddress;
    data['cust_office_address'] = custOfficeAddress;
    data['cust_office_add_zipcode'] = custOfficeAddZipcode;
    data['cust_permanent_add_zipcode'] = custPermanentAddZipcode;
    data['primary_customer_fathername'] = primaryCustomerFathername;
    data['tech_non_tech'] = techNonTech;
    data['nonstartercases'] = nonstartercases;
    data['zone'] = zone;
    data['dealer_code'] = dealerCode;
    data['gross_ltv'] = grossLtv;
    data['net_ltv'] = netLtv;
    data['se_name'] = seName;
    data['se_code'] = seCode;
    data['customer_category'] = customerCategory;
    data['risk_band'] = riskBand;
    data['contactability_index'] = contactabilityIndex;
    data['digital_affinity'] = digitalAffinity;
    data['loan_status'] = loanStatus;
    data['dpd'] = dpd;
    data['emi_billed'] = emiBilled;
    data['date'] = date;
    data['type'] = type;
    data['strategy'] = strategy;
    data['loan_age'] = loan_age;
    data['color_code'] = color_code;
    data['mob'] = mob;
    data['mob_type'] = mob_type;
    data['recovery_no'] = recovery_no;
    data['priority_pool'] = priority_pool;
    data['e_receipting_ids'] = e_receipting_ids;
    data['priority'] = priority;
    data['source'] = source;
    if (agents != null) {
      data['agents'] = agents!.map((v) => v.toJson()).toList();
    }
    if (statuses != null) {
      data['statuses'] = statuses!.toJson();
    }
    if (leadUser != null) {
      data['lead_user'] = leadUser!.toJson();
    }
    if (sources != null) {
      data['sources'] = sources!.toJson();
    }
    if (newComments != null) {
      data['new_comments'] = newComments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Agents {
  int? id;
  int? designationId;
  String? firstName;
  String? lastName;
  String? email;
  String? dob;
  int? phone;
  int? reportingPerson;
  String? atContact;
  String? address;
  String? deviceToken;
  String? userProfile;
  String? status;
  String? availability;
  String? deviceId;
  int? isExcluded;
  int? permissionMenu;
  int? permissionForCl;
  String? dataOfJoining;
  String? bloodGroup;
  String? emergencyContactNumber;
  String? emergencyContactName;
  String? emergencyContactRelationship;
  String? addressInUae;
  String? nationality;
  String? medicalConditions;
  String? maritalStatus;
  String? visaType;
  String? educationDetails;
  int? companyId;
  String? createdBy;
  String? createdAt;
  String? fullName;
  Pivot? pivot;
  MetaData? metaData;

  Agents(
      {this.id,
      this.designationId,
      this.firstName,
      this.lastName,
      this.email,
      this.dob,
      this.phone,
      this.reportingPerson,
      this.atContact,
      this.address,
      this.deviceToken,
      this.userProfile,
      this.status,
      this.availability,
      this.deviceId,
      this.isExcluded,
      this.permissionMenu,
      this.permissionForCl,
      this.dataOfJoining,
      this.bloodGroup,
      this.emergencyContactNumber,
      this.emergencyContactName,
      this.emergencyContactRelationship,
      this.addressInUae,
      this.nationality,
      this.medicalConditions,
      this.maritalStatus,
      this.visaType,
      this.educationDetails,
      this.companyId,
      this.createdBy,
      this.createdAt,
      this.fullName,
      this.pivot,
      this.metaData});

  Agents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    designationId = json['designation_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    dob = json['dob'];
    phone = json['phone'];
    reportingPerson = json['reporting_person'];
    atContact = json['at_contact'];
    address = json['address'];
    deviceToken = json['device_token'];
    userProfile = json['user_profile'];
    status = json['status'];
    availability = json['availability'];
    deviceId = json['device_id'];
    isExcluded = json['is_excluded'];
    permissionMenu = json['permission_menu'];
    permissionForCl = json['permission_for_cl'];
    dataOfJoining = json['data_of_joining'];
    bloodGroup = json['blood_group'];
    emergencyContactNumber = json['emergency_contact_number'];
    emergencyContactName = json['emergency_contact_name'];
    emergencyContactRelationship = json['emergency_contact_relationship'];
    addressInUae = json['address_in_uae'];
    nationality = json['nationality'];
    medicalConditions = json['medical_conditions'];
    maritalStatus = json['marital_status'];
    visaType = json['visa_type'];
    educationDetails = json['education_details'];
    companyId = json['company_id'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    fullName = json['full_name'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
    metaData =
        json['meta_data'] != null ? MetaData.fromJson(json['meta_data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['designation_id'] = designationId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['dob'] = dob;
    data['phone'] = phone;
    data['reporting_person'] = reportingPerson;
    data['at_contact'] = atContact;
    data['address'] = address;
    data['device_token'] = deviceToken;
    data['user_profile'] = userProfile;
    data['status'] = status;
    data['availability'] = availability;
    data['device_id'] = deviceId;
    data['is_excluded'] = isExcluded;
    data['permission_menu'] = permissionMenu;
    data['permission_for_cl'] = permissionForCl;
    data['data_of_joining'] = dataOfJoining;
    data['blood_group'] = bloodGroup;
    data['emergency_contact_number'] = emergencyContactNumber;
    data['emergency_contact_name'] = emergencyContactName;
    data['emergency_contact_relationship'] = emergencyContactRelationship;
    data['address_in_uae'] = addressInUae;
    data['nationality'] = nationality;
    data['medical_conditions'] = medicalConditions;
    data['marital_status'] = maritalStatus;
    data['visa_type'] = visaType;
    data['education_details'] = educationDetails;
    data['company_id'] = companyId;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['full_name'] = fullName;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    if (metaData != null) {
      data['meta_data'] = metaData!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? leadId;
  int? userId;

  Pivot({this.leadId, this.userId});

  Pivot.fromJson(Map<String, dynamic> json) {
    leadId = json['lead_id'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lead_id'] = leadId;
    data['user_id'] = userId;
    return data;
  }
}

class MetaData {
  String? indianNumber;
  String? dob;
  String? bloodGroup;
  String? personalEmail;
  String? emergencyNumber;
  String? passportNumber;
  String? passportExpiryDate;
  String? visaNumber;
  String? visaExpiryDate;
  String? bankName;
  String? bankIfsc;
  String? accountNumber;
  String? addressInUae;
  String? emergencyContactName;
  String? emergencyContactRelationship;
  String? nationality;
  String? medicalConditions;
  String? maritalStatus;
  String? visaType;
  String? educationDetails;

  MetaData(
      {this.indianNumber,
      this.dob,
      this.bloodGroup,
      this.personalEmail,
      this.emergencyNumber,
      this.passportNumber,
      this.passportExpiryDate,
      this.visaNumber,
      this.visaExpiryDate,
      this.bankName,
      this.bankIfsc,
      this.accountNumber,
      this.addressInUae,
      this.emergencyContactName,
      this.emergencyContactRelationship,
      this.nationality,
      this.medicalConditions,
      this.maritalStatus,
      this.visaType,
      this.educationDetails});

  MetaData.fromJson(Map<String, dynamic> json) {
    indianNumber = json['indian_number'];
    dob = json['dob'];
    bloodGroup = json['blood_group'];
    personalEmail = json['personal_email'];
    emergencyNumber = json['emergency_number'];
    passportNumber = json['passport_number'];
    passportExpiryDate = json['passport_expiry_date'];
    visaNumber = json['visa_number'];
    visaExpiryDate = json['visa_expiry_date'];
    bankName = json['bank_name'];
    bankIfsc = json['bank_ifsc'];
    accountNumber = json['account_number'];
    addressInUae = json['address_in_uae'];
    emergencyContactName = json['emergency_contact_name'];
    emergencyContactRelationship = json['emergency_contact_relationship'];
    nationality = json['nationality'];
    medicalConditions = json['medical_conditions'];
    maritalStatus = json['marital_status'];
    visaType = json['visa_type'];
    educationDetails = json['education_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['indian_number'] = indianNumber;
    data['dob'] = dob;
    data['blood_group'] = bloodGroup;
    data['personal_email'] = personalEmail;
    data['emergency_number'] = emergencyNumber;
    data['passport_number'] = passportNumber;
    data['passport_expiry_date'] = passportExpiryDate;
    data['visa_number'] = visaNumber;
    data['visa_expiry_date'] = visaExpiryDate;
    data['bank_name'] = bankName;
    data['bank_ifsc'] = bankIfsc;
    data['account_number'] = accountNumber;
    data['address_in_uae'] = addressInUae;
    data['emergency_contact_name'] = emergencyContactName;
    data['emergency_contact_relationship'] = emergencyContactRelationship;
    data['nationality'] = nationality;
    data['medical_conditions'] = medicalConditions;
    data['marital_status'] = maritalStatus;
    data['visa_type'] = visaType;
    data['education_details'] = educationDetails;
    return data;
  }
}

class Statuses {
  int? id;
  String? name;
  int? statusorder;
  String? color;
  int? isdefault;
  String? createdAt;
  String? updatedAt;

  Statuses(
      {this.id,
      this.name,
      this.statusorder,
      this.color,
      this.isdefault,
      this.createdAt,
      this.updatedAt});

  Statuses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    statusorder = json['statusorder'];
    color = json['color'];
    isdefault = json['isdefault'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['statusorder'] = statusorder;
    data['color'] = color;
    data['isdefault'] = isdefault;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class LeadUser {
  int? id;
  int? leadId;
  int? userId;

  LeadUser({this.id, this.leadId, this.userId});

  LeadUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leadId = json['lead_id'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['lead_id'] = leadId;
    data['user_id'] = userId;
    return data;
  }
}

class Sources {
  int? id;
  String? name;
  int? status;
  int? isCroned;
  String? createdAt;
  String? updatedAt;

  Sources(
      {this.id,
      this.name,
      this.status,
      this.isCroned,
      this.createdAt,
      this.updatedAt});

  Sources.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    isCroned = json['is_croned'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['is_croned'] = isCroned;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

// class Lead {
//   Lead({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.phone,
//     required this.altPhone,
//     required this.date,
//     required this.dob,
//     required this.source,
//     required this.priority,
//     required this.comment,
//     //required this.additionalComment,
//     //required this.customerId,
//     //    required this.developerId,
//     //    required this.propertyId,
//     //    required this.propertyPreference,
//     //    required this.jobProfile,
//     required this.avgIncome,
//     //    required this.status,
//     //    required this.attachment,
//     //    required this.type,
//     required this.amount,
//     //    required this.closedDate,
//     //    required this.closeBy,
//     required this.leadId,
//     //   required  this.agentId,
//     //    required this.review,
//     //    required this.createdBy,
//     //    required this.assignLeadsCount,
//     //    required this.customer,
//     //    //required this.developer,
//     // //   required this.property,
//     required this.agents,
//     required this.statuses,
//     //    required this.leadUser,
//     required this.sources,
//     //required this.notes,
//     required this.newComments,
//   });
//
//   int id;
//   String name;
//   String? email;
//   String phone;
//   String? altPhone;
//   DateTime date;
//   String? dob;
//
//   String? source;
//   String? priority;
//   String? comment;
//
// //   dynamic additionalComment;
// //   dynamic customerId;
// //   int? developerId;
// //   int? propertyId;
// //   dynamic propertyPreference;
// //   dynamic jobProfile;
//   String? avgIncome;
//
// //   int? status;
// //   dynamic attachment;
// //   String? type;
//   String? amount;
//
// //   DateTime closedDate;
// //   int? closeBy;
//   int? leadId;
// //   int? agentId;
// //   dynamic review;
// //   int? createdBy;
// //   int? assignLeadsCount;
// //   dynamic customer;
// //   //Developer? developer;
// // //  Property property;
//   List<Agent>? agents;
//   Statuses? statuses;
// //   Datum leadUser;
//   Sources? sources;
//
//   //List<Note> notes;
//   List<NewComment>? newComments;
//
//   factory Lead.fromJson(Map<String, dynamic> json) => Lead(
//         id: json["id"].runtimeType == 0.runtimeType
//             ? json["id"]
//             : int.parse(json["id"]),
//         name: json["name"],
//         email: json["email"],
//         phone: json["phone"],
//         altPhone: json["alt_phone"] ?? 'No Alternate Number',
//         date: DateTime.parse(json["date"]),
//         dob: json["dob"],
//         source: json["source"],
//         priority: json["priority"],
//         comment: json["comment"],
// //    additionalComment: json["additional_comment"],
// //     customerId: json["customer_id"],
// //     developerId:  json["developer_id"],
// //     propertyId:  json["property_id"],
// //     propertyPreference: json["property_preference"],
// //     jobProfile: json["job_profile"],
//         avgIncome: json["avg_income"] ?? 'No Data Available',
// //     status: json["status"],
// //     attachment: json["attachment"],
// //     type: json["type"],
//         amount: json["amount"],
// //     closedDate: DateTime.parse(json["closed_date"]),
// //     closeBy: json["close_by"],
// //         leadId: json["lead_id"],
//         leadId: json["id"],
// //     agentId:  json["agent_id"],
// //     review: json["review"],
// //     createdBy: json["created_by"],
// //     assignLeadsCount: json["assign_leads_count"],
// //     customer: json["customer"],
// //     //developer:  Developer.fromJson(json["developer"]),
// //    // property:  Property.fromJson(json["property"]),
//         agents: json["agents"] != null
//             ? List<Agent>.from(json["agents"].map((x) => Agent.fromJson(x)))
//             : null,
//         statuses: json["statuses"] != null
//             ? Statuses.fromJson(json["statuses"])
//             : null,
// //     leadUser: Datum.fromJson(json["lead_user"]),
//         sources: json["sources"] != null
//             ? Sources.fromJson(json["sources"] ?? {})
//             : null,
//         //notes: List<Note>.from(json["notes"].map((x) => Note.fromJson(x))),
//         newComments: json["new_comments"] != null
//             ? List<NewComment>.from(
//                 json["new_comments"].map((x) => NewComment.fromJson(x)))
//             : null,
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "email": email,
//         "phone": phone,
//         "alt_phone": altPhone,
//         "date": date.toIso8601String(),
//         "dob": dob,
//         "source": source,
//         "priority": priority,
//         "comment": comment,
// //     "additional_comment": additionalComment,
// //     "customer_id": customerId,
// //     "developer_id":  developerId,
// //     "property_id":  propertyId,
// //     "property_preference": propertyPreference,
// //     "job_profile": jobProfile,
//         "avg_income": avgIncome,
// //     "status": status,
// //     "attachment": attachment,
// //     "type": type,
// //     "amount": amount,
// //     "closed_date": closedDate.toIso8601String(),
// //     "close_by": closeBy,
//         "lead_id": leadId,
// //     "agent_id":  agentId,
// //     "review": review,
// //     "created_by": createdBy,
// //     "assign_leads_count": assignLeadsCount,
// //     "customer": customer,
// //  //   "developer": developer?.toJson(),
// // //    "property": property.toJson(),
//         "agents": List<dynamic>.from(agents!.map((x) => x.toJson())),
//         //"statuses": statuses.toJson(),
// //     "lead_user": leadUser.toJson(),
//         "sources": sources!.toJson(),
//         // "notes": List<dynamic>.from(notes.map((x) => x.toJson())),
//         "new_comments": List<dynamic>.from(newComments!.map((x) => x.toJson())),
//       };
// }
//
// class Datum {
//   Datum({
//     required this.id,
//     required this.leadId,
//     required this.userId,
//     required this.lead,
//   });
//
//   int id;
//   int leadId;
//   int userId;
//   Lead lead;
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         id: json["id"],
//         leadId: json["lead_id"],
//         userId: json["user_id"],
//         lead: Lead.fromJson(json["lead"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "lead_id": leadId,
//         "user_id": userId,
//         "lead": lead.toJson(),
//       };
// }
//
// class Agent {
//   Agent({
//     required this.id,
//     required this.designationId,
//     required this.firstName,
//     required this.fullName,
//     required this.lastName,
//     required this.email,
//     this.userProfile,
//     /*required this.dob,
//     required this.phone,
//     required this.reportingPerson,
//     required this.atContact,
//     required this.address,
//     required this.oldPassword,
//     required this.deviceToken,
//     required this.userProfile,
//     required this.deviceId,
//     required this.isExcluded,
//     required this.permissionMenu,
//     required this.dataOfJoining,
//     required this.bloodGroup,
//     required this.emergencyContactNumber,
//     required this.emergencyContactName,
//     required this.emergencyContactRelationship,
//     required this.addressInUae,
//     required this.nationality,
//     required this.medicalConditions,
//     required this.maritalStatus,
//     required this.visaType,
//     required this.educationDetails,
//     required this.createdBy,
//     required this.createdAt,
//     required this.pivot,
//     required this.metaData,*/
//   });
//
//   int id;
//   int? designationId;
//   String fullName;
//   String firstName;
//   String lastName;
//   String? email;
//   String? userProfile;
//
//   /*dynamic dob;
//   int phone;
//   int reportingPerson;
//   dynamic atContact;
//   String address;
//   String oldPassword;
//   String deviceToken;
//   dynamic deviceId;
//   int isExcluded;
//   int permissionMenu;
//   dynamic dataOfJoining;
//   dynamic bloodGroup;
//   dynamic emergencyContactNumber;
//   dynamic emergencyContactName;
//   String emergencyContactRelationship;
//   dynamic addressInUae;
//   dynamic nationality;
//   dynamic medicalConditions;
//   String maritalStatus;
//   dynamic visaType;
//   String educationDetails;
//   dynamic createdBy;
//   DateTime createdAt;
//   Pivot pivot;
//   MetaData metaData;*/
//
//   factory Agent.fromJson(Map<String, dynamic> json) {
//     return Agent(
//       id: json["id"],
//       designationId: json["designation_id"],
//       fullName: json["full_name"],
//       firstName: json["first_name"],
//       lastName: json["last_name"] ?? "",
//       email: json["email"],
//       userProfile: json["user_profile"],
//       /*dob: json["dob"],
//         phone: json["phone"],
//         reportingPerson: json["reporting_person"],
//         atContact: json["at_contact"],
//         address: json["address"],
//         oldPassword: json["old_password"],
//         deviceToken: json["device_token"],
//         userProfile: json["user_profile"],
//         deviceId: json["device_id"],
//         isExcluded: json["is_excluded"],
//         permissionMenu: json["permission_menu"],
//         dataOfJoining: json["data_of_joining"],
//         bloodGroup: json["blood_group"],
//         emergencyContactNumber: json["emergency_contact_number"],
//         emergencyContactName: json["emergency_contact_name"],
//         emergencyContactRelationship: json["emergency_contact_relationship"],
//         addressInUae: json["address_in_uae"],
//         nationality: json["nationality"],
//         medicalConditions: json["medical_conditions"],
//         maritalStatus: json["marital_status"],
//         visaType: json["visa_type"],
//         educationDetails: json["education_details"],
//         createdBy: json["created_by"],
//         createdAt: DateTime.parse(json["created_at"]),
//         pivot: Pivot.fromJson(json["pivot"]),
//         metaData: MetaData.fromJson(json["meta_data"]),*/
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "designation_id": designationId,
//         "full_name": fullName,
//         "first_name": firstName,
//         "last_name": lastName,
//         "email": email,
//         "user_profile": userProfile,
//         /* "dob": dob,
//         "phone": phone,
//         "reporting_person": reportingPerson,
//         "at_contact": atContact,
//         "address": address,
//         "old_password": oldPassword,
//         "device_token": deviceToken,
//         "user_profile": userProfile,
//         "device_id": deviceId,
//         "is_excluded": isExcluded,
//         "permission_menu": permissionMenu,
//         "data_of_joining": dataOfJoining,
//         "blood_group": bloodGroup,
//         "emergency_contact_number": emergencyContactNumber,
//         "emergency_contact_name": emergencyContactName,
//         "emergency_contact_relationship": emergencyContactRelationship,
//         "address_in_uae": addressInUae,
//         "nationality": nationality,
//         "medical_conditions": medicalConditions,
//         "marital_status": maritalStatus,
//         "visa_type": visaType,
//         "education_details": educationDetails,
//         "created_by": createdBy,
//         "created_at": createdAt.toIso8601String(),
//         "pivot": pivot.toJson(),
//         "meta_data": metaData.toJson(),*/
//       };
// }
//
// class MetaData {
//   MetaData({
//     required this.indianNumber,
//     required this.personalEmail,
//     required this.emergencyNumber,
//     required this.passportNumber,
//     required this.passportExpiryDate,
//     required this.visaNumber,
//     required this.visaExpiryDate,
//     required this.bankName,
//     required this.bankIfsc,
//     required this.accountNumber,
//     required this.dob,
//     required this.bloodGroup,
//     required this.dataOfJoining,
//     required this.addressInUae,
//     required this.emergencyContactName,
//     required this.emergencyContactRelationship,
//     required this.nationality,
//     required this.medicalConditions,
//     required this.maritalStatus,
//     required this.visaType,
//     required this.educationDetails,
//   });
//
//   String indianNumber;
//   dynamic personalEmail;
//   dynamic emergencyNumber;
//   dynamic passportNumber;
//   dynamic passportExpiryDate;
//   dynamic visaNumber;
//   dynamic visaExpiryDate;
//   dynamic bankName;
//   dynamic bankIfsc;
//   dynamic accountNumber;
//   dynamic dob;
//   dynamic bloodGroup;
//   dynamic dataOfJoining;
//   dynamic addressInUae;
//   dynamic emergencyContactName;
//   String emergencyContactRelationship;
//   dynamic nationality;
//   dynamic medicalConditions;
//   String maritalStatus;
//   dynamic visaType;
//   String educationDetails;
//
//   factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
//         indianNumber: json["indian_number"],
//         personalEmail: json["personal_email"],
//         emergencyNumber: json["emergency_number"],
//         passportNumber: json["passport_number"],
//         passportExpiryDate: json["passport_expiry_date"],
//         visaNumber: json["visa_number"],
//         visaExpiryDate: json["visa_expiry_date"],
//         bankName: json["bank_name"],
//         bankIfsc: json["bank_ifsc"],
//         accountNumber: json["account_number"],
//         dob: json["dob"],
//         bloodGroup: json["blood_group "],
//         dataOfJoining: json["data_of_joining "],
//         addressInUae: json["address_in_uae"],
//         emergencyContactName: json["emergency_contact_name"],
//         emergencyContactRelationship: json["emergency_contact_relationship"],
//         nationality: json["nationality"],
//         medicalConditions: json["medical_conditions"],
//         maritalStatus: json["marital_status"],
//         visaType: json["visa_type"],
//         educationDetails: json["education_details"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "indian_number": indianNumber,
//         "personal_email": personalEmail,
//         "emergency_number": emergencyNumber,
//         "passport_number": passportNumber,
//         "passport_expiry_date": passportExpiryDate,
//         "visa_number": visaNumber,
//         "visa_expiry_date": visaExpiryDate,
//         "bank_name": bankName,
//         "bank_ifsc": bankIfsc,
//         "account_number": accountNumber,
//         "dob": dob,
//         "blood_group ": bloodGroup,
//         "data_of_joining ": dataOfJoining,
//         "address_in_uae": addressInUae,
//         "emergency_contact_name": emergencyContactName,
//         "emergency_contact_relationship": emergencyContactRelationship,
//         "nationality": nationality,
//         "medical_conditions": medicalConditions,
//         "marital_status": maritalStatus,
//         "visa_type": visaType,
//         "education_details": educationDetails,
//       };
// }
//
class NewComment {
  NewComment({
    required this.id,
    required this.leadId,
    required this.agentId,
    required this.date,
    required this.time,
    required this.newComments,
    required this.createdAt,
    required this.updatedAt,
  });

  int? id;
  int? leadId;
  int? agentId;
  DateTime date;
  String? time;
  String? newComments;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory NewComment.fromJson(Map<String, dynamic> json) => NewComment(
        id: json["id"],
        leadId: json["lead_id"],
        agentId: json["agent_id"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
        newComments: json["new_comments"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lead_id": leadId,
        "agent_id": agentId,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "time": time,
        "new_comments": newComments,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

// class Note {
//   Note({
//     required this.id,
//     required this.relId,
//     required this.relType,
//     required this.description,
//     required this.dateContacted,
//     required this.addedfrom,
//     required this.dateadded,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   int id;
//   int relId;
//   String relType;
//   String description;
//   dynamic dateContacted;
//   int addedfrom;
//   DateTime dateadded;
//   DateTime createdAt;
//   DateTime updatedAt;
//
//   factory Note.fromJson(Map<String, dynamic> json) => Note(
//         id: json["id"],
//         relId: json["rel_id"],
//         relType: json["rel_type"],
//         description: json["description"],
//         dateContacted: json["date_contacted"],
//         addedfrom: json["addedfrom"],
//         dateadded: DateTime.parse(json["dateadded"]),
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "rel_id": relId,
//         "rel_type": relType,
//         "description": description,
//         "date_contacted": dateContacted,
//         "addedfrom": addedfrom,
//         "dateadded": dateadded.toIso8601String(),
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//       };
// }
//
// class Pivot {
//   Pivot({
//     required this.leadId,
//     required this.userId,
//   });
//
//   int leadId;
//   int userId;
//
//   factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
//         leadId: json["lead_id"],
//         userId: json["user_id"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "lead_id": leadId,
//         "user_id": userId,
//       };
// }
//
// class Developer {
//   Developer({
//     required this.id,
//     required this.name,
//     required this.phone,
//     required this.address,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   int id;
//   String name;
//   String phone;
//   String address;
//   DateTime createdAt;
//   DateTime updatedAt;
//
//   factory Developer.fromJson(Map<String, dynamic> json) => Developer(
//         id: json["id"],
//         name: json["name"],
//         phone: json["phone"],
//         address: json["address"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "phone": phone,
//         "address": address,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//       };
// }
//
// class Property {
//   Property({
//     required this.id,
//     required this.name,
//     required this.slug,
//     required this.description,
//     required this.cityId,
//     required this.address,
//     required this.developerId,
//     required this.budget,
//     required this.image,
//     required this.featuredProperty,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.ameneties,
//   });
//
//   int id;
//   String name;
//   String slug;
//   dynamic description;
//   int cityId;
//   String address;
//   int developerId;
//   String budget;
//   String image;
//   String featuredProperty;
//   DateTime createdAt;
//   DateTime updatedAt;
//   List<dynamic> ameneties;
//
//   factory Property.fromJson(Map<String, dynamic> json) => Property(
//         id: json["id"],
//         name: json["name"],
//         slug: json["slug"],
//         description: json["description"],
//         cityId: json["city_id"],
//         address: json["address"],
//         developerId: json["developer_id"],
//         budget: json["budget"],
//         image: json["image"],
//         featuredProperty: json["featured_property"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         ameneties: List<dynamic>.from(json["ameneties"].map((x) => x)),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "slug": slug,
//         "description": description,
//         "city_id": cityId,
//         "address": address,
//         "developer_id": developerId,
//         "budget": budget,
//         "image": image,
//         "featured_property": featuredProperty,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "ameneties": List<dynamic>.from(ameneties.map((x) => x)),
//       };
// }
//
// class Sources {
//   Sources({
//     required this.id,
//     required this.name,
//     required this.status,
//     /* required this.createdAt,
//     required this.updatedAt,*/
//   });
//
//   //int? id;
//   var id;
//   //String? name;
//   var name;
//   var status;
//   /*DateTime? createdAt;
//   DateTime? updatedAt;*/
//
//   factory Sources.fromJson(Map<String, dynamic> json) => Sources(
//         id: json["id"],
//         name: json["name"],
//         status: json["status"],
//         /*createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),*/
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "status": status,
//         /*"created_at": createdAt!.toIso8601String(),
//         "updated_at": updatedAt!.toIso8601String(),*/
//       };
// }
//
// class Statuses {
//   Statuses({
//     required this.id,
//     required this.name,
//     //   required this.statusorder,
//     required this.color,
//     required this.isdefault,
//     //required this.createdAt,
//     //required this.updatedAt,
//   });
//
//   int id;
//   String name;
//
//   // int statusorder;
//   String color;
//   int isdefault;
//   //DateTime createdAt;
//   //DateTime updatedAt;
//
//   factory Statuses.fromJson(Map<String, dynamic> json) => Statuses(
//         id: json["id"],
//         name: json["name"],
//         //   statusorder: json["statusorder"] == null ? null : json["statusorder"],
//         color: json["color"],
//         isdefault: json["isdefault"],
//         //createdAt: DateTime.parse(json["created_at"]),
//         //updatedAt: DateTime.parse(json["updated_at"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         //  "statusorder": statusorder == null ? null : statusorder,
//         "color": color,
//         "isdefault": isdefault,
//         //"created_at": createdAt.toIso8601String(),
//         //"updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
//       };
// }

class LeadsByDate {
  LeadsByDate({
    this.date,
    this.leads,
  });

  String? date;
  List<Lead>? leads;
}
