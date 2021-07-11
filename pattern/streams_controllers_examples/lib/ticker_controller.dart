// import 'dart:async';

import 'dart:async';

class TickerController {
  int _currentData;

  final StreamController<int> _dataController = StreamController<int>();
  Stream<int> get dataStreaming =>
      _dataController.stream; //to fetch data from the stream [data-container]
  StreamSink<int> get _dataSinking =>
      _dataController.sink; //to add data to the stream [data-container]

  final StreamController<int> _incrementController = StreamController<int>();
  StreamSink<int> get incrementData => _incrementController.sink;

  final StreamController<int> _decrementController = StreamController<int>();
  StreamSink<int> get decrementData => _decrementController.sink;

  TickerController() {
    _currentData = 0;
    _dataController.add(_currentData);
    // _incrementController.stream.listen((value) {
    //   _incrementData(value);
    // });
    _incrementController.stream.listen((_incrementData));
    _decrementController.stream.listen((_decrementData));
  }

  //increment the current value of the data
  void _incrementData(int newDataValue) {
    newDataValue++;
    _dataSinking.add(newDataValue);
  }

  //decrement the current value of the data
  void _decrementData(int newDataValue) {
    if (newDataValue > 0) {
      newDataValue--;
      _dataSinking.add(newDataValue);
    }
  }

  void dispose() {
    _dataController.close();
    _incrementController.close();
    _decrementController.close();
  }
}
