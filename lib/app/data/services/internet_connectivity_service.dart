import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class InternetConnectivityService extends GetxService {
  final Connectivity _connectivity = Connectivity();
  final RxBool isInternetAvailable = false.obs;

  @override
  void onInit() {
    super.onInit();
    _checkInternetConnectivity();
  }

  Future<void> _checkInternetConnectivity() async {
    final List<ConnectivityResult> result =
        await _connectivity.checkConnectivity();
    isInternetAvailable.value = !(result.contains(ConnectivityResult.none));
  }
}
