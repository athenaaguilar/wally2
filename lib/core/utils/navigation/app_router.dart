import 'package:go_router/go_router.dart';
import 'package:wally2/features/send_money/presentation/send_money_screen.dart';
import 'package:wally2/features/transactions/presentation/transactions_screen.dart';
import 'package:wally2/features/wallet/presentation/wallet_screen.dart';

GoRouter appRouter() {
  return GoRouter(
    initialLocation: WalletScreen.routeName,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: WalletScreen.routeName,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const WalletScreen(),
        ),
      ),
      GoRoute(
        path: SendMoneyScreen.routeName,
        pageBuilder: (context, state) {
          final args = state.extra as int;

          return NoTransitionPage<void>(
            key: state.pageKey,
            child: SendMoneyScreen(balance: args),
          );
        },
      ),
      GoRoute(
        path: TransactionsScreen.routeName,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const TransactionsScreen(),
        ),
      ),
    ],
  );
}
