import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mega_trust_project/features/list_of_jobs/domain/entities/job_entities.dart';
import 'package:mega_trust_project/features/list_of_jobs/domain/usecases/apply_usecase.dart';

import 'apply_states.dart';

@injectable
class ApplyCubit extends Cubit<ApplyState> {
  final ApplyJob _applyJob;
  int jobId = -1;

  ApplyCubit(this._applyJob) : super(const ApplyState.initial());

  Future<void> applyJob({
    required int expectedSalary,
    required int currentSalary,
    required File file,
    required int jobId,
  }) async {
    this.jobId = jobId;
    emit(const ApplyState.loading());
    final applyData = ApplyData(
      expectedSalary: expectedSalary,
      currentSalary: currentSalary,
      file: file,
      jobId: jobId,);

    final result = await _applyJob(applyData);
    result.fold(
          (error) => emit(const ApplyState.error()),
          (success) => emit(const ApplyState.success()),
    );
  }
}
