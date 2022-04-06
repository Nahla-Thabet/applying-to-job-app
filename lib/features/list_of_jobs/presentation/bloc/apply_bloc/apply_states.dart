
import 'package:freezed_annotation/freezed_annotation.dart';
part 'apply_states.freezed.dart';

@Freezed()
 class ApplyState with _$ApplyState{
 const factory  ApplyState.initial()= _Initial ;
 const factory  ApplyState.loading()= _Loading ;
 const factory  ApplyState.success()= _Success ;
 const factory  ApplyState.error()= _Error ;
 // const factory  ApplyState.loadingAnimation()= _LoadingAnimation ;

}



