import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/core/registered_providers.dart';
import 'package:sample_project/router/my_router.dart';
import 'package:sample_project/router/route_to.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: registeredProviders,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sample Project',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.purple,
      ),
      onGenerateRoute: MyRouter.generateRoute,
      initialRoute: RouteTo.home.name,
    );
  }
}
