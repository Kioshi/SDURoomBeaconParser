import 'dart:convert';
import 'dart:async';
import 'dart:io';

main() async {
  var beacons = json.decode(File('beacons.json').readAsStringSync())['beacons'];
  var maps = json.decode(File('maps.json.txt').readAsStringSync());
  RegExp regExp = RegExp(r"^U1[6-8][0-9]$");
  for (var point in maps)
  {
    if (point["properties"]["building"] != "44" || !regExp.hasMatch(point["properties"]["name"]))
    {
      continue;
    }

    String name = point["properties"]["name"] as String;
    String alias = point["properties"]["aliases"][0] as String;
    double lat = point["geometry"]["coordinates"][1] as double;
    double long = point["geometry"]["coordinates"][0] as double;

    for (var beacon in beacons)
    {
      if (alias.substring(1) == (beacon["room"] as String).substring(1)) {
        String room = beacon["room"] as String;
        String minor = beacon["minor"] as String;
        String major = beacon["major"] as String;
        String balias = beacon["alias"] as String;

        print('BeaconInfo("$minor","$major",$lat, $long, "$balias", "$name - $room"),');
      }
    }
  }
 //
}