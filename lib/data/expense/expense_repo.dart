// data/expenses/expense_repo.dart
import 'package:dartz/dartz.dart';
import 'package:splitxapp/core/exception.dart';
import 'package:splitxapp/data/expense/models/expense_list_response_model.dart';
import 'package:splitxapp/models/api_query.dart';

abstract class ExpenseRepo {
  Future<Either<ApiException, ExpenseListResponseModel>> getExpensesByGroup(
    String groupId, [
    ApiQuery? query,
  ]);
}
