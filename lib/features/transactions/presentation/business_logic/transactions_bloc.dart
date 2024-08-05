import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wally2/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:wally2/features/transactions/presentation/business_logic/transactions_event.dart';
import 'package:wally2/features/transactions/presentation/business_logic/transactions_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc({required this.transactionRepository})
      : super(const TransactionInitialState()) {
    on<TransactionInitialEvent>(_onInitial);
    on<GetTransactionHistoryEvent>(_getTransactionHistory);
    on<AddTransactionEvent>(_addTransaction);
  }

  final TransactionRepository transactionRepository;

  Future<void> _onInitial(
    TransactionInitialEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(const TransactionInitialState());
  }

  Future<void> _getTransactionHistory(
    GetTransactionHistoryEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(const TransactionLoadingState());
    try {
      final transactionHistory =
          await transactionRepository.getTransactionHistory(event.walletId);
      emit(GetTransactionHistorySuccessState(
        transactionHistory: transactionHistory,
      ));
    } catch (e) {
      emit(const GetTransactionHistoryFailedState());
    }
  }

  Future<void> _addTransaction(
    AddTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(const TransactionLoadingState());
    try {
      await transactionRepository.addTransaction(
        event.amount,
        event.transactionType,
      );
      emit(const AddTransactionSuccessState());
    } catch (e) {
      emit(const AddTransactionFailedState());
    }
  }
}
