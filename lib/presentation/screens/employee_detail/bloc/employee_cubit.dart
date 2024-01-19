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
    employees.add(employee);
    employeeRepository.addEmployee(employee);
    emit(EmployeesUpdate());
  }

  editEmployee() {
    employeeRepository.addEmployee(selectedEmployee);
    emit(EmployeesUpdate());
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

  selectStartDate(DateTime dateTime) {}

  selectEndDate(DateTime endDate) {}

  setEmployeeToEdit(Employee employee) {
    selectedEmployee = employee;
  }
}
