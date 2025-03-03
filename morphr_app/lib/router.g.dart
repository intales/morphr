// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$figmaSetupRoute];

RouteBase get $figmaSetupRoute => GoRouteData.$route(
  path: '/',

  factory: $FigmaSetupRouteExtension._fromState,
);

extension $FigmaSetupRouteExtension on FigmaSetupRoute {
  static FigmaSetupRoute _fromState(GoRouterState state) => FigmaSetupRoute();

  String get location => GoRouteData.$location('/');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
