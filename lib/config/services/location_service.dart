

import 'dart:async';

import 'package:citizen_app/config/locator.dart';
import 'package:citizen_app/config/services/dialog_service.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {

  StreamSubscription<Position>? positionStreamSubscription;
  Position? _currentPosition;

  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );

  Position? get position => _currentPosition;


  Future<void> startListening() async {
    try {
      // Check for location permissions
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied');
      }

      // Start listening to the stream
      positionStreamSubscription?.cancel();
      positionStreamSubscription = Geolocator.getPositionStream(
        locationSettings: locationSettings,
      ).listen(
            (Position position) {
            _currentPosition = position;
        });
    } catch (e) {
      locator<DialogService>().showSnackBar("Location Error", e.toString());
    }
  }

  void stopListening() {
    positionStreamSubscription?.cancel();
    _currentPosition = null;
  }

}