import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wally2/core/presentation/widgets/app_button.dart';
import 'package:wally2/core/presentation/widgets/app_scaffold.dart';
import 'package:wally2/core/presentation/widgets/app_snackbar.dart';
import 'package:wally2/core/utils/number_extensions.dart';
import 'package:wally2/features/transactions/presentation/business_logic/transactions_bloc.dart';
import 'package:wally2/features/transactions/presentation/business_logic/transactions_event.dart';
import 'package:wally2/features/wallet/presentation/business_logic/wallet_bloc.dart';
import 'package:wally2/features/wallet/presentation/business_logic/wallet_event.dart';

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key, required this.balance});

  static const String routeName = '/send-money';

  final int balance;

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  TextEditingController controller = TextEditingController();

  bool _isLoading = false;
  bool _isError = false;
  bool _isButtonEnabled = false;

  Timer? _debounce;

  @override
  void initState() {
    controller.addListener(() {
      _debounce = Timer(const Duration(milliseconds: 500), () {
        if (controller.text.isEmpty) {
          setState(() => _isButtonEnabled = false);
        } else {
          if (int.parse(controller.text) > widget.balance) {
            setState(() => _isError = true);
          } else {
            setState(() => _isError = false);
          }
          if (int.parse(controller.text) > 0) {
            setState(() => _isButtonEnabled = true);
          }
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Send Money',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextField(
            controller: controller,
            autofocus: true,
            autocorrect: false,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              controller.text = value;
            },
            decoration: InputDecoration(
              prefixText: '₱ ',
              prefixStyle: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 34,
              ),
              counterText: 'Balance: ₱ ${widget.balance.formatAmount()}',
              errorText: _isError ? 'Insufficient Balance' : null,
            ),
            style: const TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
            cursorColor: Colors.blueGrey,
            maxLength: 5,
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: AppButton(
              title: 'Submit',
              isLoading: _isLoading,
              isEnabled: _isButtonEnabled && !_isError,
              onPressed: () async {
                setState(() => _isLoading = true);
                Future.delayed(const Duration(seconds: 2), () {
                  final bool isSuccess = Random().nextBool();
                  if (isSuccess) {
                    showAppSnackbar(
                      context,
                      label:
                          'Send money success!\n₱ ${controller.text}.00 has been deducted from your balance.',
                    );
                    // Add to transaction history
                    context.read<TransactionBloc>().add(AddTransactionEvent(
                          int.parse(controller.text),
                          'Send Money',
                        ));
                    // Subtract to wallet balance
                    context.read<WalletBloc>().add(UpdateWalletEvent(
                          1,
                          widget.balance - int.parse(controller.text),
                        ));
                    // Redirect back to wallet screen
                    context.read<WalletBloc>().add(const GetWalletEvent(1));
                    context.pop();
                  } else {
                    showAppSnackbar(
                      context,
                      label: 'Send money failed!\nPlease try again later.',
                    );
                  }
                  setState(() => _isLoading = false);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
