import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:wally2/features/wallet/data/models/wallet_model.dart';
import 'package:wally2/features/wallet/domain/repositories/wallet_repository.dart';

class WalletRepositoryImpl extends WalletRepository {
  @override
  Future<WalletModel> getWalletById(int id) async {
    final Uri url = Uri.https(
      'mockend.com',
      'api/athenaaguilar/wally2/wallet/$id',
    );

    Response response = await http.get(url);
    Map<String, dynamic> json = jsonDecode(response.body);
    WalletModel wallet = WalletModel.fromJson(json);

    return wallet;
  }

  @override
  Future<void> updateWallet(int id, int balance) async {
    final Uri url = Uri.https(
      'mockend.com',
      'api/athenaaguilar/wally2/wallet/$id',
    );

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'balance': 40}),
      );

      if (response.statusCode == 200) {
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
