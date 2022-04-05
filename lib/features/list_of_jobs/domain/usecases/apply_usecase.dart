

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mega_trust_project/core/error/failures.dart';
import 'package:mega_trust_project/core/usecase/usecase.dart';
import 'package:mega_trust_project/features/list_of_jobs/domain/entities/job_entities.dart';
import 'package:mega_trust_project/features/list_of_jobs/domain/repository/job_rep.dart';

@injectable
class ApplyJob extends UseCase<String,ApplyData > {
  final JobDataRepository _jobDataRepository;
  ApplyJob(this._jobDataRepository);
  @override
  Future<Either<Failure, String>> call(ApplyData params) async {
    return await _jobDataRepository.applyJob( params);
  }

}