import 'dart:io';

class JobData{
  int id;
  String title;
  String publishDate;
  String jobDescription;
  bool isApplied = false;


  JobData({required this.title, required this.jobDescription, required this.publishDate, required this.id});

  get props =>[title, jobDescription, publishDate];

}
 class ApplyData{
   int expectedSalary;
   int currentSalary;
   File file;
   int jobId;

   ApplyData({required this.expectedSalary, required this.currentSalary, required this.file, required this.jobId});
 }



