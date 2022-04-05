import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mega_trust_project/core/const/constant.dart';
import 'package:mega_trust_project/core/error/failures.dart';
import 'package:mega_trust_project/features/Auth/domain/local_data_source/local_data_source.dart';
import 'package:mega_trust_project/features/list_of_jobs/domain/entities/job_entities.dart';
import 'package:mega_trust_project/features/list_of_jobs/domain/repository/job_rep.dart';

import '../model/job_data_model.dart';
import '../model/job_model.dart';
import '../services/api_service.dart';

@Injectable(as: JobDataRepository)
class JobDataRepositoryImpl implements JobDataRepository {
  final ApiService apiService;

  JobDataRepositoryImpl(this.apiService, this._localDataSource);

  final LocalDataSource _localDataSource;

  @override
  Future<Either<Failure, List<JobData>>> getJob() async {
    try {
      final String? token = await _localDataSource.getToken();
      final JobModel messageresult = await apiService.getJobs(token: token!);
      print('message is ' + messageresult.toString());
      final List<JobDataModel> result = messageresult.jobData;
      print('result is: $result');
      final List<JobData> jobs =
          result.map((jobDataModel) => jobDataModel.mapper()).toList();
      print('jobs is ${jobs.length}');
      return Right(jobs);
    } catch (e) {
      print('error $e');
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> applyJob(ApplyData applyData) async {
    try {
      final String? token = await _localDataSource.getToken();
      final int? userId = await _localDataSource.getUserId();
      final String response = await apiService.applyJob(
        userId: userId!,
        jobId: applyData.jobId,
        token: token!,
        file: applyData.file,
        expectedSalary: applyData.expectedSalary,
        currentSalary: applyData.currentSalary,
      );

      return right(response);
    } catch (e) {
      print('error $e');
      return left(ServerFailure(e.toString()));
    }
  }
}
