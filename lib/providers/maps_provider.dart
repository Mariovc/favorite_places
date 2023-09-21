import 'dart:convert';

import 'package:favorite_places/model/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final googleApiKey =
    Provider((ref) => 'AIzaSyDFciAguwmCd0kBexznM_fGDga_2qEJCxo');

final loadImage = ProviderFamily<String, PlaceCoordinates>((ref, coordinates) {
  final apiKey = ref.read(googleApiKey);
  final lat = coordinates.latitude;
  final lng = coordinates.longitude;
  return 'https://maps.googleapis.com/maps/api/staticmap?latlng=$lat,$lng&zoom=13&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C$lat,$lng&key=$apiKey';
});

final resolveAddress =
    ProviderFamily<Future<String>, PlaceCoordinates>((ref, coordinates) async {
  final apiKey = ref.read(googleApiKey);
  final latitude = coordinates.latitude;
  final longitude = coordinates.longitude;
  final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey');
  final response = await http.get(url);
  final responseData = json.decode(response.body);
  return responseData['results'][0]['formatted_address'];
});
