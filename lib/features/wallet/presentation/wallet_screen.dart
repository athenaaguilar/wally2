import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wally2/core/presentation/widgets/app_button.dart';
import 'package:wally2/core/presentation/widgets/app_loading_indicator.dart';
import 'package:wally2/core/presentation/widgets/app_scaffold.dart';
import 'package:wally2/core/utils/number_extensions.dart';
import 'package:wally2/features/send_money/presentation/send_money_screen.dart';
import 'package:wally2/features/transactions/presentation/transactions_screen.dart';
import 'package:wally2/features/wallet/presentation/business_logic/wallet_bloc.dart';
import 'package:wally2/features/wallet/presentation/business_logic/wallet_event.dart';
import 'package:wally2/features/wallet/presentation/business_logic/wallet_state.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  static const String routeName = '/';

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool _isAmountUnmask = true;

  @override
  void initState() {
    context.read<WalletBloc>().add(const GetWalletEvent(1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: BlocBuilder<WalletBloc, WalletState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Wallet Balance',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      setState(() => _isAmountUnmask = !_isAmountUnmask);
                    },
                    child: Icon(
                      _isAmountUnmask ? Icons.visibility : Icons.visibility_off,
                      color: Colors.blueGrey,
                      size: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text(
                    '₱ ',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  state is GetWalletSuccessState
                      ? Text(
                          _isAmountUnmask
                              ? state.wallet.balance.formatAmount()
                              : '****',
                          style: const TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : const AppLoadingIndicator(),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: AppButton(
                      title: 'Send Money',
                      onPressed: () => context.push(
                        SendMoneyScreen.routeName,
                        extra: state is GetWalletSuccessState
                            ? state.wallet.balance
                            : 0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: AppButton(
                      title: 'View Transactions',
                      onPressed: () =>
                          context.push(TransactionsScreen.routeName),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
