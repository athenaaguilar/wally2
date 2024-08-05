import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wally2/features/wallet/data/models/wallet_model.dart';
import 'package:wally2/features/wallet/domain/repositories/wallet_repository.dart';
import 'package:wally2/features/wallet/presentation/business_logic/wallet_bloc.dart';
import 'package:wally2/features/wallet/presentation/business_logic/wallet_event.dart';
import 'package:wally2/features/wallet/presentation/business_logic/wallet_state.dart';

class MockWalletRepository extends Mock implements WalletRepository {}

void main() {
  late WalletRepository walletRepository;
  late WalletBloc walletBloc;

  setUp(() {
    walletRepository = MockWalletRepository();
    walletBloc = WalletBloc(walletRepository: walletRepository);
  });

  tearDown(() {
    walletBloc.close();
  });

  test('WalletInitialEvent results to WalletInitialState', () {
    walletBloc.add(const WalletInitialEvent());

    expectLater(
      walletBloc.stream,
      emitsInOrder(
        <WalletState>[
          const WalletInitialState(),
        ],
      ),
    );
  });

  group('GetWalletEvent', () {
    const int id = 1;
    const event = GetWalletEvent(id);
    final wallet = WalletModel(id: id, balance: 500);

    test('GetWalletEvent results to GetWalletSuccessState', () async {
      when(() => walletRepository.getWalletById(id))
          .thenAnswer((_) async => wallet);

      expectLater(
        walletBloc.stream,
        emitsInOrder(
          <WalletState>[
            const WalletLoadingState(),
            GetWalletSuccessState(wallet: wallet),
          ],
        ),
      );

      walletBloc.add(event);
    });

    test('GetWalletEvent results to GetWalletFailedState', () {
      when(() => walletRepository.getWalletById(id))
          .thenThrow(Exception('Failed to fetch wallet'));

      expectLater(
        walletBloc.stream,
        emitsInOrder(
          <WalletState>[
            const WalletLoadingState(),
            const GetWalletFailedState(),
          ],
        ),
      );

      walletBloc.add(event);
    });
  });

  group('UpdateWalletEvent', () {
    const int id = 1;
    const int balance = 500;
    const event = UpdateWalletEvent(id, balance);

    test('UpdateWalletEvent results to UpdateWalletSuccessState', () async {
      when(() => walletRepository.updateWallet(id, balance))
          .thenAnswer((_) async {});

      expectLater(
        walletBloc.stream,
        emitsInOrder(
          <WalletState>[
            const WalletLoadingState(),
            const UpdateWalletSuccessState(),
          ],
        ),
      );

      walletBloc.add(event);
    });

    test('UpdateWalletEvent results to UpdateWalletFailedState', () {
      when(() => walletRepository.updateWallet(id, balance))
          .thenThrow(Exception('Failed to update wallet'));

      expectLater(
        walletBloc.stream,
        emitsInOrder(
          <WalletState>[
            const WalletLoadingState(),
            const UpdateWalletFailedState(),
          ],
        ),
      );

      walletBloc.add(event);
    });
  });
}
