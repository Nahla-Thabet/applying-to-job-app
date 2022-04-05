import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mega_trust_project/core/const/icons.dart';
import 'package:mega_trust_project/features/Auth/presentation/widgets/widgets.dart';
import 'package:mega_trust_project/features/Auth/presentation/screens/register.dart';
import 'package:mega_trust_project/features/list_of_jobs/presentation/screens/jobs_list_screen.dart';
import '../../../../core/const/icons.dart';
import '../../../../../di/injectable.dart';
import '../bloc/login/login_cubit.dart';
import '../bloc/login/login_states.dart';
import '../widgets/curved_widget.dart';



class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // emailController.text = "nahla@gmail.com";
    // passwordController.text = "123456";
    return BlocProvider(
        create: (BuildContext context) => getIt<LoginCubit>(),
        child: Builder(builder: (BuildContext context) {
          return BlocListener<LoginCubit, LoginState>(
            listener: (BuildContext context, state) {
              state.map(
                  initial: (initial) {},
                  loading: (_) {},
                  success: (_) {
                    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) =>
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => JobsListScreen())));
                  },
                  error: (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('error  in Login')));
                  });
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(

                elevation: 0,
              ),
              body:SingleChildScrollView (
              child:
              Column(
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
                      'Login',
                      style: Theme.of(context).textTheme.headline3?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange,
                      ),),


                    SingleChildScrollView(
                       // scrollDirection: Axis.vertical,
                     child: Container(
                       margin: EdgeInsets.all(10),
                     child :Form(
                      key: _formKey,
                      child: Column(
                        children: [

                          const SizedBox(
                            height: 10,
                          ),
                          defaultFormField(
                            // initValue:"nahla@gmail.com",
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
                            // initValue: "123456",
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
                            height: 25,
                          ),
                          customButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  BlocProvider.of<LoginCubit>(context)
                                      .login(
                                          password: passwordController.text,
                                          email: emailController.text.trim());
                                }
                              },
                              text: "LOGIN"),
                          SizedBox(
                            height: 15,
                          ),
                          TextButton(onPressed: ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RegisterScreen())),
                              child: Text('Don\'t have an account? Rigister',
                              style: TextStyle(fontSize: 16),

                              )),
                          BlocBuilder<LoginCubit, LoginState>(
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
          )
                );
        }));
  }
}
