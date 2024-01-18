part of 'employee_cubit.dart';

abstract class EmployeeState {}

class EmployeeInitial extends EmployeeState {}

class EmployeeLoading extends EmployeeState {}

class EmployeesNotFound extends EmployeeState {}

class EmployeesFound extends EmployeeState {}

class EmployeesUpdate extends EmployeeState {}

class RoleChange extends EmployeeState {
  final String role;
  RoleChange(this.role);
}

class Error extends EmployeeState {
  final String errorMessage;
  Error(this.errorMessage);
}
