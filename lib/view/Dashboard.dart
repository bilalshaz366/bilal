import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:petmerchantapp/controllers/controller.dart';
import 'package:petmerchantapp/models/usermodel.dart';
import 'package:petmerchantapp/utils/customcontainers.dart';
import 'package:petmerchantapp/view/RegisterationPages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:petmerchantapp/models/bookingmodel.dart';
import 'package:petmerchantapp/view/orderpage.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  TextEditingController zipcode = new TextEditingController();

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  dynamic data;
  dynamic userdata;
  getuserdata() async {
    SharedPreferences getinstance = await SharedPreferences.getInstance();

    var getintanc = await json.decode(getinstance.getString('userdata'));
    setState(() {
      userdata = getintanc;
      getdata();
    });
  }

  bool isLoading = false;
  UserInfo userinfo = new UserInfo();
  removelogin() async {
    SharedPreferences removelogin = await SharedPreferences.getInstance();

    await removelogin.remove('userdata');
  }

  saveownerdata(data) async {
    SharedPreferences savelogin = await SharedPreferences.getInstance();

    await savelogin.setString(
        'userdata',
        json.encode({
          "firstname": data['firstname'],
          "lastname": data['lastname'],
          "contactno": data['contactno'],
          "email": data['email'],
          "imgurl": data['imgurl'],
          "id": data['_id']
        }));
  }

  getdata() async {
    try {
      setState(() {
        isLoading = true;
      });
      Controller().getuserinformation(id: userdata["id"]).then((value) => {
            setState(() {
              data = value;
              userinfo = UserInfo.fromJson(data);
              getbooking();
              print(userinfo);
              saveownerdata(data);
              isLoading = false;
            })
          });
    } catch (e) {
      print(e);
    }
  }

  bool isLoading2 = false;
  List<BookingModel> bookinginfo;
  getbooking() async {
    try {
      setState(() {
        isLoading2 = true;
      });
      Controller().getbookings(id: userdata["id"]).then((value) => {
            setState(() {
              data = value;
              //  bookinginfo = BookingModel.fromJson(data);

              print(userinfo);
              saveownerdata(data);
              isLoading2 = false;
            })
          });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: Text(
          'Dashboard',
          style: TextStyle(color: Colors.blue[900]),
        ),
        actions: [
          InkWell(
            onTap: () {
              removelogin();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Chip(
                backgroundColor: Colors.green,
                label: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ],
        centerTitle: true,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.blue[900]),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ModalProgressHUD(
              inAsyncCall: isLoading,
              progressIndicator: CircularProgressIndicator(),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          profilecard(
                              img: userinfo.imgurl,
                              name: userinfo.firstname == null
                                  ? ""
                                  : userinfo.firstname,
                              contactno: userinfo.contactno == null
                                  ? ""
                                  : userinfo.contactno,
                              email:
                                  userinfo.email == null ? "" : userinfo.email),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget availability() {
    return ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (context, i) => InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OrderPage(data: data[i])));
              },
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  '${data == null ? "" : data[i]['username']}'),
                              Text(
                                  '${data == null ? "" : data[i]['doglocation']}'),
                              Container(
                                  height: 20,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                      child: Text(
                                    '\$25',
                                    style: TextStyle(color: Colors.white),
                                  ))),
                              Text(
                                '${data == null ? "" : data[i]['status']}',
                              ),
                            ]),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  Widget ordercon() {
    return ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (context, i) => InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OrderPage(data: data[i])));
            },
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                //height: 250,
                child: Card(
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Order',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              height: 30,
                              width: 130,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green),
                              child: Center(
                                child: Text(
                                  'Amount:25/hour',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Owner Name :  ${data == null ? "" : data[i]['username']}',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Dog location :  ${data == null ? "" : data[i]['doglocation']}',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              'Status:',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                                height: 30,
                                width: 110,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: data[i]['status'] == "accepted"
                                      ? Colors.green
                                      : data[i]['status'] == "unassigned"
                                          ? Colors.orangeAccent
                                          : Colors.red,
                                ),
                                child: Center(
                                    child: Text(
                                  '${data[i]['status']}',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ))),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }

  Widget reviewscontainer() {
    return InkWell(
      onTap: () {
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => Dashboard()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 5.0,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      Text('Reviews'),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      )
                    ]),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      CircleAvatar(
                          backgroundImage: AssetImage(
                        'assets/dogpic.jpg',
                      )),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'name',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
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
                            'i am excited to meet everyone!',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget ratings() {
    return Container(
      child: Icon(
        Icons.star,
        size: 20,
        color: Colors.orangeAccent,
      ),
    );
  }

  Widget profilecard({img, name, contactno, email}) {
    return InkWell(
      // onTap: (){

      //   Navigator.push(context, MaterialPageRoute(builder: (context)=>)
      // },
      child: Container(
          width: MediaQuery.of(context).size.width,
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
                        radius: 50,
                        backgroundImage: NetworkImage(img == null
                            ? "https://upload.wikimedia.org/wikipedia/commons/f/f0/Jaun3.jpg"
                            : img)),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '$name',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            Row(children: [ratings(), ratings()]),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '$contactno',
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            '$email',
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      earningwidgets(
                          '\$1700', 'Total Earned', Colors.blue[900]),
                      earningwidgets('200 + ', 'Total Projects', Colors.green),
                    ]),
                SizedBox(
                  height: 20,
                ),
                Text(
                  '----------New Bookings----------',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),

                isLoading2 ? CircularProgressIndicator() : ordercon(),
                //availability(),

                // reviewscontainer(),
              ],
            ),
          )),
    );
  }

  earningwidgets(txt1, txt2, color) {
    return InkWell(
      onTap: () {
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => ServicesList()));
      },
      child: Container(
        height: 100,
        width: 150,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
        //  width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$txt1',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '$txt2',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget servicesContainer() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (context, i) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(0)),
                height: 40,
                width: MediaQuery.of(context).size.width - 100,
                child: Center(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '{widget.servicelist[services][i]}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.grey),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Column(
                          children: [
                            Text(
                              '{widget.servicelist[rates]}',
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
                ),
              ),
            ));
  }
}
