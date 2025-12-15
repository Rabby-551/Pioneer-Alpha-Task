import 'package:get/get.dart';

void initControllers() {
  Get.put(
    HomeController(Get.find<HomeInterface>()),
    permanent: true,
  );
}
