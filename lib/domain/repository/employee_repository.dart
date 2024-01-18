import 'package:employee_management/domain/employee.dart';

abstract class EmployeeRepository {
  List<Employee> fetchEmployees();
  void addEmployee(Employee employee);
  void deleteEmployee(Employee employee);
  void updateEmployee(Employee employee);
}
