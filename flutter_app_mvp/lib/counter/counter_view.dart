import 'package:flutter_app_mvp/mvp/mvp_view.dart';

abstract class CounterView extends MvpView {
  void onIncrement(int value);
  void onDecrement(int value);
}
