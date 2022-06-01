import 'package:acak_soal/core/service_locator/injection_container.dart';
import 'package:acak_soal/core/style/text_theme.dart';
import 'package:acak_soal/features/form/presentation/choose_,layout/choose_layout_args.dart';
import 'package:acak_soal/features/form/presentation/choose_,layout/choose_layout_screen.dart';
import 'package:acak_soal/features/form/presentation/form/form_screen.dart';
import 'package:acak_soal/features/form/presentation/result/result_screen.dart';
import 'package:acak_soal/features/landing_page/presentation/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async{
  await InjectionContainer.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      builder: (context, child) => ResponsiveWrapper.builder(child,
          maxWidth: 1200,
          minWidth: 480,
          defaultScale: true,
          breakpoints: const [
            ResponsiveBreakpoint.resize(480, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          ],
          background: Container(color: const Color(0xFFF5F5F5))),
      routes: {
        LandingScreen.routName:(context) =>  LandingScreen(),
        FormScreen.routeName:(context) => const FormScreen(),
        ResultScreen.routeName: (context) => const ResultScreen(),
        ChooseLayoutScreen.routeName: (context) => const ChooseLayoutScreen()
      },
      initialRoute: LandingScreen.routName,
      // home: const ResultScreenTest(),
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          textTheme: AppTextTheme()),
    );
  }
}
