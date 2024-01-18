import 'package:employee_management/data/employee_repository_impl.dart';
import 'package:employee_management/domain/employee.dart';
import 'package:employee_management/domain/repository/employee_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  String _selectedRole = "";
  String _employeeName = "";
  String _startDate = "";
  String _endDate = "";
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
    try {
      Employee employee = Employee(
          DateTime.now().millisecondsSinceEpoch.toString(),
          _employeeName,
          _selectedRole,
          _startDate,
          _endDate);
      employees.add(employee);
      employeeRepository.addEmployee(employee);
      emit(EmployeesUpdate());
    } on FormatException catch (a, _) {
      emit(Error(a.message));
    }
  }

  editEmployee() {
    try {
      /*Employee employee =
          Employee(_employeeName, _selectedRole, _startDate, _endDate);*/
    } on FormatException catch (a, _) {
      emit(Error(a.message));
    }
  }

  deleteEmployee(Employee employee) {
    employees.remove(employee);
    employeeRepository.deleteEmployee(employee);
    emit(EmployeesUpdate());
  }

  onEmployeeNameChange(String name) {
    _employeeName = name;
  }

  selectRole(String role) {
    _selectedRole = role;
    emit(RoleChange(role));
  }

  selectStartDate(DateTime dateTime) {}

  selectEndDate() {}
}
