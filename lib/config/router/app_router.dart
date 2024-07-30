import 'package:go_router/go_router.dart';
import 'package:test_app/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: HomeScreen.path,
  routes: [
    GoRoute(
      path: HomeScreen.path,
      name: HomeScreen.name,
      builder: (context, state) =>  const HomeScreen(),
    ),
    GoRoute(
      path: DetailScreen.path,
      name: DetailScreen.name,
      builder: (context, state) =>  const DetailScreen(),
    ),
    GoRoute(
      path: SellerDetailScreen.path,
      name: SellerDetailScreen.name,
      builder: (context, state) =>  const SellerDetailScreen(),
    ),
  ]
);