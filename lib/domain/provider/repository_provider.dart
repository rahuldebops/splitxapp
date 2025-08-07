import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:splitxapp/data/auth/auth_repo.dart';
import 'package:splitxapp/data/auth/auth_repo_impl.dart';
import 'package:splitxapp/data/groups/group_repo.dart';
import 'package:splitxapp/data/groups/group_repo_impl.dart';
import 'package:splitxapp/domain/provider/api_client_provider.dart';

final authRepo = Provider<AuthRepo>(
  (ref) => AuthRepoImpl(ref.read(apiClientProvider)),
);

final groupRepo = Provider<GroupRepo>(
  (ref) => GroupRepoImpl(ref.read(apiClientProvider)),
);