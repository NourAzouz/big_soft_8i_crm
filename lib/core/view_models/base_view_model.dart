import 'package:flutter/foundation.dart';

import '../enums/view_states.dart';

class BaseViewModel extends ChangeNotifier {
  ViewState state = ViewState.Idle;

  void changeState(ViewState viewState) {
    state = viewState;
    notifyListeners();
  }
}
