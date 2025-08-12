
import 'package:dartz/dartz.dart';
import 'package:splitxapp/core/exception.dart';
import 'package:splitxapp/data/groups/models/group_list_response_model.dart';
import 'package:splitxapp/data/groups/models/group_member_fetch_response_model.dart';
import 'package:splitxapp/models/api_query.dart';

// data/groups/group_repo.dart (Add this method)
abstract class GroupRepo {
  Future<Either<ApiException, GroupListResponseModel>> getGroups([ApiQuery? query]);
  Future<Either<ApiException, GroupMemberFetchResponseModel>> getGroupMembers(String groupId);
}

