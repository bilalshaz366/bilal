// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<ServicesModel> welcomeFromJson(String str) => List<ServicesModel>.from(json.decode(str).map((x) => ServicesModel.fromJson(x)));

String welcomeToJson(List<ServicesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ServicesModel {
    ServicesModel({
        this.reviews,
        this.id,
        this.name,
        this.description,
        this.responsetime,
        this.availability,
        this.zipcode,
        this.amount,
        this.location,
        this.servicetype,
        this.v,
    });

    List<String> reviews;
    String id;
    String name;
    String description;
    String responsetime;
    String availability;
    int zipcode;
    String amount;
    String location;
    String servicetype;
    int v;

    factory ServicesModel.fromJson(Map<String, dynamic> json) => ServicesModel(
        reviews: List<String>.from(json["reviews"].map((x) => x)),
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        responsetime: json["responsetime"],
        availability: json["availability"],
        zipcode: json["zipcode"],
        amount: json["amount"],
        location: json["location"],
        servicetype: json["servicetype"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "reviews": List<dynamic>.from(reviews.map((x) => x)),
        "_id": id,
        "name": name,
        "description": description,
        "responsetime": responsetime,
        "availability": availability,
        "zipcode": zipcode,
        "amount": amount,
        "location": location,
        "servicetype": servicetype,
        "__v": v,
    };
}
