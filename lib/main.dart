import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:test_app/config/constants/environment.dart';
import 'package:test_app/config/constants/local_notifications.dart';
import 'package:test_app/config/router/app_router.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/firebase_options.dart';
import 'package:test_app/presentation/providers/advertisement/advertisement_provider.dart';
import 'package:test_app/presentation/providers/seller/seller_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final token = await FirebaseMessaging.instance.getToken();
  await LocalNotifications.requestPermissonLocalNotifications();
  await LocalNotifications.initializeLocalNotifications();
  FirebaseMessaging.onMessage.listen((event) {
    LocalNotifications.showLocalNotification(id: 1, body: event.notification?.body ?? '');
  },);
  print(token);
  await Environment.initEnvironment();
  SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
  ]);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AdvertisementProvider()),
        ChangeNotifierProvider(create: (_) => SellerProvider())
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
        theme: AppTheme().getTheme(),
      ),
    );
  }
}
