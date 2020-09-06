import 'dart:async';

import 'package:testappone/service/internet_service.dart';
import 'package:rxdart/rxdart.dart';

class NetworkBloc {
  final _networkService = InternetService();

  final _controller = StreamController<String>();

  Stream<String> get status => _controller.stream;

  networkStatus() async {
    String statusString = await _networkService.initialize();
    _controller.sink.add(statusString);
  }

  dispose() {
    _controller.close();
  }
}

final bloc = NetworkBloc();
