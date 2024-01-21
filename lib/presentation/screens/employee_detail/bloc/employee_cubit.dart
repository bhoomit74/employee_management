import 'package:employee_management/data/employee_repository_impl.dart';
import 'package:employee_management/domain/employee.dart';
import 'package:employee_management/domain/repository/employee_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  Employee selectedEmployee = Employee.empty();
  List<Employee> employees = [];
  late EmployeeRepository employeeRepository;
  EmployeeCubit() : super(EmployeeInitial()) {
    employeeRepository = EmployeeRepositoryImpl();
    fetchEmployees();
  }

  List<Employee> fetchEmployees() {
    employees.addAll(employeeRepository.fetchEmployees());
    return employees;
  }

  addEmployee() {
    Employee employee = selectedEmployee.copy();
    employee.id = DateTime.now().millisecondsSinceEpoch.toString();
    if (employee.error.isEmpty) {
      employees.add(employee);
      employeeRepository.addEmployee(employee);
      emit(EmployeesUpdate());
    } else {
      emit(Error(employee.error));
    }
  }

  editEmployee() {
    if (selectedEmployee.error.isEmpty) {
      employeeRepository.addEmployee(selectedEmployee);
      emit(EmployeesUpdate());
    } else {
      emit(Error(selectedEmployee.error));
    }
  }

  deleteEmployee(Employee employee) {
    employees.remove(employee);
    employeeRepository.deleteEmployee(employee);
    emit(EmployeesUpdate());
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
    if (employee == null) {
      selectedEmployee = Employee.empty();
    } else {
      selectedEmployee = employee;
    }
    emit(EmployeeSelected(selectedEmployee));
  }
}
