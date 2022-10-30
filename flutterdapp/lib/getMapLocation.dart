import 'package:url_launcher/url_launcher.dart';

Future<void> getMapLocation(String lat_1, String lon_1) async {
  if (lat_1 == "0.00" && lon_1 == "0.00") {
    print("No data yet");
  }
  final String googleMapsUrl =
      "https://www.google.com/maps/search/?api=1&query=$lat_1,$lon_1";
  final String appleMapsUrl = "https://maps.apple.com/?q=$lat_1,$lon_1";
  if (await canLaunch(googleMapsUrl)) {
    await launch(googleMapsUrl);
  }
  if (await canLaunch(appleMapsUrl)) {
    await launch(appleMapsUrl, forceSafariVC: false);
  } else {
    throw "Couldn't launch URL";
  }
}
