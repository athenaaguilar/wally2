import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wally2/core/utils/navigation/app_router.dart';
import 'package:wally2/features/transactions/data/repositories/transaction_repository_impl.dart';
import 'package:wally2/features/transactions/presentation/business_logic/transactions_bloc.dart';
import 'package:wally2/features/wallet/data/repositories/wallet_repository_impl.dart';
import 'package:wally2/features/wallet/presentation/business_logic/wallet_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GoRouter _appRouter = appRouter();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<WalletRepositoryImpl>(
          create: (context) => WalletRepositoryImpl(),
        ),
        RepositoryProvider<TransactionRepositoryImpl>(
          create: (context) => TransactionRepositoryImpl(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => WalletBloc(
              walletRepository:
                  RepositoryProvider.of<WalletRepositoryImpl>(context),
            ),
          ),
          BlocProvider(
            create: (context) => TransactionBloc(
              transactionRepository:
                  RepositoryProvider.of<TransactionRepositoryImpl>(context),
            ),
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Wally',
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
            useMaterial3: true,
          ),
          routerConfig: _appRouter,
        ),
      ),
    );
  }
}
