import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mega_trust_project/di/injectable.dart';
import 'package:mega_trust_project/features/list_of_jobs/domain/entities/job_entities.dart';
import 'package:mega_trust_project/features/list_of_jobs/presentation/bloc/apply_bloc/apply_cubit.dart';
import 'package:mega_trust_project/features/list_of_jobs/presentation/bloc/apply_bloc/apply_states.dart';

class JobDetails extends StatelessWidget {
  final JobData jobData;

   JobDetails({required this.jobData, Key? key});


  @override
  Widget build(BuildContext context) {
     DateTime currentTime = DateTime.parse(jobData.publishDate.toString());

    return BlocProvider<ApplyCubit>(
        create: (context) => getIt<ApplyCubit>(),

        child: Builder(

          builder: (BuildContext context) {

            return Scaffold(
                appBar: AppBar(
                 foregroundColor: Colors.deepOrange,
                  elevation: 0.0,
                  backgroundColor:  Color(0xFFF2F3F5),
                  title: Text('Job Details', style:  TextStyle(color: Colors.deepOrange),),
                  centerTitle: true,
                ),
                body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          SizedBox(height: 25,),
                          Center(
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF2F3F5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const CircleAvatar(
                                backgroundImage: NetworkImage(
                                    'https://99designs-blog.imgix.net/blog/wp-content/uploads/2017/05/attachment_83218186-e1494006802765.png?auto=format&q=60&fit=max&w=930'),
                                radius: 5,
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
                            children:  [
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
                                style:  TextStyle(
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
                            margin: EdgeInsets.only(left: 10, right: 10, top: 10 ),
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
                                    decoration: const BoxDecoration(
                                    ),
                                    child: TabBarView(children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF2F3F5),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child:  Center(
                                          child: Text( '${jobData.jobDescription}',
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF2F3F5),
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                          BlocConsumer<ApplyCubit, ApplyState>(
                            listener: (context, state) {},
                            buildWhen: (_, __) {
                              return context.read<ApplyCubit>().jobId ==
                                  jobData.id;
                            },
                            builder: (context, state) {
                              return state.map(
                                  initial: (_) {
                                    return ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.deepOrange,
                                            fixedSize: const Size(200, 50),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(50))),

                                        onPressed: () async {
                                          await BlocProvider.of<ApplyCubit>(
                                                  context)
                                              .applyJob(jobId: jobData.id);
                                        },

                                        child: const Text('Apply Now',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),));
                                  },
                                  loading: (_) =>
                                      const CircularProgressIndicator(),
                                  success: (_) {
                                    jobData.isApplied = true;
                                    return ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.green,
                                          fixedSize: const Size(200, 50),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(50))),
                                      onPressed: () {},
                                      label: const Text('Applied'),
                                      icon: const Icon(Icons.check_outlined),
                                    );
                                  },
                                  error: (error) => Text(error.toString()));
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    )
                  ],
                )));
          },
        ));
  }
}
