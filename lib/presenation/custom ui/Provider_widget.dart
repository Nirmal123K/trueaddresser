import 'package:trueaddresser/imports.dart';

class Providers extends InheritedWidget {
  final AuthService auth;
  final db;
  final colors;

  Providers({Key key, Widget child, this.auth, this.db, this.colors}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static Providers of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<Providers>());
}