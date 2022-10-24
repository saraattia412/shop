class AddressModel {
  bool? status;
  String? message;
  Data? data;

  AddressModel({this.status, this.message, this.data});

  AddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? name;
  String? city;
  String? region;
  String? details;
  dynamic latitude;
  dynamic longitude;
  String? notes;
  int? id;

  Data(
      {this.name,
        this.city,
        this.region,
        this.details,
        this.latitude,
        this.longitude,
        this.notes,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    city = json['city'];
    region = json['region'];
    details = json['details'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    notes = json['notes'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['city'] = this.city;
    data['region'] = this.region;
    data['details'] = this.details;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['notes'] = this.notes;
    data['id'] = this.id;
    return data;
  }
}