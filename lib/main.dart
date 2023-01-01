import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'pages/splash.dart';
import 'services/app_services.dart';
import 'services/theme.dart';
import 'services/translation_service.dart';
import 'services/translations.dart';
import 'services/shared_helper.dart';

Future<void> initServices() async {
  Get.log('starting services ...');

  await Get.putAsync<AppServices>(() async => AppServices());

  await Get.putAsync<TranslationService>(() async => TranslationService());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedHelper.init();
  await initServices();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final appServices = Get.find<AppServices>();
  final translationServices = Get.find<TranslationService>();
  @override
  void initState() {
    translationServices.getLocale();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
          themeMode: appServices.isDark.value ? ThemeMode.dark : ThemeMode.light,
          localizationsDelegates: const [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: translationServices.supportedLocales(),
          translations: Messages(),
          locale: Get.locale ?? Locale(Get.deviceLocale.languageCode),
          fallbackLocale: const Locale('en'),
          debugShowCheckedModeBanner: false,
          title: 'Flutter Stateful Clicker Counter',
          theme: lightTheme,
          darkTheme: darkTheme,
          home: Splash(),
        ));
  }
}
