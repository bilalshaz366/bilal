import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:petmerchantapp/controllers/controller.dart';
import 'dart:convert';

import 'package:petmerchantapp/utils/prefmanager.dart';
import 'package:petmerchantapp/models/servicesmodel.dart';
import 'package:petmerchantapp/view/EditService.dart';

class MyServices extends StatefulWidget {
  @override
  _MyServicesState createState() => _MyServicesState();
}

class _MyServicesState extends State<MyServices> {
  final _prefManager = PrefManager();

  Map userDatas;

  getuserData() async {
    userDatas = json.decode(await _prefManager.get("userdata", "{}"));

    print(userDatas);
    getservices();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserData();
  }

  bool isLoading = false;
  ServicesModel servicesdetails = new ServicesModel();
  List servicelist = [];
  getservices() async {
    try {
      setState(() {
        isLoading = true;
      });
      Controller().getserviceproviderlist(id: userDatas['id']).then((value) {
        setState(() {
          isLoading = false;
        });
        if (value != null) {
          servicelist = value;
          print(servicelist);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: Text(
          'Services',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.blue[900]),
        ),
        centerTitle: true,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.blue[900]),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Center(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        servicelist.isEmpty
                            ? Text('No Service Found')
                            : carditems(),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget ratings() {
    return Container(
      child: Icon(
        Icons.star,
        size: 18,
        color: Colors.orangeAccent,
      ),
    );
  }

  deleteservice() async {
    try {
      setState(() {
        isLoading = true;
      });
      Controller().deleteservice(id: userDatas['id']).then((value) {
        setState(() {
          isLoading = false;
        });
        if (value != null) {
          getservices();
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Widget carditems() {
    return ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: servicelist.length,
        itemBuilder: (context, i) => InkWell(
              onTap: () {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.SUCCES,
                  animType: AnimType.RIGHSLIDE,
                  headerAnimationLoop: false,
                  title: 'Congratulation',
                  desc: 'You have successfully Registered',
                  btnCancelText: 'Delete',
                  btnOkText: 'Edit',
                  btnCancelOnPress: () {
                    deleteservice();
                  },
                  btnOkOnPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditServices(
                                  servicelist: servicelist[i],
                                )));
                  },
                )..show();
              },
              child: Container(
                width: MediaQuery.of(context).size.width - 100,
                height: 140,
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 5.0,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              CircleAvatar(
                                  backgroundImage: NetworkImage(
                                servicelist[i]['imgurl'] == null
                                    ? 'https://img.icons8.com/officel/2x/person-male.png'
                                    : servicelist[i]['imgurl'],
                              )),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                servicelist[i]['name'],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      '\$${servicelist[i]['amount']}',
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    Text(
                                      'per night',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              //Image.asset('assets/calendaricon.png', width: 50),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: [
                                  Text(
                                    servicelist[i]['description'],
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                  Container(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      servicelist[i]['location'],
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    ),
                                  ),
                                  Row(children: [ratings(), ratings()]),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                behavior: HitTestBehavior.translucent,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
            ));
  }

  Widget servicesContainer(txt) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      height: 120,
      width: MediaQuery.of(context).size.width - 50,
      child: Card(
        elevation: 5.0,
        child: Center(
          child: Text('$txt',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.blue[900])),
        ),
      ),
    );
  }
}
