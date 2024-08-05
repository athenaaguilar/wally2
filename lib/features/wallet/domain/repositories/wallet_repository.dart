import 'package:wally2/features/wallet/data/models/wallet_model.dart';

abstract class WalletRepository {
  Future<WalletModel> getWalletById(int id);
  Future<void> updateWallet(int id, int balance);
}
