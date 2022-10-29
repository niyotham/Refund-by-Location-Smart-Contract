import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutterdapp/childModel.dart';

class ChildPage extends StatefulWidget {
  const ChildPage({Key? key}) : super(key: key);
  @override
  _ChildPageState createState() => _ChildPageState();
}

class _ChildPageState extends State<ChildPage> {
  var locationMessage = "";
  String lat_1 = "0.00";
  String lon_1 = "0.00";
  String status = "not sending";
  bool isSwitched = false;
  int i = 0;
  late StreamSubscription<Position> positionStream;
  void stopUpdate() {
    positionStream.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var listModel = Provider.of<childModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee Location"),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                size: 46.0,
                color: Color.fromARGB(255, 149, 33, 243),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Get Location",
                style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text("Lask Known Location:\n" + locationMessage),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.3,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35.0),
                  color: Color.fromARGB(255, 205, 7, 255),
                ),
                child: MaterialButton(
                  onPressed: () async {
                    var position = await Geolocator().getCurrentPosition(
                        desiredAccuracy: LocationAccuracy.high);
                    var lat = position.latitude;
                    var lon = position.longitude;
                    lat_1 = lat.toString();
                    lon_1 = lon.toString();
                    print("Not Encrypted \nLatitude: $lat, Longitude: $lon");
                    setState(() {
                      locationMessage = "Latitude: $lat_1\nLongitude: $lon_1";
                    });
                  },
                  child: Text('Get Current Location',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 255, 255, 255),
                      )),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                "Track Location",
                style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5.0,
              ),
              Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    if (value) {
// final LocationSettings locationSettings =
// LocationSettings(
// accuracy: LocationAccuracy.high,
// distanceFilter: 100,
// );
                      var geolocator = Geolocator();
                      var locationOptions = LocationOptions(
                        accuracy: LocationAccuracy.high,
                        distanceFilter: 100,
                      );
// ignore: unused_local_variable
                      positionStream =
                          geolocator.getPositionStream(locationOptions).listen(
                        (Position position) {
                          setState(
                            () {
                              print("Tracking On");
                              value = true;
                              isSwitched = true;
                              print(position == null
                                  ? 'Unknown'
                                  : position.latitude.toString() +
                                      ', ' +
                                      position.longitude.toString());
                              lat_1 = position.latitude.toString();
                              lon_1 = position.longitude.toString();
                              listModel.addCoordinates(
                                lat_1,
                                lon_1,
                              );
                              status = "Latitude: $lat_1\nLongitude: $lon_1";
                              locationMessage =
                                  "Latitude: $lat_1\nLongitude: $lon_1";
                            },
                          );
                        },
                      );
                    } else {
                      print("Tracking Off");
                      value = false;
                      isSwitched = false;
                      stopUpdate();
                    }
                  });
                },
                activeTrackColor: Color.fromARGB(255, 189, 7, 7),
                activeColor: Color.fromARGB(255, 226, 11, 11),
              ),
              SizedBox(
                height: 20.0,
              ),
              listModel.isLoading ? Text("No Data") : Text(status),
              SizedBox(
                height: 100.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.3,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35.0),
                  color: Color.fromARGB(255, 35, 196, 20),
                ),
                child: MaterialButton(
                  onPressed: () async {
                    final String googleMapsUrl =
                        "https://www.google.com/maps/search/?api=1&query=$lat_1,$lon_1";
                    final String appleMapsUrl =
                        "https://maps.apple.com/?q=$lat_1,$lon_1";
                    if (await canLaunch(googleMapsUrl)) {
                      await launch(googleMapsUrl);
                    }
                    if (await canLaunch(appleMapsUrl)) {
                      await launch(appleMapsUrl, forceSafariVC: false);
                    } else {
                      throw "Couldn't launch URL";
                    }
                  },
                  child: Text('View in Maps',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 255, 255, 255),
                      )),
                ),
              ),
            ]),
      ),
    );
  }
}
