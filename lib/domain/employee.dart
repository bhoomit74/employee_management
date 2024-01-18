class Employee {
  late String name;
  late String role;
  late String startDate;
  late String endDate;

  Employee(this.name, this.role, this.startDate, this.endDate) {
    if (name.isEmpty)
      throw (const FormatException("Employee name is required."));
    if (role.isEmpty) throw (const FormatException("Please select role."));
  }
}
