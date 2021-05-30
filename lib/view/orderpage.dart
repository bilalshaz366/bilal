import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:petmerchantapp/controllers/controller.dart';
import 'package:petmerchantapp/utils/customcontainers.dart';
import 'package:petmerchantapp/view/Dashboard.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderPage extends StatefulWidget {
  dynamic data;
  OrderPage({this.data});
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  Future<void> _launched;

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: Text(
          'Order Page',
          style: TextStyle(color: Colors.blue[900]),
        ),
        centerTitle: true,
      ),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        progressIndicator: CircularProgressIndicator(),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
            height: 450,
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
                          'Reservation',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Rate:25/hour',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Owner Name :  ${widget.data['username']}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Dog :  ${widget.data['dogname']}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Breed: ${widget.data['dogbreed']}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Location: ${widget.data['doglocation']}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Hours: ${widget.data['dropofftimefrom'] + widget.data['dropofftimeto']}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                                onTap: () {
                                  widget.data['status'] == "unassigned"
                                      ? changestatus(
                                          widget.data['_id'], 'accepted')
                                      : print("");
                                },
                                child: widget.data['status'] == "unassigned"
                                    ? buttons('Confirm')
                                    : widget.data['status'] == "rejected"
                                        ? Container()
                                        : InkWell(
                                            onTap: () {
                                              setState(() {
                                                _launched = _makePhoneCall(
                                                    'tel:${widget.data['usercontactno']}');
                                              });
                                            },
                                            child: buttons(
                                                'Contact ${widget.data['usercontactno']}'),
                                          )),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                widget.data['status'] == "unassigned"
                                    ? changestatus(
                                        widget.data['_id'], 'rejected')
                                    : print("");
                              },
                              child: widget.data['status'] == "unassigned"
                                  ? buttons('Cancel', color: 0xffDC143C)
                                  : widget.data['status'] == "rejected"
                                      ? Container()
                                      : InkWell(
                                          onTap: () {
                                            MapUtils.openMap(
                                                widget.data['tasklat'],
                                                widget.data['tasklng']);
                                          },
                                          child: buttons('Go to Pickup',
                                              color: 0xffee9a00)),
                            ),
                          ]),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isLoading = false;
  changestatus(id, status) async {
    try {
      setState(() {
        isLoading = true;
      });
      await Controller()
          .updatestatus(id: widget.data['_id'], status: "$status")
          .then((value) {
        setState(() {
          isLoading = false;
        });
        if (value != "error") {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.SUCCES,
            animType: AnimType.RIGHSLIDE,
            headerAnimationLoop: false,
            title: 'Congratulation',
            desc: 'You have successfully Accepted order',
            btnOkOnPress: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Dashboard()));
            },
          )..show();
        }
      });
    } catch (e) {
      print(e);
    }
  }
}

class MapUtils {
  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
