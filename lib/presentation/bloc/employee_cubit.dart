import 'dart:async';

import 'package:employee_management/data/employee_repository_impl.dart';
import 'package:employee_management/domain/model/employee.dart';
import 'package:employee_management/domain/repository/employee_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  Employee selectedEmployee = Employee.empty();
  List<Employee> employees = [];
  List<Employee> currentEmployees = [];
  List<Employee> previousEmployees = [];
  Timer? _deleteTimer;
  Employee? undoEmployee;
  late EmployeeRepository employeeRepository;
  EmployeeCubit() : super(EmployeeInitial()) {
    employeeRepository = EmployeeRepositoryImpl();
    fetchEmployees();
  }

  fetchEmployees() {
    employees.addAll(employeeRepository.fetchEmployees());
    separateCurrentAndPreviousEmployee();
    emit(EmployeesFetch());
  }

  addEmployee() {
    Employee employee = selectedEmployee.copy();
    employee.id = DateTime.now().millisecondsSinceEpoch.toString();
    if (employee.error.isEmpty) {
      employees.add(employee);
      employeeRepository.addEmployee(employee);
      separateCurrentAndPreviousEmployee();
      emit(EmployeesUpdate());
    } else {
      emit(Error(employee.error));
    }
  }

  editEmployee() {
    if (selectedEmployee.error.isEmpty) {
      employeeRepository.addEmployee(selectedEmployee);
      separateCurrentAndPreviousEmployee();
      emit(EmployeesUpdate());
    } else {
      emit(Error(selectedEmployee.error));
    }
  }

  deleteEmployee(Employee employee) {
    // Remove the employee immediately from the list
    employees.remove(employee);
    separateCurrentAndPreviousEmployee();

    //If a delete timer is active for a previous employee, cancel it and delete that employee
    if (_deleteTimer?.isActive == true && undoEmployee != null) {
      _deleteTimer?.cancel();
      employeeRepository.deleteEmployee(undoEmployee!);
      undoEmployee = null;
    }

    ///Set the current employee as the one to be undo.
    undoEmployee = employee;

    ///Wait for 4 seconds before deleting the employee permanently, so user can undo this operation.
    _deleteTimer = Timer(const Duration(seconds: 4), () {
      employeeRepository.deleteEmployee(employee);
      undoEmployee = null;
    });
    emit(EmployeesDelete());
  }

  undoDelete() {
    if (_deleteTimer?.isActive == true && undoEmployee != null) {
      _deleteTimer?.cancel();
      employees.add(undoEmployee!);
      separateCurrentAndPreviousEmployee();
      emit(EmployeesUpdate());
    }
  }

  onEmployeeNameChange(String name) {
    selectedEmployee.name = name;
  }

  selectRole(String role) {
    selectedEmployee.role = role;
    emit(RoleChange(role));
  }

  selectStartDate(DateTime? dateTime) {
    if (dateTime == null) {
      return;
    }
    selectedEmployee.startDate = dateTime.millisecondsSinceEpoch;
    emit(StartDateChange(dateTime.millisecondsSinceEpoch));
  }

  selectEndDate(DateTime? dateTime) {
    selectedEmployee.endDate = dateTime?.millisecondsSinceEpoch;
    emit(EndDateChange(dateTime?.millisecondsSinceEpoch));
  }

  selectEmployee(Employee? employee) {
    selectedEmployee = employee ?? Employee.empty();
    emit(EmployeeSelected(selectedEmployee));
  }

  separateCurrentAndPreviousEmployee() {
    currentEmployees.clear();
    previousEmployees.clear();
    for (Employee employee in employees) {
      if (employee.endDate == null) {
        currentEmployees.add(employee);
      } else {
        previousEmployees.add(employee);
      }
    }
  }
}
