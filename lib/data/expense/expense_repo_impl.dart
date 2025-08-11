import 'package:dartz/dartz.dart';
import 'package:splitxapp/core/api_client.dart';
import 'package:splitxapp/core/constants.dart';
import 'package:splitxapp/core/endpoints.dart';
import 'package:splitxapp/core/exception.dart';
import 'package:splitxapp/data/expense/expense_repo.dart';
import 'package:splitxapp/data/expense/models/expense_create_request_model.dart';
import 'package:splitxapp/data/expense/models/expense_create_response_model.dart';
import 'package:splitxapp/data/expense/models/expense_details_response_model.dart';
import 'package:splitxapp/data/expense/models/expense_list_response_model.dart';
import 'package:splitxapp/data/expense/models/expense_update_request_model.dart';
import 'package:splitxapp/data/expense/models/expense_update_response_model.dart';
import 'package:splitxapp/models/api_query.dart';
import 'package:splitxapp/utils/logger.dart';

class ExpenseRepoImpl implements ExpenseRepo {
  final ApiClient _apiClient;

  ExpenseRepoImpl(this._apiClient);

  @override
  Future<Either<ApiException, ExpenseListResponseModel>> getExpensesByGroup(
    String groupId, [
    ApiQuery? query,
  ]) async {
    try {
      final url = "${AppConstants.baseUrl}${Endpoints.expenseEndpoint}/group/$groupId";
      final response = await _apiClient.get(
        url,
        queryParameters: query?.toQueryParameters(),
      );
      Logger.write(response.toString());
      return Right(ExpenseListResponseModel.fromJson(response.data!));
    } catch (e, stackTrace) {
      Logger.write('Error: $e\n$stackTrace');
      return Left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, ExpenseDetailsResponseModel>> getExpenseDetails(
    String expenseId,
  ) async {
    try {
      final url = "${AppConstants.baseUrl}${Endpoints.expenseEndpoint}/$expenseId";
      final response = await _apiClient.get(url);
      Logger.write(response.toString());
      return Right(ExpenseDetailsResponseModel.fromJson(response.data!));
    } catch (e, stackTrace) {
      Logger.write('Error: $e\n$stackTrace');
      return Left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, ExpenseCreateResponseModel>> createExpense(
    ExpenseCreateRequestModel request,
  ) async {
    try {
      final url = "${AppConstants.baseUrl}${Endpoints.expenseEndpoint}";
      final response = await _apiClient.post(url, request.toJson());
      Logger.write(response.toString());
      return Right(ExpenseCreateResponseModel.fromJson(response.data!));
    } catch (e, stackTrace) {
      Logger.write('Error: $e\n$stackTrace');
      return Left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, ExpenseUpdateResponseModel>> updateExpense(
    String expenseId,
    ExpenseUpdateRequestModel request,
  ) async {
    try {
      final url = "${AppConstants.baseUrl}${Endpoints.expenseEndpoint}/Edit/$expenseId";
      final response = await _apiClient.post(url, request.toJson());
      Logger.write(response.toString());
      return Right(ExpenseUpdateResponseModel.fromJson(response.data!));
    } catch (e, stackTrace) {
      Logger.write('Error: $e\n$stackTrace');
      return Left(ApiException(e.toString()));
    }
  }
}
