import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wally2/features/wallet/domain/repositories/wallet_repository.dart';
import 'package:wally2/features/wallet/presentation/business_logic/wallet_event.dart';
import 'package:wally2/features/wallet/presentation/business_logic/wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc({required this.walletRepository})
      : super(const WalletInitialState()) {
    on<WalletInitialEvent>(_onInitial);
    on<GetWalletEvent>(_getWallet);
    on<UpdateWalletEvent>(_updateWallet);
  }

  final WalletRepository walletRepository;

  Future<void> _onInitial(
    WalletInitialEvent event,
    Emitter<WalletState> emit,
  ) async {
    emit(const WalletInitialState());
  }

  Future<void> _getWallet(
    GetWalletEvent event,
    Emitter<WalletState> emit,
  ) async {
    emit(const WalletLoadingState());
    try {
      final wallet = await walletRepository.getWalletById(event.id);
      emit(GetWalletSuccessState(wallet: wallet));
    } catch (e) {
      emit(const GetWalletFailedState());
    }
  }

  Future<void> _updateWallet(
    UpdateWalletEvent event,
    Emitter<WalletState> emit,
  ) async {
    emit(const WalletLoadingState());
    try {
      await walletRepository.updateWallet(
        event.id,
        event.balance,
      );
      emit(const UpdateWalletSuccessState());
    } catch (e) {
      emit(const UpdateWalletFailedState());
    }
  }
}
