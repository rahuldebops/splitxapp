import 'package:dartz/dartz.dart';
import 'package:splitxapp/core/api_client.dart';
import 'package:splitxapp/core/constants.dart';
import 'package:splitxapp/core/endpoints.dart';
import 'package:splitxapp/core/exception.dart';
import 'package:splitxapp/data/groups/group_repo.dart';
import 'package:splitxapp/data/groups/models/group_list_response_model.dart';
import 'package:splitxapp/data/groups/models/group_member_fetch_response_model.dart';
import 'package:splitxapp/models/api_query.dart';
import 'package:splitxapp/utils/logger.dart';

class GroupRepoImpl implements GroupRepo {
  final ApiClient _apiClient;
  GroupRepoImpl(this._apiClient);

  @override
  Future<Either<ApiException, GroupListResponseModel>> getGroups([
    ApiQuery? query,
  ]) async {
    try {
      final url = "${AppConstants.baseUrl}${Endpoints.groupEndpoint}";

      final response = await _apiClient.get(
        url,
        queryParameters: query?.toQueryParameters(), // Safe call
      );

      Logger.write(response.toString());
      return Right(GroupListResponseModel.fromJson(response.data!));
    } catch (e, stackTrace) {
      Logger.write('Error: $e\n$stackTrace');
      return Left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, GroupMemberFetchResponseModel>> getGroupMembers(String groupId) async {
    try {
      final url = "${AppConstants.baseUrl}${Endpoints.groupEndpoint}/$groupId/members";
      final response = await _apiClient.get(url);
      Logger.write(response.toString());
      return Right(GroupMemberFetchResponseModel.fromJson(response.data!));
    } catch (e, stackTrace) {
      Logger.write('Error: $e\n$stackTrace');
      return Left(ApiException(e.toString()));
    }
  }
}
