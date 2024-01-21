part of 'employee_cubit.dart';

abstract class EmployeeState {}

class EmployeeInitial extends EmployeeState {}

class EmployeeLoading extends EmployeeState {}

class EmployeesFetch extends EmployeeState {}

class EmployeesUpdate extends EmployeeState {}

class StartDateChange extends EmployeeState {
  final int startDate;
  StartDateChange(this.startDate);
}

class EndDateChange extends EmployeeState {
  final int? endDate;
  EndDateChange(this.endDate);
}

class RoleChange extends EmployeeState {
  final String role;
  RoleChange(this.role);
}

class Error extends EmployeeState {
  final String errorMessage;
  Error(this.errorMessage);
}

class EmployeeSelected extends EmployeeState {
  final Employee employee;
  EmployeeSelected(this.employee);
}
