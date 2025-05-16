import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class NotificationPage extends StatelessWidget {
  final channel = IOWebSocketChannel.connect(
    Uri.parse('ws://192.168.1.69:8000/ws/notifications/99999999999999'),
  );
  static route() => MaterialPageRoute(builder: (context) => NotificationPage());

  NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: StreamBuilder(
        stream: channel.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData) {
            return const Center(child: Text("Waiting for notifications..."));
          }
          return ListTile(title: Text("Notification: ${snapshot.data}"));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          channel.sink.add("Hello from Flutter");
        },
        child: const Icon(Icons.send),
      ),
    );
  }
}
