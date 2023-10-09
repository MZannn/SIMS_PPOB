part of 'env.dart';

class Routes {
  const Routes({
    required this.path,
    required this.page,
  });
  final String path;
  final Widget page;
  static Routes splash = const Routes(
    path: 'splash',
    page: SplashPage(),
  );
  static Routes login = const Routes(
    path: 'login',
    page: LoginPage(),
  );
  static Routes register = const Routes(
    path: 'register',
    page: RegisterPage(),
  );
  static Routes homepage = const Routes(
    path: 'homepage',
    page: NavigatorPage(),
  );
  static Routes payment = const Routes(
    path: 'payment',
    page: PaymentPage(),
  );
  static Routes banner = const Routes(
    path: 'banner',
    page: BannerPage(),
  );
}
