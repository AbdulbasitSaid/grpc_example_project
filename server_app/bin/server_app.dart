import 'package:protos/protos.dart';
import 'package:server_app/todo_service.dart';

Future<void> main(List<String> arguments) async {
  final serverApp = Server.create(services: [
    TodoService(),
  ]);
  await serverApp.serve(port: 50051);
  print('Server listening on port ${serverApp.port}...');
}
