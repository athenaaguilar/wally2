import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:wally2/features/transactions/data/models/transaction_model.dart';
import 'package:wally2/features/transactions/domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl extends TransactionRepository {
  @override
  Future<List<TransactionModel>> getTransactionHistory(int walletId) async {
    final Uri url = Uri.https(
      'mockend.com',
      'api/athenaaguilar/wally2/transactions',
      {'createdAt_order': 'desc', 'wallet_eq': '$walletId'},
    );

    Response response = await http.get(url);
    List<dynamic> jsonList = jsonDecode(response.body);
    final List<TransactionModel> transactions = jsonList.map((item) {
      return TransactionModel.fromJson(item);
    }).toList();

    return transactions;
  }

  @override
  Future<void> addTransaction(int amount, String transactionType) async {
    final Uri url = Uri.https(
      'mockend.com',
      'api/athenaaguilar/wally2/transactions',
    );

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'amount': amount,
          'transactionType': transactionType,
          'createdAt': DateTime.now().toIso8601String(),
        }),
      );

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        log('Response data: $responseData');
      } else {
        log('Error: ${response.statusCode}, ${response.reasonPhrase}');
      }
    } catch (e) {
      log('Exception: $e');
    }
  }
}
