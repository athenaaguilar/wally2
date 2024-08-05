import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:wally2/core/presentation/widgets/app_loading_indicator.dart';
import 'package:wally2/core/presentation/widgets/app_scaffold.dart';
import 'package:wally2/core/utils/number_extensions.dart';
import 'package:wally2/features/transactions/presentation/business_logic/transactions_bloc.dart';
import 'package:wally2/features/transactions/presentation/business_logic/transactions_event.dart';
import 'package:wally2/features/transactions/presentation/business_logic/transactions_state.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  static const String routeName = '/transactions';

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  @override
  void initState() {
    context.read<TransactionBloc>().add(const GetTransactionHistoryEvent(1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Transaction History',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          BlocBuilder<TransactionBloc, TransactionState>(
              builder: (context, state) {
            if (state is TransactionLoadingState) {
              return const Center(child: AppLoadingIndicator());
            }

            if (state is GetTransactionHistorySuccessState) {
              return Expanded(
                child: ListView.builder(
                  itemCount: state.transactionHistory.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 0.0,
                      color: Colors.blueGrey.shade50,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.transactionHistory[index]
                                      .transactionType,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  DateFormat('d MMMM, y').format(
                                    state.transactionHistory[index].createdAt,
                                  ),
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            Text(
                              '${state.transactionHistory[index].transactionType == 'Interest' ? '+' : '-'} ₱ ${state.transactionHistory[index].amount.formatAmount()}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }

            return const Center(child: Text('No Transaction History'));
          }),
        ],
      ),
    );
  }
}
