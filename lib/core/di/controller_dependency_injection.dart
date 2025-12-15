import 'package:get/get.dart';
import 'package:pioneer_alpha_ltd_task/feature/home/controller/home_controller.dart';
import 'package:pioneer_alpha_ltd_task/feature/home/interface/home_interface.dart';

void initControllers() {
  Get.put(
    HomeController(Get.find<HomeInterface>()),
    permanent: true,
  );
}
