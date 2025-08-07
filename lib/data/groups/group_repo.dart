
import 'package:dartz/dartz.dart';
import 'package:splitxapp/core/exception.dart';
import 'package:splitxapp/data/groups/models/group_list_response_model.dart';

abstract class GroupRepo {
  Future<Either<ApiException, GroupListResponseModel>> getGroups();
}
