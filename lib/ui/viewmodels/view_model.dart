import 'package:flutter/cupertino.dart';

class ViewModel extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  void setLoading(bool loading) {
    _loading = loading;
//    notifyListeners();
  }
}
