import 'package:trueaddresser/imports.dart';

class AppRouter {
  Route onGenerate(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
        break;
      case '/userLogin':
        return MaterialPageRoute(builder: (_) => UserLogin());
        break;
      case '/userSignup':
        return MaterialPageRoute(builder: (_) => UserSignup());
        break;
      default:
        return null;
    }
  }
}
