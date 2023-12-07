/*

Fecha: 07-12-2023
Descripción: testskil en Flutter para "Tots"
Desarrollador: Andrés Pugliese
Tiempo de desarrollo: 20hs aproximadamente (3 días)
E-mail: andresdecba@gmail.com
Mi Linked in: https://www.linkedin.com/in/andres-pugliese
Mi github: https://github.com/andresdecba
Mi playstore: https://play.google.com/store/apps/details?id=site.thisweek


*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tots_flutter_test/core/routes/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // prevent portrait orientation and then run app
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(
      const ProviderScope(
        child: MainApp(),
      ),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: Colors.grey.shade100),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, // text color
            backgroundColor: Colors.black, // background color
          ),
        ),
      ),
      routerConfig: appRouter, //,
    );
  }
}
