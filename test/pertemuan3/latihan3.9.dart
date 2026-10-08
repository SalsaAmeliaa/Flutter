class Student {
  String? _firstName;
  String? _lastName;
  int? _age;

  String get fullName => this._firstName! + " " + this._lastName!;

  int get age => this._age!;

  set firstName(String firstName) => this._firstName = firstName;

  set lastName(String lastName) => this._lastName = lastName;

  set age(int age) {
    if (age < 0) {
      throw new Exception("Age can't be less than 0");
    }
    this._age = age;
  }
}

void main() {
  Student st = new Student();

  st.firstName = "john";
  st.lastName = "Doe";
  st.age = 20;

  print("Full Name: ${st.fullName}");
  print("Age: ${st.age}");
}