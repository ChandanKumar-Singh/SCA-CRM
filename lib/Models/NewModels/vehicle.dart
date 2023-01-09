class VehicleModel {
  int? id;
  String? loanNo;
  int? appId;
  String? cmName;
  String? bkt;
  String? actualBkt;
  String? branch;
  String? stateName;
  String? tos;
  String? pos;
  String? engineNo;
  String? chassisNo;
  String? registrationNo;
  String? vehicle;
  String? createdAt;
  String? updatedAt;

  VehicleModel(
      {this.id,
      this.loanNo,
      this.appId,
      this.cmName,
      this.bkt,
      this.actualBkt,
      this.branch,
      this.stateName,
      this.tos,
      this.pos,
      this.engineNo,
      this.chassisNo,
      this.registrationNo,
      this.vehicle,
      this.createdAt,
      this.updatedAt});

  VehicleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    loanNo = json['loan_no'];
    appId = json['app_id'];
    cmName = json['cm_name'];
    bkt = json['bkt'];
    actualBkt = json['actual_bkt'];
    branch = json['branch'];
    stateName = json['state_name'];
    tos = json['tos'];
    pos = json['pos'];
    engineNo = json['engine_no'];
    chassisNo = json['chassis_no'];
    registrationNo = json['registration_no'];
    vehicle = json['vehicle'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['loan_no'] = loanNo;
    data['app_id'] = appId;
    data['cm_name'] = cmName;
    data['bkt'] = bkt;
    data['actual_bkt'] = actualBkt;
    data['branch'] = branch;
    data['state_name'] = stateName;
    data['tos'] = tos;
    data['pos'] = pos;
    data['engine_no'] = engineNo;
    data['chassis_no'] = chassisNo;
    data['registration_no'] = registrationNo;
    data['vehicle'] = vehicle;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
