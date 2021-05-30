import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Controller {
  TextEditingController _name = new TextEditingController();

  TextEditingController _email = new TextEditingController();

  TextEditingController _password = new TextEditingController();

  bool isLoading = false;
  dynamic apiurl = "http://192.168.1.180:8080";
  Future<dynamic> save({dynamic email, dynamic password}) async {
    print("$apiurl/signupwithbycript");

    var res = await http.post(Uri.parse("$apiurl/signupwithbycript"),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          'email': email,
          'password': password,
          'usertype': 'merchant'
        });

    if (res.statusCode == 200) {
      final data = await json.decode(res.body);
      print(data);

      return data;
    } else {
      return "error";
    }
  }

  Future<dynamic> saveuserinformation(
      {firstname, lastname, contactno, email, id, imgurl}) async {
    print("im here");

    var res = await http
        .post(Uri.parse("$apiurl/addmerchant"), headers: <String, String>{
      'Context-Type': 'application/json;charSet=UTF-8'
    }, body: <String, String>{
      "firstname": firstname,
      "lastname": lastname,
      "contactno": contactno,
      "email": email,
      "userid": id,
      "imgurl": imgurl
    });

    if (res.statusCode == 200) {
      final data = await json.decode(res.body);
      print(data);

      return data;
    } else {
      return "error";
    }
  }

  Future<dynamic> getuserinformation({dynamic id}) async {
    print("im getmerchant");

    var res = await http.get(
      Uri.parse("$apiurl/getmerchant/$id"),
      headers: <String, String>{
        'Context-Type': 'application/json;charSet=UTF-8'
      },
    );

    if (res.statusCode == 200) {
      final data = await json.decode(res.body);
      print(data);

      return data;
    } else {
      return "error";
    }
  }

  Future<dynamic> getbookings({dynamic id}) async {
    print("im getbookings");

    var res = await http.get(
      Uri.parse("$apiurl/getbookingsmerchant/$id"),
      headers: <String, String>{
        'Context-Type': 'application/json;charSet=UTF-8'
      },
    );

    if (res.statusCode == 200) {
      final data = await json.decode(res.body);
      print(data);

      return data;
    } else {
      return "error";
    }
  }

  Future<dynamic> updatestatus({dynamic id, status}) async {
    print("im updatestatus");
    print("$apiurl/updatestatus/$id");

    var res = await http
        .post(Uri.parse("$apiurl/updatestatus/$id"), headers: <String, String>{
      'Context-Type': 'application/json;charSet=UTF-8'
    }, body: <String, String>{
      "status": status,
    });

    if (res.statusCode == 200) {
      final data = await json.decode(res.body);
      print(data);

      return data;
    } else {
      return "error";
    }
  }

  Future<dynamic> deleteservice({dynamic id}) async {
    print("im getmerchant");
    print("$apiurl/deleteservice/$id");

    var res = await http.delete(
      Uri.parse("$apiurl/deleteservice/$id"),
      headers: <String, String>{
        'Context-Type': 'application/json;charSet=UTF-8'
      },
    );

    if (res.statusCode == 200) {
      final data = await json.decode(res.body);
      print(data);

      return data;
    } else {
      return "error";
    }
  }

  Future<dynamic> addservices(
      {name,
      description,
      responsetime = "1 Hour",
      services,
      availability = "Yes",
      reviews = "No reviews yet",
      amount,
      location,
      city,
      id,
      servicetype,
      contactno,
      imgurl,
      email}) async {
    print("im here");

    var data = <String, String>{
      "name": "$name",
      "description": description,
      "responsetime": responsetime,
      "services": services,
      "availability": availability,
      "reviews": reviews,
      "city": city,
      "id": id,
      "amount": amount,
      "location": location,
      "servicetype": servicetype,
      "contactno": contactno,
      "email": email,
      "imgurl": imgurl,
    };

    print(data);

    var res = await http.post(Uri.parse("$apiurl/addserviceprovider"),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: data);

    if (res.statusCode == 200) {
      final data = await json.decode(res.body);
      print(data);

      return data;
    } else {
      return "error";
    }
  }

  Future<dynamic> editservices(
      {name,
      description,
      responsetime = "1 Hour",
      services,
      availability = "Yes",
      reviews = "No reviews yet",
      amount,
      location,
      zipcode,
      id,
      servicetype,
      contactno,
      imgurl,
      email}) async {
    print("im here");

    var data = <String, String>{
      "name": "$name",
      "description": description,
      "responsetime": responsetime,
      "services": services,
      "availability": availability,
      "reviews": reviews,
      "zipcode": zipcode,
      "id": id,
      "amount": amount,
      "location": location,
      "servicetype": servicetype,
      "contactno": contactno,
      "email": email,
      "imgurl": imgurl,
    };

    print(data);

    var res = await http.post(Uri.parse("$apiurl/editservice/$id"),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: data);

    if (res.statusCode == 200) {
      final data = await json.decode(res.body);
      print(data);

      return data;
    } else {
      return "error";
    }
  }

  Future<dynamic> signin(email, password) async {
    try {
      print("$apiurl/login2");
      var res = await http.post(Uri.parse("$apiurl/login2"),
          headers: <String, String>{
            'Context-Type': 'application/json;charSet=UTF-8'
          },
          body: <String, String>{
            'email': email,
            'password': password
          });

      if (res.statusCode == 200) {
        final data = await json.decode(res.body);
        print(data);
        return data;
      } else {
        print("error occur");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> updatepetinfo(
      {pettype,
      petname,
      petbreed,
      petdescription,
      date,
      petimage,
      weight,
      likestodo,
      likestoeat,
      anycomment,
      id}) async {
    print("im here");

    var res = await http.post(Uri.parse("$apiurl/updatepetinfos/$id"),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          "petimgurl": petimage == null ? "" : petimage,
          "pettype": pettype,
          "petname": petname,
          "petbreed": petbreed,
          "petdescription": petdescription,
          //   "petdate": date,
          "petweight": weight,
          "petlikestodo": likestodo,
          "petlikestoeat": likestoeat,
          "petanycomment": anycomment,
        });

    if (res.statusCode == 200) {
      final data = await json.decode(res.body);
      print(data);

      return data;
    } else {
      return "error";
    }
  }

  Future<dynamic> submitbooking({
    serviceproviderid,
    tasklat,
    tasklng,
    dropoffdate,
    dropofftimefrom,
    dropofftimeto,
    pickupdate,
    pickuptimefrom,
    pickuptimeto,
    usercontactno,
    username,
    userid,
  }) async {
    print("$apiurl/addbooking");

    var res = await http
        .post(Uri.parse("$apiurl/addbooking"), headers: <String, String>{
      'Context-Type': 'application/json;charSet=UTF-8'
    }, body: <String, String>{
      "serviceproviderid": serviceproviderid,
      "tasklat": tasklat,
      "tasklng": tasklng,
      "dropoffdate": dropoffdate,
      "dropofftimefrom": dropofftimefrom,
      //   "petdate": date,
      "dropofftimeto": dropofftimeto,
      "pickupdate": pickupdate,
      "pickuptimefrom": pickuptimefrom,
      "pickuptimeto": pickuptimeto,
      "usercontactno": usercontactno,
      "username": username,
      "userid": userid,
    });

    if (res.statusCode == 200) {
      final data = await json.decode(res.body);
      print(data);

      return data;
    } else {
      return "error";
    }
  }

  Future<dynamic> updateownertinfo(
      {ownername, ownercont, ownerdec, ownerdob, ownerpic, id}) async {
    print("im here");

    var res = await http.post(Uri.parse("$apiurl/updateownerinfos/$id"),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          "ownername": ownername,
          "ownercontact": ownercont,
          "ownerdescription": ownerdec,
          "ownerimageurl": ownerpic == null ? "asdfasdf" : ownerpic,
          "ownerdob": "$ownerdob",
        });

    if (res.statusCode == 200) {
      final data = await json.decode(res.body);
      print(data);

      return data;
    } else {
      return "error";
    }
  }

  Future<dynamic> getserviceproviderlist({id}) async {
    try {
      print("im in getserviceproviderlist");
      print("$apiurl/getservicelistbyid/$id");
      var res = await http.get(Uri.parse("$apiurl/getservicelistbyid/$id"),
          headers: <String, String>{
            'Context-Type': 'application/json;charSet=UTF-8'
          });

      if (res.statusCode == 200) {
        final data = await json.decode(res.body);
        print(data);

        return data;
      } else {
        return "error";
      }
    } catch (e) {
      print(e);
    }
  }
}
