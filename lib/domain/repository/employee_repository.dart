import 'package:employee_management/domain/model/employee.dart';

abstract class EmployeeRepository {
  List<Employee> fetchEmployees();
  void addEmployee(Employee employee);
  void deleteEmployee(Employee employee);
  void updateEmployee(Employee employee);
}
