import 'package:get/get.dart';
import 'package:untitled/HomePage/model/model.dart';

class HomeController extends GetxController {
  // Products products = Products();

  RxList<dynamic> dataList = <dynamic>[].obs;

  RxBool AtoZ = true.obs;
  RxBool ZtoA = true.obs;
  RxBool ratings = true.obs;
  RxBool HtoL = true.obs;
  RxBool LtoH = true.obs;

  void filterApi() {
    dataList.sort(
      (a, b) => a.name
          .toString()
          .toLowerCase()
          .compareTo(b.name.toString().toLowerCase()),
    );
    print("=================${dataList}");
    update();
  }
}
