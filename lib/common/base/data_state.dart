import 'dart:core';

import 'package:equatable/equatable.dart';

abstract class DataState extends Equatable {}

class StateLoading extends DataState {
  @override
  List<Object> get props => [];
}

class StateError extends DataState {
  StateError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class StateInitial<T> extends DataState {
  StateInitial({required this.initialData});

  final initialData;

  @override
  List<Object> get props => [initialData];
}

class StateSuccess<T> extends DataState {
  StateSuccess(this.data);

  final data;

  @override
  List<Object> get props => [data];
}

class StateSuccessWithList extends DataState {
  StateSuccessWithList(this.result);

  final List<Object> result;
  @override
  List<Object> get props => [result];
}

class StateSuccessWithMap extends DataState {
  StateSuccessWithMap(this.result);

  final Map<String, dynamic> result;
  @override
  List<Object> get props => [result];
}

class StateEmpty extends DataState {
  @override
  List<Object> get props => [];
}

class TimeOffOnlyEmpty extends DataState {
  @override
  List<Object> get props => [];
}

class OvertimeEmpty extends DataState {
  @override
  List<Object> get props => [];
}
