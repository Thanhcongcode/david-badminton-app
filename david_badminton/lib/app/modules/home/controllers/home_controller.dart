import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late FocusNode searchFocusNode;

  @override
  void onInit() {
    super.onInit();
    searchFocusNode = FocusNode();
    
  }

  void unfocusSearchBar() {
    if(searchFocusNode.hasFocus)
    searchFocusNode.unfocus();
  }

  @override
  void onClose() {
    unfocusSearchBar();
    searchFocusNode.dispose();
    super.onClose();
  }
}
