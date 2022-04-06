import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mega_trust_project/core/const/constant.dart';
import '../../../../di/injectable.dart';
import '../../domain/entities/job_entities.dart';
import '../bloc/apply_bloc/apply_cubit.dart';
import '../bloc/apply_bloc/apply_states.dart';

class JobApply extends StatelessWidget {
  JobApply({
    Key? key,
    required this.jobData,
  }) : super(key: key);
  final JobData jobData;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   AnimationController? _controller;


  var expectedSalary = TextEditingController();
  var currentSalary = TextEditingController();
  File? file;
  bool? isDone=true;

  Future<File?> getFile() async {
    //
    // FilePickerResult? result = await FilePicker.platform.pickFiles();
    //
    // if (result != null) {
    //   String? file = result.files.single.path;
    // } else {
    //   // User canceled the picker
    // }
    // return null;
    var result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null && result.files.single.path != null) {
      //if there is selected file
      String filePath = result.files.single.path!;
      file = File(filePath);
      return file;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {

    return BlocProvider<ApplyCubit>(
      create: (context) => getIt<ApplyCubit>(),
      child: Builder(builder: (BuildContext context) {
        return Scaffold(
            appBar: AppBar(
              foregroundColor: Colors.deepOrange,
              elevation: 0.0,
              backgroundColor: const Color(0xFFF2F3F5),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Column(children: [
                Container(
                child: Lottie.network(
                'https://assets9.lottiefiles.com/packages/lf20_ax5yuc0o.json',
                  fit: BoxFit.cover,
                  controller: _controller,

                ),
              ),
                  const SizedBox(
                    height: 25,
                  ),

                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (String? value) {
                              if (value != null &&
                                  int.tryParse(value) != null) {
                                return null;
                              }
                              return " not integer";
                            },
                            controller: currentSalary,
                            decoration: const InputDecoration(
                              labelText: 'current Salary',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          TextFormField(
                            validator: (String? value) {
                              if (value != null &&
                                  int.tryParse(value) != null) {
                                return null;
                              }
                              return " not integer";
                            },
                            controller: expectedSalary,
                            decoration: const InputDecoration(
                              labelText: 'Expected Salary',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          Container(

                            decoration: BoxDecoration(

                                shape: BoxShape.circle, color: Colors.deepOrange, ),
                            child: IconButton(
                              icon: Icon(Icons.arrow_upward_sharp, size: 25,color: Colors.white,),

                                onPressed: () {
                                  getFile();
                                },
                                ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Upload CV', style: TextStyle(
                            letterSpacing: 1.2,
                            fontSize: 15,
                          ),),
                          SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                  BlocConsumer<ApplyCubit, ApplyState>(
                    listener: (context, state) {},
                    buildWhen: (_, __) {
                      return context.read<ApplyCubit>().jobId == jobData.id;
                    },
                    builder: (context, state) {
                      return state.map(
                          initial: (_) {
                            return OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    primary: Colors.deepOrange,
                                    fixedSize: const Size(200, 50),
                                    shape: StadiumBorder(),
                                side: BorderSide(width: 2, color: Colors.deepOrange)),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    if (file != null) {
                                      await BlocProvider.of<ApplyCubit>(context)
                                          .applyJob(
                                        currentSalary:
                                            int.parse(currentSalary.text),
                                        file: file!,
                                        expectedSalary:
                                            int.parse(expectedSalary.text),
                                        jobId: jobData.id,
                                      );
                                    } else {
                                      print('file not valid');
                                    }
                                  } else {
                                    print('not valid');
                                  }
                                },
                                child: const Text(
                                  'SUBMIT',
                                  style: TextStyle(
                                    fontSize: 17,
                                    letterSpacing: 1.5,
                                    fontWeight: FontWeight.w500,

                                  ),
                                ));
                          },
                          loading: (_) => buildCustomButton(isDone=false),
                          success: (_) {
                            jobData.isApplied = true;
                            return buildCustomButton(isDone=true);
                              

                          },
                          error: (error) => Text(error.toString()),
                          );},
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                ]),
              ),
            ));
      }),
    );
  }
}


// class Animation extends StatefulWidget {
//   const Animation({Key? key, required this.controller, }) : super(key: key);
//   final AnimationController controller;
//
//   @override
//   State<Animation> createState() => _AnimationState(this.controller);
// }
//
// class _AnimationState extends State<Animation> {
//   final AnimationController controller;
//
//   _AnimationState(this.controller);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Lottie.asset(
//           'assets/animation/upload_animation.json',
//           fit: BoxFit.cover,
//           controller: controller,
//           onLoaded:(composition) {
//             setState(() {
//               controller.duration= composition.duration;
//             });
//
//           },
//       ),
//     );
//   }
// }

Widget buildCustomButton(bool isDone){
  final color = isDone?Colors.green: Colors.deepOrange;
  return Container(
    decoration: BoxDecoration(shape: BoxShape.circle, color: color) ,
    child: isDone?Icon(Icons.done, size: 52,color: Colors.white,)
        :CircularProgressIndicator(color: Colors.white,),
  );
}

