import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

class Place {
  String streetNumber;
  String street;
  String city;
  String zipCode;
  String administrativeArea;
  String subAdministrativeArea;
  String country;

  Place({
    this.streetNumber,
    this.street,
    this.city,
    this.zipCode,
  });

  @override
  String toString() {
    return 'Place(streetNumber: $streetNumber, street: $street, city: $city, zipCode: $zipCode, administrativeArea: $administrativeArea, subAdministrativeArea: $subAdministrativeArea, $country, country:)';
  }
}


class PlaceApiProvider {
  final client = Client();
  final apiKey = "AIzaSyCu21puUrpwfL_ZTInHrB-cGD0RKmg4u38";

  Future<Place> getPlaceDetailFromId(String placeId) async {
    final request = 'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=address_component&key=$apiKey';
   print('PlaceDetails$request');
    final response = await client.get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        final components =
        result['result']['address_components'] as List<dynamic>;

        // build result
        final place = Place();
        components.forEach((c) {
          final List type = c['types'];
          if (type.contains('street_number')) {
            place.streetNumber = c['long_name'];
          }
          if (type.contains('route')) {
            place.street = c['long_name'];
          }
          if (type.contains('locality')) {
            place.city = c['long_name'];
          }
          if (type.contains('postal_code')) {
            place.zipCode = c['long_name'];
          }
          if (type.contains('administrative_area_level_1')) {
            place.administrativeArea = c['long_name'];
          }
          if(type.contains('country')){
            place.country = c['short_name'];
          }
        }
        );
        return place;
      }

      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}

