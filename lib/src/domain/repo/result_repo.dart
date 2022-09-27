import '../../api/api/api.dart';
import '../../core/either.dart';
import '../entities/result.dart';

class ResultRepo {
  ResultRepo({required this.api});

  final Api api;

  Future<Either<void>> uploadResult({required Result result}) async {
    final eitherResult = await api.uploadResult(result: result);
    return eitherResult;
  }
}
