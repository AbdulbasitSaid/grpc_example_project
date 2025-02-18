import 'package:flutter/material.dart';
import 'package:protos/protos.dart';

void main() {
  final rpcClientChannel = ClientChannel('10.0.0.169',
      port: 50051, options: const ChannelOptions(credentials: ChannelCredentials.insecure()));

  final stub = TodoServiceClient(rpcClientChannel);
  runApp(MainApp(
    stub: stub,
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.stub});
  final TodoServiceClient stub;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: StreamBuilder<Object>(
            stream: stub.listTodosStream(Empty()),
            builder: (cxt, snapshot) {
              if (snapshot.hasData) {
                final todo = snapshot.data;
                if (todo == null) {
                  return Center(
                    child: Text('No data'),
                  );
                }
                todo as Todo;
                return ListTile(
                  title: Text(todo.title),
                  subtitle: Text(todo.description),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
