import 'package:flutter/material.dart';
import 'package:wally2/core/presentation/widgets/app_button.dart';
import 'package:wally2/core/presentation/widgets/app_scaffold.dart';
import 'package:wally2/core/presentation/widgets/app_snackbar.dart';

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key});

  static const String routeName = '/send-money';

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  TextEditingController controller = TextEditingController();

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
            ),
            style: const TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
            cursorColor: Colors.blueGrey,
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: Expanded(
              child: AppButton(
                title: 'Submit',
                onPressed: () {
                  showAppSnackbar(
                    context,
                    label:
                        'Send money success!\n₱ ${controller.text} has been deducted from your balance.',
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
