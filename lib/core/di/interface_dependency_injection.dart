import 'package:get/get.dart';

void initInterfaces() {
  Get.lazyPut<HomeInterface>(() => HomeServiceImpl(), fenix: true);
}
