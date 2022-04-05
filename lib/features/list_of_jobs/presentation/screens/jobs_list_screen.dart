import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mega_trust_project/features/Auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:mega_trust_project/features/Auth/presentation/bloc/auth/auth_states.dart';
import 'package:mega_trust_project/features/Auth/presentation/screens/LoginScreen.dart';
import 'package:mega_trust_project/features/list_of_jobs/domain/entities/job_entities.dart';
import 'package:mega_trust_project/features/list_of_jobs/presentation/bloc/job_cubit.dart';
import 'package:mega_trust_project/features/list_of_jobs/presentation/bloc/job_states.dart';
import 'package:mega_trust_project/features/list_of_jobs/presentation/screens/job_list_items.dart';
import '../../../../di/injectable.dart';
import '../bloc/apply_bloc/apply_cubit.dart';

class JobsListScreen extends StatelessWidget {
  const JobsListScreen({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F5),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor:  Color(0xFFF2F3F5),
        actions: [
          BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                state.maybeWhen(
                    logout: () => Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen())),
                    orElse: () {
                      print(state.toString());
                    });
              },
              child: IconButton(
                  onPressed: () {
                    context.read<AuthCubit>().logout();
                  },
                  icon: const Icon(Icons.logout, color: Colors.deepOrange,)))
        ],

      ),
      body: SingleChildScrollView(
      child:Column(children:  [
        Container(
          margin: EdgeInsets.all(15),
          child: Text('Find \n your dream job',
        style: Theme.of(context).textTheme.headline3?.copyWith(
          fontFamily: 'SecularOne-Regular',
          fontWeight: FontWeight.w700,
        ),
          ),
          ),


        Row(
          children: [
            Expanded(
              flex: 5,
                child: Container(
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                  child: const TextField(
                    maxLines: 1,
                    autofocus: false,
                    style: TextStyle(color: Color(0xff9aafad), fontSize: 20),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                      hintText: 'Search',
                    ),

                  ),
                ),
                ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(right: 10),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(

                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Icon(
                    Icons.drag_indicator,
                    color: Colors.deepOrange,
                    size: 40,
                  ),
                ),
              ),
            ),
            
          ],
        ),

        JobsList(),


      ]),
      )

    );
    // const JobsList());
  }
}

class JobsList extends StatelessWidget {
  const JobsList({Key? key, }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final ApplyData applyData;
    return BlocConsumer<JobCubit, JobStates>(
        listener: (context, state) {},
        builder: (context, state) {
          print("state is nnn : $state");
          if (state is JobInitialStates) {
            context.read<JobCubit>().getJobList();
          }

          if (state is JobSuccessStates) {
            final List<JobData> allJobs = (state).data;

            //   print(allJobs);

            return BlocProvider<ApplyCubit>(
                create: (context) => getIt<ApplyCubit>(),

                child: ListView.builder(
                  shrinkWrap: true,
                    itemCount: allJobs.length,
                    itemBuilder: (BuildContext context, index) {
                      return JobListBuilder(job: allJobs[index], );
                    }));

            //return buildLoadedListWidgets();
          } else {
            print("state is builder : $state");

            return const Center(
              child: const CircularProgressIndicator(),
            );
          }
        });
  }
}
