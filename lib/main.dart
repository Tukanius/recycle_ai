import 'package:flutter/material.dart';
import 'package:smart_bin_flutter/provider/tools_provider.dart';
import 'package:smart_bin_flutter/provider/user_provider.dart';
import 'package:smart_bin_flutter/services/dialog.dart';
import 'package:smart_bin_flutter/services/navigation.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_bin_flutter/src/auth/choose_method.dart';
import 'package:smart_bin_flutter/src/auth/login_page.dart';
import 'package:smart_bin_flutter/src/auth/opt_page.dart';
import 'package:smart_bin_flutter/src/auth/password_page.dart';
import 'package:smart_bin_flutter/src/auth/register_page.dart';
import 'package:smart_bin_flutter/src/main_page.dart';
import 'package:smart_bin_flutter/src/notification_page/notification_detail_page.dart';
import 'package:smart_bin_flutter/src/notification_page/notification_page.dart';
import 'package:smart_bin_flutter/src/qr_page/qr_success.dart';
import 'package:smart_bin_flutter/src/splash_screen/splash_page.dart';
import 'package:smart_bin_flutter/widget/dialog_manager/dialog_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  runApp(const MyApp());
}

GetIt locator = GetIt.instance;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => ToolsProvider()),
        ],
        child: MaterialApp(
          builder: (context, widget) => Navigator(
            onGenerateRoute: (settings) => MaterialPageRoute(
              builder: (context) =>
                  DialogManager(child: loading(context, widget)),
            ),
          ),
          title: 'Green Score',
          theme: ThemeData(useMaterial3: false),
          debugShowCheckedModeBanner: false,
          initialRoute: SplashPage.routeName,
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case SplashPage.routeName:
                return MaterialPageRoute(builder: (context) {
                  return const SplashPage();
                });
              case MainPage.routeName:
                return MaterialPageRoute(builder: (context) {
                  return const MainPage();
                });
              case LoginPage.routeName:
                return MaterialPageRoute(builder: (context) {
                  return const LoginPage();
                });
              case RegisterPage.routeName:
                return MaterialPageRoute(builder: (context) {
                  return const RegisterPage();
                });
              case ChooseMethod.routeName:
                return MaterialPageRoute(builder: (context) {
                  return const ChooseMethod();
                });
              case OtpPage.routeName:
                OtpPageArguments arguments =
                    settings.arguments as OtpPageArguments;
                return MaterialPageRoute(builder: (context) {
                  return OtpPage(
                    username: arguments.username,
                  );
                });
              case PassWordPage.routeName:
                PassWordPageArguments arguments =
                    settings.arguments as PassWordPageArguments;
                return MaterialPageRoute(builder: (context) {
                  return PassWordPage(
                    isForgot: arguments.isForgot,
                  );
                });
              case NotificationPage.routeName:
                return MaterialPageRoute(builder: (context) {
                  return const NotificationPage();
                });
              case NotificationDetailPage.routeName:
                NotificationDetailPageArguments arguments =
                    settings.arguments as NotificationDetailPageArguments;
                return MaterialPageRoute(builder: (context) {
                  return NotificationDetailPage(
                    data: arguments.data,
                  );
                });
              case QrSuccessPage.routeName:
                QrSuccessPageArguments arguments =
                    settings.arguments as QrSuccessPageArguments;
                return MaterialPageRoute(builder: (context) {
                  return QrSuccessPage(
                    data: arguments.data,
                  );
                });
              default:
                return MaterialPageRoute(
                  builder: (_) => const SplashPage(),
                );
            }
          },
        ));
  }
}

Widget loading(BuildContext context, widget) {
  bool shouldPop = false;

  return PopScope(
    canPop: shouldPop,
    child: Scaffold(
      backgroundColor: Colors.black.withOpacity(0.3),
      body: Container(
        color: Colors.blue,
        child: SafeArea(
          bottom: false,
          top: false,
          child: Stack(
            children: [
              Opacity(
                opacity: 1,
                child: Container(
                  color: Colors.black,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      widget,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
