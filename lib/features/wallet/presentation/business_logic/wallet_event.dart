abstract class WalletEvent {
  const WalletEvent();
}

class WalletInitialEvent extends WalletEvent {
  const WalletInitialEvent();
}

class GetWalletEvent extends WalletEvent {
  const GetWalletEvent(this.id);

  final int id;
}

class UpdateWalletEvent extends WalletEvent {
  const UpdateWalletEvent(this.id, this.balance);

  final int id;
  final int balance;
}
