import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../../di/injectable.dart';
import '../../domain/entities/job_entities.dart';
import '../bloc/apply_bloc/apply_cubit.dart';
import '../bloc/apply_bloc/apply_states.dart';

class JobApply extends StatelessWidget {
  JobApply({
    Key? key, required this.jobData,
  }) : super(key: key);
  final JobData jobData;

 final GlobalKey<FormState> _formKey =GlobalKey<FormState>();

  var expectedSalary = TextEditingController() ;
  var currentSalary = TextEditingController();
    File? file;

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
    if (result != null && result.files.single.path != null ) {
      //if there is selected file
      String filePath = result.files.single.path!;
      file=File(filePath) ;
      return file;
    }
    return null;

  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ApplyCubit>(
        create: (context) => getIt<ApplyCubit>(),
        child: Builder(
        builder: (BuildContext context) {

      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (String? value){
                      if(value != null && int.tryParse(value) != null){
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
                    validator:  (String? value){
                      if(value != null && int.tryParse(value) != null){
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
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepOrange,
                        fixedSize: const Size(200, 50),
                      ),
                      onPressed: () {
                        getFile();
                      },
                      child: const Text(
                        'Upload File',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      )),
                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
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
                                  borderRadius:
                                  BorderRadius.circular(50))),
                          onPressed: () async {
                            if(_formKey.currentState!.validate() ){
                              if(file != null){
                                await BlocProvider.of<ApplyCubit>(
                                    context)
                                    .applyJob(
                                  currentSalary: int.parse(currentSalary.text) ,
                                  file:file!,
                                  expectedSalary: int.parse(expectedSalary.text) ,
                                  jobId: jobData.id,
                                );
                              }else{
                                print('file not valid');
                              }

                            }else{
                              print('not valid');
                            }
                          },
                          child: const Text(
                            'Apply Now',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ));
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
                                borderRadius:
                                BorderRadius.circular(50))),
                        onPressed: () {},
                        label: const Text('Applied'),
                        icon: const Icon(Icons.check_outlined),
                      );
                    },
                    error: (error) => Text(error.toString()));
              },
            ),
          ]),
        ));
  }
    ),
    );
  }
}
