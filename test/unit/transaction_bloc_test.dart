import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wally2/features/transactions/data/models/transaction_model.dart';
import 'package:wally2/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:wally2/features/transactions/presentation/business_logic/transactions_bloc.dart';
import 'package:wally2/features/transactions/presentation/business_logic/transactions_event.dart';
import 'package:wally2/features/transactions/presentation/business_logic/transactions_state.dart';

class MockTransactionRepository extends Mock implements TransactionRepository {}

void main() {
  late TransactionRepository transactionRepository;
  late TransactionBloc transactionBloc;

  setUp(() {
    transactionRepository = MockTransactionRepository();
    transactionBloc = TransactionBloc(
      transactionRepository: transactionRepository,
    );
  });

  tearDown(() {
    transactionBloc.close();
  });

  test('TransactionInitialEvent results to TransactionInitialState', () {
    transactionBloc.add(const TransactionInitialEvent());

    expectLater(
      transactionBloc.stream,
      emitsInOrder(
        <TransactionState>[
          const TransactionInitialState(),
        ],
      ),
    );
  });

  group('GetTransactionHistoryEvent', () {
    const int id = 1;
    const event = GetTransactionHistoryEvent(id);
    final transactions = [
      TransactionModel(
        id: 1,
        amount: 500,
        transactionType: 'Send Money',
        createdAt: DateTime.now(),
      )
    ];

    test(
        'GetTransactionHistoryEvent results to GetTransactionHistorySuccessState',
        () async {
      when(() => transactionRepository.getTransactionHistory(id))
          .thenAnswer((_) async => transactions);

      expectLater(
        transactionBloc.stream,
        emitsInOrder(
          <TransactionState>[
            const TransactionLoadingState(),
            GetTransactionHistorySuccessState(transactionHistory: transactions),
          ],
        ),
      );

      transactionBloc.add(event);
    });

    test(
        'GetTransactionHistoryEvent results to GetTransactionHistoryFailedState',
        () {
      when(() => transactionRepository.getTransactionHistory(id))
          .thenThrow(Exception('Failed to get transaction history'));

      expectLater(
        transactionBloc.stream,
        emitsInOrder(
          <TransactionState>[
            const TransactionLoadingState(),
            const GetTransactionHistoryFailedState(),
          ],
        ),
      );

      transactionBloc.add(event);
    });
  });

  group('AddTransactionEvent', () {
    const int amount = 200;
    const String transactionType = 'Send Money';
    const event = AddTransactionEvent(amount, transactionType);

    test('AddTransactionEvent results to AddTransactionSuccessState', () async {
      when(() => transactionRepository.addTransaction(amount, transactionType))
          .thenAnswer((_) async {});

      expectLater(
        transactionBloc.stream,
        emitsInOrder(
          <TransactionState>[
            const TransactionLoadingState(),
            const AddTransactionSuccessState(),
          ],
        ),
      );

      transactionBloc.add(event);
    });

    test('AddTransactionEvent results to AddTransactionFailedState', () {
      when(() => transactionRepository.addTransaction(amount, transactionType))
          .thenThrow(Exception('Failed to add transaction'));

      expectLater(
        transactionBloc.stream,
        emitsInOrder(
          <TransactionState>[
            const TransactionLoadingState(),
            const AddTransactionFailedState(),
          ],
        ),
      );

      transactionBloc.add(event);
    });
  });
}
