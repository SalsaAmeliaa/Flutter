class BankAccount {
  double _balance = 0.0;

  double get balance => this._balance;

  void deposit(double amount) {
    this._balance += amount;
  }

  void withdraw(double amount) {
    if (this._balance >= amount) {
      this._balance -= amount;
    } else {
      throw new Exception("Insufficient Balance");
    }
  }
}

void main() {
  BankAccount account = new BankAccount();
  account.deposit(1000);
  print("Balance after deposit: ${account.balance}");
  account.withdraw(500);
  print("Balance after withdraw: ${account.balance}");
}