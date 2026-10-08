class Teacher {
  String? name;
  int? age;
  String? subject;
  double? salary;

  Teacher(String name, int age, String subject, double salary) {
    this.name = name;
    this.age = age;
    this.subject = subject;
    this.salary = salary;
  }

  void display() {
    print("Name: ${this.name}");
    print("Age: ${this.age}");
    print("Subject: ${this.subject}");
    print("Salary: ${this.salary}\n");
  }
}

void main() {
  Teacher teacher1 = Teacher("John", 30, "Maths", 50000.0);
  teacher1.display();

  Teacher teacher2 = Teacher("Smith", 35, "Science", 60000.0);
  teacher2.display();
}