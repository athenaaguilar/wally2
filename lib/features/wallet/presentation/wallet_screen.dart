import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wally2/core/presentation/widgets/app_button.dart';
import 'package:wally2/core/presentation/widgets/app_scaffold.dart';
import 'package:wally2/core/utils/number_extensions.dart';
import 'package:wally2/features/send_money/presentation/send_money_screen.dart';
import 'package:wally2/features/transactions/presentation/transactions_screen.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  static const String routeName = '/';

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool isAmountUnmask = true;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Column(
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
                  setState(() => isAmountUnmask = !isAmountUnmask);
                },
                child: Icon(
                  isAmountUnmask ? Icons.visibility : Icons.visibility_off,
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
              Text(
                isAmountUnmask ? 500.formatAmount() : '****',
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AppButton(
                  title: 'Send Money',
                  onPressed: () => context.push(SendMoneyScreen.routeName),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: AppButton(
                  title: 'View Transactions',
                  onPressed: () => context.push(TransactionsScreen.routeName),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
