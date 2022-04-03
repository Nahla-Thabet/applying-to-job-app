import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mega_trust_project/core/const/icons.dart';
import 'package:mega_trust_project/features/Auth/presentation/bloc/register/register_cubit.dart';
import 'package:mega_trust_project/features/Auth/presentation/screens/LoginScreen.dart';
import 'package:mega_trust_project/features/Auth/presentation/widgets/curved_widget.dart';
import 'package:mega_trust_project/features/Auth/presentation/widgets/widgets.dart';
import 'package:mega_trust_project/features/list_of_jobs/presentation/screens/jobs_list_screen.dart';
import '../../../../core/const/icons.dart';
import '../../../../di/injectable.dart';
import '../bloc/register/register_states.dart';

class RegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var passwordConfirmationController = TextEditingController();
  var passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  RegisterScreen({Key? key}) : super(key: key);

   bool isSecure = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => getIt<RegisterCubit>(),
        child: Builder(builder: (BuildContext context) {
          var cubit = RegisterCubit.get(context) ;
          return BlocListener<RegisterCubit, RegisterState>(
            listener: (BuildContext context, state) {
              state.map(
                  initial: (initial) {},
                  loading: (_) {},
                  success: (_) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => JobsListScreen()));
                  },
                  error: (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('error  in Registeration')));
                  });
            },


            child:Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
              ),
              body:SingleChildScrollView(
              child:Column(
                children: [
              CurvedWidget(
              child: Container(
              // child: Image.asset('job image.jpg'),
              width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color:  Colors.deepOrange,
                ),
              ),
            ),
            Text(
              'Sign Up',
              style: Theme.of(context).textTheme.headline3?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),),
                 Container(
                   margin: EdgeInsets.only(left: 15, right: 15),
                  child: SingleChildScrollView(
                    child: Form(

                      key: _formKey,

                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          defaultFormField(
                            controller: nameController,
                            keyboardType: TextInputType.text,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Name can not be empty';
                              }
                              return null;
                            },
                            label: 'Full Name',
                            prefixIcon: Icons.account_circle_outlined,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                              controller: emailController,
                              keyboardType: TextInputType.text,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Email can not be empty';
                                }
                                return null;
                              },
                              prefixIcon: emailIcon,
                              label: 'Email'),
                          const SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                              controller: passwordController,
                              keyboardType: TextInputType.text,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Password can not be empty';
                                }
                                return null;
                              },
                              prefixIcon: lockPassword,

                              label: 'Password'),
                          const SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                              controller: passwordConfirmationController,
                              keyboardType: TextInputType.text,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Password can not be empty';
                                }
                                return null;
                              },
                              prefixIcon: lockPassword,
                              label: 'Confirmation Password'),
                          const SizedBox(
                            height: 25,
                          ),
                          customButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  BlocProvider.of<RegisterCubit>(context)
                                      .register(
                                          name: nameController.text.trim(),
                                          password: passwordController.text,
                                          confirmPassword:
                                              passwordConfirmationController
                                                  .text,
                                          email: emailController.text.trim());
                                }
                              },
                              text: "REGISTER"),
                          SizedBox(
                            height: 15,
                          ),
                          TextButton(onPressed: ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen())),
                              child: const Text('Already have an account? Login',
                              style: TextStyle(
                                fontSize: 15,
                              ),)
                          ),
                          BlocBuilder<RegisterCubit, RegisterState>(
                              builder: (BuildContext context, state) {
                            return state.maybeMap(
                              loading: (_)=> const CircularProgressIndicator(),
                              orElse: () => Container(),
                              error: (errorState)=>Text(errorState.errorMessage)

                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),

            ]
              ),
            ),

            ),
          );
        }));
  }
}
