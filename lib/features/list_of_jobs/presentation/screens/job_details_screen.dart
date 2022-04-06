import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mega_trust_project/features/list_of_jobs/domain/entities/job_entities.dart';
import 'package:mega_trust_project/features/list_of_jobs/presentation/screens/job_apply.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../core/const/constant.dart';

class JobDetails extends StatelessWidget {
  final JobData jobData;

  // final ApplyData applyData;

  JobDetails({
    required this.jobData,
    Key? key,
  });

  @override
  Widget build(BuildContext context) {
    DateTime currentTime = DateTime.parse(jobData.publishDate.toString());

    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.deepOrange,
          elevation: 0.0,
          backgroundColor: Color(0xFFF2F3F5),
          title: const Text(
            'Job Details',
            style: TextStyle(color: Colors.deepOrange),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F3F5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child:  Hero(
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(imageUrl),
                          radius: 5,
                        ),
                        tag: jobData,
                      ),
                    ),
                  ),
                  Text(
                    jobData.title,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'East Falmouth, USA',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 20,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        DateFormat.yMd().format(currentTime),
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(width: 14),
                      Icon(
                        Icons.work_outline,
                        size: 20,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Fulltime, office',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(width: 14),
                      Icon(
                        Icons.location_on_outlined,
                        size: 20,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Egypt',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F3F5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: DefaultTabController(
                      length: 2, // length of tabs
                      initialIndex: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const TabBar(
                              labelColor: Colors.black,
                              unselectedLabelColor: Colors.grey,
                              tabs: [
                                Tab(text: 'Description'),
                                Tab(text: 'Company'),
                              ],
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.all(20),
                              height: 200, //height of TabBarView
                              decoration: const BoxDecoration(),
                              child: TabBarView(children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF2F3F5),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text('${jobData.jobDescription}',
                                        style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF2F3F5),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child: Text('Display Tab 2',
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ]))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        primary: Colors.deepOrange,
                        fixedSize: const Size(200, 50),
                        side: BorderSide(width: 2, color: Colors.deepOrange),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                    onPressed: () {
                      Navigator.push(
                          context,
                        PageTransition(child:JobApply(jobData: jobData), type: PageTransitionType.bottomToTop)
                          );
                    },
                    child: const Text(
                      'APPLY NOW',
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            )
          ],
        )));
  }
}
