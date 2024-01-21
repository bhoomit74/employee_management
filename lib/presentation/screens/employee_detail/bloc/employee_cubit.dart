import 'package:employee_management/data/employee_repository_impl.dart';
import 'package:employee_management/domain/employee.dart';
import 'package:employee_management/domain/repository/employee_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  Employee selectedEmployee = Employee.empty();
  List<Employee> employees = [];
  List<Employee> currentEmployees = [];
  List<Employee> previousEmployees = [];
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
    employees.remove(employee);
    employeeRepository.deleteEmployee(employee);
    separateCurrentAndPreviousEmployee();
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
