import 'package:flutter_app_mvp/counter/counter_view.dart';
import 'package:flutter_app_mvp/mvp/presenter.dart';

class CounterPresenter extends Presenter<CounterView> {
  int count = 0;

  increment() {
    count++;
    getView().onIncrement(count);
  }

  decrement() {
    count--;
    getView().onIncrement(count);
  }
}
