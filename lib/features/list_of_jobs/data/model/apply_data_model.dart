import 'dart:io';

import 'package:mega_trust_project/features/list_of_jobs/domain/entities/job_entities.dart';


class ApplyModel extends ApplyData{



  ApplyModel({required int expectedSalary, required int currentSalary, required File file, required int jobId}) :
        super(expectedSalary: expectedSalary, currentSalary: currentSalary, file: file, jobId: jobId);


  // String expectedSalary;
  // int id;
  // String currentSalary;
  // File? file;
  //



 



}