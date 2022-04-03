import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mega_trust_project/features/list_of_jobs/domain/entities/job_entities.dart';
import 'package:mega_trust_project/features/list_of_jobs/presentation/bloc/apply_bloc/apply_cubit.dart';
import 'package:mega_trust_project/features/list_of_jobs/presentation/bloc/apply_bloc/apply_states.dart';
import 'package:mega_trust_project/features/list_of_jobs/presentation/screens/job_details_screen.dart';

class JobListBuilder extends StatelessWidget {
  final JobData job;

  JobListBuilder({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime currentTime = DateTime.parse(job.publishDate.toString());

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      // SizedBox(
      // width: double.infinity,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F3F5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://99designs-blog.imgix.net/blog/wp-content/uploads/2017/05/attachment_83218186-e1494006802765.png?auto=format&q=60&fit=max&w=930'),
                        radius: 8,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      'We are looking for a  ${job.title.toString()} '
                      ' to retouch \n our product',
                      textAlign: TextAlign.justify,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 40,
                  width: 80,
                  decoration: BoxDecoration(
                    color:Color(0xFFF2F3F5) ,
                    borderRadius: BorderRadius.circular(10),
                  ),

                  child: TextButton(onPressed: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context)=> JobDetails(jobData: job)));
                  }, child: Text('Open')),
                ),
                SizedBox(height: 15,),
                Row(

                  children: [

                    const Icon(
                      Icons.calendar_today,
                      size: 20,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      DateFormat.yMd().format(currentTime),
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Icon(
                      Icons.work_outline,
                      size: 20,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      'Fulltime, office',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Icon(
                      Icons.location_on_outlined,
                      size: 20,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      'Egypt',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),



                //               BlocConsumer<ApplyCubit, ApplyState>(
                //                 listener: (context, state) {},
                //                 buildWhen: (_, __) {
                //                   return context.read<ApplyCubit>().jobId == job.id;
                //                 },
                //                 builder: (context, state) {
                //
                //                   return state.map(
                //                       initial: (_) {
                //                         return TextButton(
                //                             onPressed: () async {
                //                               await BlocProvider.of<ApplyCubit>(context)
                //                                   .applyJob(jobId: job.id);
                //                             },
                //                             child: const Text('Apply Now'));
                //                       },
                //                       loading: (_) => const CircularProgressIndicator(),
                //                       success: (_) {
                //                         job.isApplied = true;
                //                         return const Text("Applied");
                //                       },
                //                       error: (error) => Text(error.toString()));
                //                 },
                //               ),
                //             ],
                //
                //           ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}