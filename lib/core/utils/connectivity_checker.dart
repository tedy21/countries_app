import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:io';

class ConnectivityChecker {
  final Connectivity _connectivity = Connectivity();

  Future<bool> hasInternetConnection() async {
    try {
      final result = await _connectivity.checkConnectivity();

      if (result == ConnectivityResult.none) {
        return false;
      }

      // For release builds, also try to actually reach the internet
      // connectivity_plus only checks if WiFi/Mobile is connected, not if internet is available
      try {
        final response = await InternetAddress.lookup('restcountries.com');
        return response.isNotEmpty && response[0].rawAddress.isNotEmpty;
      } catch (e) {
        // If lookup fails, still return true if we have connectivity
        // because the connectivity check might be sufficient
        return result != ConnectivityResult.none;
      }
    } catch (e) {
      // In case of any error, assume we have internet and let the actual request fail
      // This prevents false negatives in release builds
      return true;
    }
  }

  Future<ConnectivityResult> getConnectivityResult() async {
    try {
      return await _connectivity.checkConnectivity();
    } catch (e) {
      return ConnectivityResult.none;
    }
  }

  Stream<ConnectivityResult> get connectivityStream =>
      _connectivity.onConnectivityChanged;
}
