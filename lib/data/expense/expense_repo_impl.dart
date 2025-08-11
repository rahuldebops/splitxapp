// data/expenses/expense_repo_impl.dart
import 'package:dartz/dartz.dart';
import 'package:splitxapp/core/api_client.dart';
import 'package:splitxapp/core/constants.dart';
import 'package:splitxapp/core/endpoints.dart';
import 'package:splitxapp/core/exception.dart';
import 'package:splitxapp/data/expense/expense_repo.dart';
import 'package:splitxapp/data/expense/models/expense_list_response_model.dart';
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
      final url =
          "${AppConstants.baseUrl}${Endpoints.expenseEndpoint}/group/$groupId";
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
}
