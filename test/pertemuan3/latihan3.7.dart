class Car {
  String? name;
  String? color;
  int? numberOfSeats;

  void start() {
    print("$name Car Started");
  }
}

void main() {
  Car car= Car();
  car.name = "BMW";
  car.color = "Red";
  car.numberOfSeats = 4;
  car.start();

  Car car2 = Car();
  car.name = "Audi";
  car.color = "Black";
  car.numberOfSeats = 4;
  car.start();
}