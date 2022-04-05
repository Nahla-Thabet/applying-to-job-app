
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mega_trust_project/core/error/failures.dart';

import '../entities/job_entities.dart';

abstract class JobDataRepository {
  Future<Either<Failure,List<JobData>>> getJob();

  Future<Either<Failure,String>> applyJob(ApplyData applyData) ;
  }
