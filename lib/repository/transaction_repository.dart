import '../models/transaction.dart';

abstract class TransactionRepository {
  Future<List<Transaction>> getAllTransactions();
  Future<List<Transaction>> getTransactionsByCategory(int categoryId);  
  Future<List<Transaction>> getTransactionsByCategoryBetweenDates(int categoryId, DateTime? startDate, DateTime? endDate);
  Future<Transaction?> getTransaction(int id);
  Future<int> insertTransaction(Transaction transaction);
  Future<int> updateTransaction(int id, Transaction transaction);
  Future<int> deleteTransaction(int id);
}