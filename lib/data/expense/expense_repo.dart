import 'package:dartz/dartz.dart';
import 'package:splitxapp/core/exception.dart';
import 'package:splitxapp/data/expense/models/expense_create_request_model.dart';
import 'package:splitxapp/data/expense/models/expense_create_response_model.dart';
import 'package:splitxapp/data/expense/models/expense_details_response_model.dart';
import 'package:splitxapp/data/expense/models/expense_list_response_model.dart';
import 'package:splitxapp/data/expense/models/expense_update_request_model.dart';
import 'package:splitxapp/data/expense/models/expense_update_response_model.dart';
import 'package:splitxapp/models/api_query.dart';

abstract class ExpenseRepo {
  Future<Either<ApiException, ExpenseListResponseModel>> getExpensesByGroup(
    String groupId, [
    ApiQuery? query,
  ]);
  
  Future<Either<ApiException, ExpenseDetailsResponseModel>> getExpenseDetails(
    String expenseId,
  );
  
  Future<Either<ApiException, ExpenseCreateResponseModel>> createExpense(
    ExpenseCreateRequestModel request,
  );
  
  Future<Either<ApiException, ExpenseUpdateResponseModel>> updateExpense(
    String expenseId,
    ExpenseUpdateRequestModel request,
  );
}
