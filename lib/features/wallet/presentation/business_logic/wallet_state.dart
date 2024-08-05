import 'package:wally2/features/wallet/domain/entities/wallet_entity.dart';

abstract class WalletState {
  const WalletState();
}

class WalletInitialState extends WalletState {
  const WalletInitialState();
}

class WalletLoadingState extends WalletState {
  const WalletLoadingState();
}

class GetWalletSuccessState extends WalletState {
  const GetWalletSuccessState({required this.wallet});

  final WalletEntity wallet;
}

class GetWalletFailedState extends WalletState {
  const GetWalletFailedState();
}

class UpdateWalletSuccessState extends WalletState {
  const UpdateWalletSuccessState();
}

class UpdateWalletFailedState extends WalletState {
  const UpdateWalletFailedState();
}
