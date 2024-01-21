import 'package:employee_management/core/styles/app_strings.dart';

class Employee {
  late String id;
  late String name;
  late String role;
  late int startDate;
  int? endDate;

  Employee(this.id, this.name, this.role, this.startDate, this.endDate);
  Employee.empty() {
    id = "";
    name = "";
    role = "";
    startDate = DateTime.now().millisecondsSinceEpoch;
    endDate = null;
  }

  Employee.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    role = json['role'];
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<dynamic, dynamic> toJson() {
    Map<dynamic, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['role'] = role;
    data['startDate'] = startDate;
    data['endDate'] = endDate;

    return data;
  }

  Employee copy() {
    return Employee(id, name, role, startDate, endDate);
  }

  String get error {
    if (name.isEmpty) {
      return AppStrings.nameError;
    } else if (role.isEmpty) {
      return AppStrings.roleError;
    } else {
      return "";
    }
  }
}
