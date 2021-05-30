import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:convert';
import 'package:petmerchantapp/languages/global.dart';
import 'package:petmerchantapp/utils/customcontainers.dart';
import 'package:petmerchantapp/utils/prefmanager.dart';
import 'package:petmerchantapp/controllers/controller.dart';
import 'package:path/path.dart' as Path;
import 'package:image_picker/image_picker.dart';

class EditOwnerPage extends StatefulWidget {
  @override
  _EditOwnerPageState createState() => _EditOwnerPageState();
}

class _EditOwnerPageState extends State<EditOwnerPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController _emailController;

  TextEditingController _firstnameController;

  TextEditingController _lastnameController;

  TextEditingController _passwordController;

  TextEditingController _phoneController;

  dynamic phoneNumber;

  Map userDatas;
  final _prefManager = PrefManager();

  getuserData() async {
    setState(() {
      isLoading = true;
    });
    userDatas = json.decode(await _prefManager.get("userdata", "{}"));
    setState(() {
      isLoading = false;
    });
    _emailController = new TextEditingController(text: userDatas['email']);
    _firstnameController =
        new TextEditingController(text: userDatas['firstname']);

    _lastnameController =
        new TextEditingController(text: userDatas['lastname']);

    phoneNumber = userDatas['contactno'];

    _ownerprofileURL = userDatas['imgurl'];

    print(userDatas);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserData();
  }

  bool isLoading = false;

  String _ownerprofileURL;
  String _uploadedFileURL;
  final picker = ImagePicker();
  File _image;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    FirebaseStorage storage = FirebaseStorage.instance;

    Reference ref =
        storage.ref().child('profilepics/${Path.basename(_image.path)}}');
    UploadTask uploadTask = ref.putFile(_image);
    uploadTask.whenComplete(() {
      ref.getDownloadURL().then((value) {
        setState(() {
          _ownerprofileURL = value;
          print(_ownerprofileURL);
        });
      });
    }).catchError((onError) {
      print(onError);
    });
    return _ownerprofileURL;
  }

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
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
              width: 30,
            ),
          ],
        ),
        body: ModalProgressHUD(
          inAsyncCall: isLoading,
          // demo of some additional parameters
          opacity: 0.5,
          progressIndicator: CircularProgressIndicator(),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      'Edit Account',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            getImage();
                          },
                          child: Center(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Container(
                                    height: 200,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: _ownerprofileURL != null
                                        ? Image.network(_ownerprofileURL,
                                            fit: BoxFit.cover)
                                        : Image.network(
                                            'https://www.pngitem.com/pimgs/m/504-5040528_empty-profile-picture-png-transparent-png.png',
                                            fit: BoxFit.cover),
                                  ),
                                )),
                          ),
                        ),
                        Text('First Name', style: styling()),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: fadeanimation(
                            _firstnameController,
                            'John',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text('Last Name', style: styling()),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: fadeanimation(
                            _lastnameController,
                            'Doe',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text('Contact Number', style: styling()),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: fadeanimation1()),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text('Email', style: styling()),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        fadeanimation(
                          _emailController,
                          'example@gmail.com',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      _performRegisteration();
                    },
                    child: buttons('Edit Account'),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('$haveanaccount ? ', style: styling()),
                      InkWell(
                        onTap: () {},
                        child: Text('$login1',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ]),
          ),
        ));
  }

  Widget fadeanimation1() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(143, 148, 251, .2),
                blurRadius: 20.0,
                offset: Offset(0, 10))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 0.0),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[100]))),
            child: IntlPhoneField(
              decoration: InputDecoration(),
              initialCountryCode: 'PK',
              onChanged: (phone) {
                setState(() {
                  phoneNumber = "${phone.completeNumber}";
                });
                print(phone.completeNumber);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _performRegisteration() async {
    String firstname = _firstnameController.text.trim();
    String lastname = _lastnameController.text.trim();
    String phoneno = _phoneController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    //String countrycodes = countryCode;

    if (firstname == "") {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: false,
        title: 'Oh',
        desc: 'Please Enter FirstName',
        btnCancelOnPress: () {},
        btnOkOnPress: () {},
      )..show();
    } else {
      if (lastname == "") {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.RIGHSLIDE,
          headerAnimationLoop: false,
          title: 'Oh',
          desc: 'Please Enter Lastname',
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
        )..show();
      } else {
        if (phoneno == "1") {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.RIGHSLIDE,
            headerAnimationLoop: false,
            title: 'Oh',
            desc: 'Please Enter phone number',
            btnCancelOnPress: () {},
            btnOkOnPress: () {},
          )..show();
        } else {
          if (email == "") {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.ERROR,
              animType: AnimType.RIGHSLIDE,
              headerAnimationLoop: false,
              title: 'Oh',
              desc: 'Please Enter email',
              btnCancelOnPress: () {},
              btnOkOnPress: () {},
            )..show();
          } else {
            setState(() {
              // isLoading = true;
            });

            try {
              Controller()
                  .save(email: email, password: password)
                  .then((value) async {
                print("the value is $value");

                if (value != null) {
                  Controller()
                      .saveuserinformation(
                    firstname: _firstnameController.text,
                    lastname: _lastnameController.text,
                    contactno: "$phoneNumber",
                    email: email,
                    id: value['_id'].toString(),
                    imgurl: _uploadedFileURL.toString(),
                  )
                      .then((value) {
                    print(value);
                    PrefManager().set(
                        "user.data",
                        json.encode({
                          //   "user_id": value['_id'].toString(),
                          "f_name": _firstnameController.text,
                          "l_name": _lastnameController.text,
                          "number": "$phoneNumber",
                          "email": _emailController.text,
                          "imgurl": _uploadedFileURL,
                        }));
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.SUCCES,
                      animType: AnimType.RIGHSLIDE,
                      headerAnimationLoop: false,
                      title: 'Congratulation',
                      desc: 'You have successfully Registered',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {},
                    )..show();
                  });
                } else {
                  dialogbox(
                    context,
                    "Sorry",
                    "Check your credentials Either Email is already used or password is less than 6 character",
                  );
                  setState(() {
                    isLoading = false;
                  });
                }

                print("im here");
              });
            } catch (e) {
              print("im in this $e");
              setState(() {
                isLoading = false;
              });
            }
          }
          //  Navigator.of(context).pop();

        }
      }
    }
  }
}

TextStyle styling() {
  return TextStyle(
    color: Colors.white,
  );
}

Widget dialogbox(context, title, desc) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.ERROR,
    animType: AnimType.RIGHSLIDE,
    headerAnimationLoop: false,
    title: '$title',
    desc: '$desc',
  )..show();
}
