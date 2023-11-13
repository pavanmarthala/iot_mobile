import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class DeviceController extends GetxController {
  RxString selectedDeviceId = "".obs;

  void setSelectedDeviceId(String deviceId) {
    selectedDeviceId.value = deviceId;
  }
}
