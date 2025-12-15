import 'package:get/get.dart';
import 'package:pioneer_alpha_ltd_task/feature/home/implement/service_interface_immplement.dart';
import 'package:pioneer_alpha_ltd_task/feature/home/interface/home_interface.dart';

void initInterfaces() {
  Get.lazyPut<HomeInterface>(() => HomeServiceImpl(), fenix: true);
}
