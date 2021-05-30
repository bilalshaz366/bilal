import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:petmerchantapp/controllers/controller.dart';

import 'package:petmerchantapp/languages/global.dart';
import 'package:petmerchantapp/utils/customcontainers.dart';
import 'package:petmerchantapp/utils/errorutils.dart';
import 'package:petmerchantapp/utils/prefmanager.dart';
import 'package:petmerchantapp/view/RegisterationPages/registerpage.dart';
import 'package:petmerchantapp/view/Services.dart';

import 'Home.dart';

class EditServices extends StatefulWidget {
  dynamic servicelist;
  EditServices({
    this.servicelist,
  });
  @override
  _EditServicesState createState() => _EditServicesState();
}

class _EditServicesState extends State<EditServices> {
  bool _validateemail = false;

  bool _validatepass = false;

  bool _validateconfpass = false;

  TextEditingController _serviceController;

  TextEditingController _priceController;

  TextEditingController _descriptionController;

  TextEditingController _zipController;
  TextEditingController _locationController;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Map userDatas;

  getuserData() async {
    userDatas = json.decode(await _prefManager.get("userdata", "{}"));

    print(userDatas);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserData();
    _serviceController = new TextEditingController(text: "");
    _priceController =
        new TextEditingController(text: "${widget.servicelist['amount']}");

    _descriptionController =
        new TextEditingController(text: "${widget.servicelist['description']}");

    _zipController =
        new TextEditingController(text: "${widget.servicelist['zipcode']}");

    _locationController =
        new TextEditingController(text: "${widget.servicelist['location']}");
    servicetype = widget.servicelist['servicetype'];
  }

  dynamic servicetype;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color(0xff293146),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color(0xff293146),
          actions: [
            Text(
              'English',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              width: 30,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 28.0),
                  child: Text(
                    'Edit Service',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                      left: 28.0,
                      top: 10,
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Service type', style: styling()),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 340,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(143, 148, 251, .2),
                                      blurRadius: 20.0,
                                      offset: Offset(0, 10))
                                ]),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                  items: <String>[
                                    'Boarding',
                                    'Daycare',
                                    'Other',
                                  ].map((String value) {
                                    return new DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          '$value',
                                        ));
                                  }).toList(),
                                  onChanged: (newVal) {
                                    setState(() {
                                      servicetype = newVal;
                                    });
                                  },
                                  value: servicetype),
                            ),
                          )
                        ])),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Name of Service',
                          style: TextStyle(
                            //fontSize: 30,
                            color: Colors.white,
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      fadeanimation(
                        _serviceController,
                        'daycare',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Price/Hour',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      fadeanimation(
                        _priceController,
                        "25",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Description',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      fadeanimation(
                        _descriptionController,
                        "i will provide this service etc",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Zip Code',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      fadeanimation(
                        _zipController,
                        "Enter your zip code",
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text('Enter your location',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      fadeanimation(
                        _locationController,
                        "Enter your Location",
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: InkWell(
                        onTap: () {
                          handleService();
                        },
                        child: buttons('Submit')),
                  ),
                ),
                SizedBox(
                  height: 215,
                ),
              ]),
        ));
  }

  String action;

  final _prefManager = PrefManager();

  //final _repository = Repository();

  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  final passwordFocusNode = new FocusNode();

  Future<String> handleService() async {
    String service = _serviceController.text.trim();
    String price = _priceController.text.trim();
    String description = _descriptionController.text.trim();

    String zipcode = _zipController.text.trim();

    String location = _locationController.text.trim();
    if (verify()) {
      //showLoadingDialog(context, "Plz wait...");
      await Controller()
          .editservices(
              services: service,
              amount: price,
              name: userDatas["firstname"],
              description: description,
              zipcode: zipcode,
              location: location,
              id: userDatas["id"],
              imgurl: userDatas['imgurl'] == null ? "" : userDatas['imgurl'],
              email: userDatas['email'],
              contactno: userDatas['contactno'],
              servicetype: servicetype)
          .then((value) => {
                if (value != "error")
                  {
                    print("the value is $value"),
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.SUCCES,
                      animType: AnimType.RIGHSLIDE,
                      headerAnimationLoop: false,
                      title: 'Congratulation',
                      desc: 'You have successfully Edit a Service',
                      btnOkOnPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyServices()));
                      },
                    )..show()
                  }
                else
                  {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.ERROR,
                      animType: AnimType.RIGHSLIDE,
                      headerAnimationLoop: false,
                      title: 'Error',
                    )..show(),
                    print(value)
                  }
                // Navigator.push(
                //     context, MaterialPageRoute(builder: (context) => Home())),
              });
    }
    return "Success";
  }

  bool verify() {
    String service = _serviceController.text;
    String price = _priceController.text;
    String description = _descriptionController.text;

    String zipcode = _zipController.text;

    String location = _locationController.text;
    if (service.isEmpty) {
      showMessage("Please enter your service");
      return false;
    }
    if (price.isEmpty) {
      showMessage("price can't be empty");
      return false;
    }
    if (description.isEmpty) {
      showMessage("description can't be empty");
      return false;
    }
    if (zipcode.isEmpty) {
      showMessage("zipcode can't be empty");
      return false;
    }
    if (location.isEmpty) {
      showMessage("location can't be empty");
      return false;
    }

    return true;
  }

  showMessage(String message, [color]) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: color ?? Colors.orange,
    ));
  }
}
