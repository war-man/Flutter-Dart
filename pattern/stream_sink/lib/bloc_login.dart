import 'dart:async';

class LoginBLoc {
  int dem = 0;

  // ignore: close_sinks
  StreamController demController = StreamController<int>();
  get demStream => demController.stream;

  void them() {
    dem += 1;
    demController.sink.add(dem);
    print("dem--------->$dem");
  }

  void dispose() {
    demController.close();
  }
}
