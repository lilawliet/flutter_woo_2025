import 'package:socket_io_client/socket_io_client.dart' as IO;

IO.Socket socket = IO.io(
  'http://localhost:3000',
  IO.OptionBuilder()
      .setTransports(['websocket']) // for Flutter or Dart VM
      // .setExtraHeaders({'foo': 'bar'}) // optional
      .build(),
);
