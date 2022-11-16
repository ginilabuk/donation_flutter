import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sample_project/providers/test_provider.dart';

List<SingleChildWidget> registeredProviders = [
  // Theme
  ChangeNotifierProvider(create: ((context) => TestProvider())),
];
