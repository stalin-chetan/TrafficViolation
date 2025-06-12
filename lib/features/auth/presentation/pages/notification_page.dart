import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class NotificationPage extends StatefulWidget {
  final String licenseNumber;
  const NotificationPage({required this.licenseNumber, super.key});

  static Route routeWithLicense(String licenseNumber) {
    return MaterialPageRoute(
      builder: (context) => NotificationPage(licenseNumber: licenseNumber),
    );
  }

  @override
  NotificationPageState createState() => NotificationPageState();
}

class NotificationPageState extends State<NotificationPage> {
  late final WebSocketChannel channel;
  final List<Map<String, String>> notifications = [];

  @override
  void initState() {
    super.initState();
    _loadNotifications();

    channel = IOWebSocketChannel.connect(
      Uri.parse('ws://10.0.2.2:8000/ws/notifications/${widget.licenseNumber}'),
    );

    channel.stream.listen((data) async {
      try {
        final decoded = jsonDecode(data);
        if (decoded is Map<String, dynamic> && decoded.containsKey('message')) {
          final String message = decoded['message'];
          final String timestamp = TimeOfDay.now().format(context);

          setState(() {
            notifications.insert(0, {'message': message, 'time': timestamp});
          });

          await _saveNotifications();
        }
      } catch (e) {
        debugPrint("Error decoding message: $e");
      }
    });
  }

  Future<void> _loadNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList('notifications_${widget.licenseNumber}');
    if (stored != null) {
      final decoded = stored
          .map((e) => Map<String, String>.from(jsonDecode(e)))
          .toList();
      setState(() {
        notifications.addAll(decoded);
      });
    }
  }

  Future<void> _saveNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedList = notifications.map((e) => jsonEncode(e)).toList();
    await prefs.setStringList('notifications_${widget.licenseNumber}', encodedList);
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: notifications.isEmpty
          ? const Center(child: Text("Waiting for notifications..."))
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final item = notifications[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                  child: Dismissible(
                    key: Key(item['message']! + item['time']!),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) async {
                      setState(() {
                        notifications.removeAt(index);
                      });
                      await _saveNotifications();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Notification deleted')),
                      );
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    child: Card(
                      color: const Color.fromRGBO(36, 47, 64, 0.9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: ListTile(
                        leading: const Icon(Icons.notifications, color: Colors.blue),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                item['message']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Text(
                              item['time']!,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 217, 212, 212),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
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
