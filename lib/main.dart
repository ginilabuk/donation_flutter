import 'package:donation_flutter/core/register_singletons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:donation_flutter/core/registered_providers.dart';
import 'package:donation_flutter/router/my_router.dart';
import 'package:donation_flutter/router/route_to.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await registerSingletons();

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
      title: 'NMC Donation',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.purple,
      ),
      onGenerateRoute: MyRouter.generateRoute,
      initialRoute: RouteTo.splash.name,
    );
  }
}
