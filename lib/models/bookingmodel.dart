// To parse this JSON data, do
//
//     final BookingModel = BookingModelFromJson(jsonString);

import 'dart:convert';

List<BookingModel> bookingModelFromJson(String str) => List<BookingModel>.from(
    json.decode(str).map((x) => BookingModel.fromJson(x)));

String bookingModelToJson(List<BookingModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookingModel {
  BookingModel({
    this.id,
    this.serviceproviderid,
    this.tasklat,
    this.tasklng,
    this.dropoffdate,
    this.dropofftimefrom,
    this.dropofftimeto,
    this.pickupdate,
    this.pickuptimefrom,
    this.pickuptimeto,
    this.usercontactno,
    this.username,
    this.userid,
    this.v,
    this.status,
    this.dogname,
    this.dogbreed,
    this.doglocation,
    this.pettype,
  });

  String id;
  String serviceproviderid;
  double tasklat;
  double tasklng;
  DateTime dropoffdate;
  String dropofftimefrom;
  String dropofftimeto;
  DateTime pickupdate;
  String pickuptimefrom;
  String pickuptimeto;
  String usercontactno;
  String username;
  String userid;
  int v;
  String status;
  String dogname;
  String dogbreed;
  String doglocation;
  String pettype;

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
        id: json["_id"],
        serviceproviderid: json["serviceproviderid"],
        tasklat: json["tasklat"].toDouble(),
        tasklng: json["tasklng"].toDouble(),
        dropoffdate: DateTime.parse(json["dropoffdate"]),
        dropofftimefrom: json["dropofftimefrom"],
        dropofftimeto: json["dropofftimeto"],
        pickupdate: DateTime.parse(json["pickupdate"]),
        pickuptimefrom: json["pickuptimefrom"],
        pickuptimeto: json["pickuptimeto"],
        usercontactno: json["usercontactno"],
        username: json["username"],
        userid: json["userid"],
        v: json["__v"],
        status: json["status"] == null ? null : json["status"],
        dogname: json["dogname"] == null ? null : json["dogname"],
        dogbreed: json["dogbreed"] == null ? null : json["dogbreed"],
        doglocation: json["doglocation"] == null ? null : json["doglocation"],
        pettype: json["pettype"] == null ? null : json["pettype"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "serviceproviderid": serviceproviderid,
        "tasklat": tasklat,
        "tasklng": tasklng,
        "dropoffdate":
            "${dropoffdate.year.toString().padLeft(4, '0')}-${dropoffdate.month.toString().padLeft(2, '0')}-${dropoffdate.day.toString().padLeft(2, '0')}",
        "dropofftimefrom": dropofftimefrom,
        "dropofftimeto": dropofftimeto,
        "pickupdate":
            "${pickupdate.year.toString().padLeft(4, '0')}-${pickupdate.month.toString().padLeft(2, '0')}-${pickupdate.day.toString().padLeft(2, '0')}",
        "pickuptimefrom": pickuptimefrom,
        "pickuptimeto": pickuptimeto,
        "usercontactno": usercontactno,
        "username": username,
        "userid": userid,
        "__v": v,
        "status": status == null ? null : status,
        "dogname": dogname == null ? null : dogname,
        "dogbreed": dogbreed == null ? null : dogbreed,
        "doglocation": doglocation == null ? null : doglocation,
        "pettype": pettype == null ? null : pettype,
      };
}
