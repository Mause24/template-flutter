class GeneralRoutes {
  static const splash = '/splash';
  static const componentView = '/component-view';

  // =====================
  // Deep Linking
  // =====================

  /// Patrón usado por GoRouter
  static const deepLinkPattern = '/open/:id';

  /// Helper para construir rutas reales
  /// Ejemplo: GeneralRoutes.deepLink('ABC123')
  static String deepLink(String id) => '/open/$id';
}
