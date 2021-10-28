import 'package:fh4_utility_tools/globals.dart';
import 'package:udp/udp.dart';

main() async {

  var receiver = await UDP.bind(Endpoint.loopback(port: Port(11011)));

  await receiver.listen((datagram) {
    var byteArray = datagram.data.buffer.asByteData();
    //todo function that fill data from buffer
    Globals.telemetry.resolveData(byteArray);
  },timeout: Duration(seconds: 20));

}
