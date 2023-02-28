import 'package:url_launcher/url_launcher.dart';

class MapsUtils {
  MapsUtils._();

  //latitude longitude
  static Future<void> openMapWithPosition(
      double latitude, double longitude) async {
    final Uri googleMapUrl = Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude");

    // if (await canLaunchUrl(googleMapUrl)) {
    //   await launchUrl(googleMapUrl);
    // } else {
    //   throw "Impossible d'ouvrir la carte.";
    // }

    if (!await launchUrl(googleMapUrl)) {
      throw Exception('Could not launch $googleMapUrl ');
    }
  }

  //text address
  static Future<void> openMapWithAddress(String fullAddress) async {
    final Uri googleMapUrl =
        Uri.parse("https://www.google.com/maps/search/?api=1&query");

    // if (await canLaunchUrl(googleMapUrl)) {
    //   await launchUrl(googleMapUrl);
    // } else {
    //   throw "Impossible d'ouvrir la carte.";
    // }

    if (!await launchUrl(googleMapUrl)) {
      throw Exception('Could not launch $googleMapUrl ');
    }
  }
}

// final Uri toLaunch =
//         Uri(scheme: 'https', host: 'www.cylog.org', path: 'headers/');

// Future<void> _launchUrl() async {
//   if (!await launchUrl(_url)) {
//     throw Exception('Could not launch $_url');
//   }

// final Uri _url = Uri.parse('https://flutter.dev');