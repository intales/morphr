import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:morphr_app/figma_setup/pages/figma_setup_page.dart';

part 'router.g.dart';

final router = GoRouter(routes: $appRoutes);

@TypedGoRoute<FigmaSetupRoute>(path: '/')
class FigmaSetupRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const FigmaSetupPage();
  }
}
