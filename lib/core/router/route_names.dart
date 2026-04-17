class RouteNames {
  RouteNames._();

  // Auth
  static const String splash = '/';
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';

  // Main Shell
  static const String dashboard = '/dashboard';
  static const String products = '/products';
  static const String productDetail = '/products/:id';
  static const String addProduct = '/products/add';

  static const String orders = '/orders';
  static const String orderDetail = '/orders/:id';
  static const String createOrder = '/orders/create';

  static const String customers = '/customers';
  static const String customerDetail = '/customers/:id';
  static const String addCustomer = '/customers/add';

  static const String reports = '/reports';
  static const String profile = '/profile';
}
