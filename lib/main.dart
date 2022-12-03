import 'package:amplitude_flutter/amplitude.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:get/get.dart';
import 'package:loomus_app/di/service_locator.dart';
import 'package:loomus_app/modules/home/home_view_model.dart';
import 'package:loomus_app/provider/app_provider.dart';
import 'package:loomus_app/services/local_storage.dart';
import 'package:loomus_app/utilities/constants.dart';
import 'package:loomus_app/utilities/ls_color.dart';
import 'package:loomus_app/utilities/ls_router.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Setup dependencies
  setupLocator();

  // Setup amplitude
  final amplitude = Amplitude.getInstance();
  await amplitude.init(Constants.amplitudeKey);
  await amplitude.trackingSessionEvents(true);

  // Setup firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Setup appsflyer
  AppsFlyerOptions appsFlyerOptions = AppsFlyerOptions(
      afDevKey: Constants.appsFlyerKey,
      appId: Constants.appleAppId,
      timeToWaitForATTUserAuthorization: 50);
  AppsflyerSdk appsflyerSdk = AppsflyerSdk(appsFlyerOptions);
  appsflyerSdk.initSdk(
      registerConversionDataCallback: true,
      registerOnAppOpenAttributionCallback: true,
      registerOnDeepLinkingCallback: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => AppProvider(),
        builder: (context, child) => Consumer<AppProvider>(
            builder: (context, provider, child) => FutureBuilder<UserData>(
                  future: LocalStorage().getCurrentUserData(),
                  builder: (context, snapshot) {
                    final Widget rootPage;
                    final data = snapshot.data;
                    if (data != null) {
                      final user = data.user;

                      if (user == null) {
                        rootPage = LsRouter.makeLogin();
                      } else {
                        provider.setLocale(
                            Locale(user.language.toLowerCase()), false);
                        rootPage = LsRouter.makeHome(HomeDataSource(user));
                      }

                      FlutterNativeSplash.remove();
                    } else {
                      rootPage = LsRouter.makeLaunch();
                    }

                    if (data != null) {
                      AppTrackingTransparency.requestTrackingAuthorization();
                    }

                    return GetMaterialApp(
                      home: PlatformApp(
                          title: "Loomus",
                          localizationsDelegates: const [
                            AppLocalizations.delegate, // Add this line
                            GlobalMaterialLocalizations.delegate,
                            GlobalWidgetsLocalizations.delegate,
                            GlobalCupertinoLocalizations.delegate
                          ],
                          locale: provider.locale,
                          supportedLocales: const [
                            Locale("en"),
                            Locale("ru"),
                            Locale("kk"),
                          ],
                          home: rootPage,
                          debugShowCheckedModeBanner: false,
                          material: (_, __) => MaterialAppData(
                              themeMode: provider.theme,
                              theme: ThemeData(
                                  backgroundColor: LsColor.background,
                                  appBarTheme: const AppBarTheme(
                                      backgroundColor: LsColor.background,
                                      foregroundColor: LsColor.brand,
                                      titleTextStyle: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: LsColor.label,
                                          fontFamily: "Inter"),
                                      shadowColor: Colors.transparent),
                                  primaryColor: LsColor.brand,
                                  primarySwatch: LsColor.primary,
                                  fontFamily: "Inter")),
                          cupertino: (_, __) => CupertinoAppData(
                              theme: const CupertinoThemeData(
                                  primaryColor: LsColor.brand,
                                  barBackgroundColor: LsColor.background,
                                  scaffoldBackgroundColor: LsColor.background,
                                  textTheme: CupertinoTextThemeData(
                                      primaryColor: LsColor.brand,
                                      textStyle: TextStyle(
                                          color: LsColor.label,
                                          fontSize: 17,
                                          fontFamily: "SF Pro Display"))))),
                    );
                  },
                )));
  }
}
