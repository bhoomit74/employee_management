import 'package:employee_management/domain/model/employee.dart';
import 'package:employee_management/domain/repository/employee_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  Box employeesBox = Hive.box("Employees");

  @override
  List<Employee> fetchEmployees() {
    return employeesBox.values.map((e) => Employee.fromJson(e)).toList();
  }

  @override
  void addEmployee(Employee employee) {
    employeesBox.put(employee.id, employee.toJson());
  }

  @override
  void deleteEmployee(Employee employee) {
    employeesBox.delete(employee.id);
  }

  @override
  void updateEmployee(Employee employee) {
    employeesBox.put(employee.id, employee.toJson());
  }
}
