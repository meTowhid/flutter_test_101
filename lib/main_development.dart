import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_task_101/app/app.dart';
import 'package:flutter_task_101/bootstrap.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env.development');
  await bootstrap(() => const App());
}
