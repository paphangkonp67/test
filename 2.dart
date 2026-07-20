// ===============================
// 2.5 Enum
// ===============================

enum OrderStatus {
  pending,
  paid,
  cancelled,
}

// ===============================
// 2.1 Abstract Class
// ===============================

abstract class MenuItem {
  final String name;
  final double basePrice;

  static int itemCount = 0;

  MenuItem(this.name, this.basePrice) {
    itemCount++;
  }

  // Abstract method
  double price();

  // Concrete method
  void show() {
    print('$name - ${price()} บาท');
  }
}

// ===============================
// 2.2 Drink
// ===============================

class Drink extends MenuItem {
  final int toppings;

  Drink(
    String name,
    double basePrice,
    this.toppings,
  ) : super(name, basePrice);

  @override
  double price() {
    return basePrice + (10 * toppings);
  }
}

// ===============================
// 2.2 Food
// ===============================

class Food extends MenuItem {
  final String size;

  Food(
    String name,
    double basePrice,
    this.size,
  ) : super(name, basePrice);

  @override
  double price() {
    double multiplier;

    switch (size) {
      case 'S':
        multiplier = 1.0;
        break;

      case 'M':
        multiplier = 1.2;
        break;

      case 'L':
        multiplier = 1.5;
        break;

      default:
        multiplier = 1.0;
    }

    return basePrice * multiplier;
  }
}

// ===============================
// 2.4 Wallet
// ===============================

class Wallet {
  double _balance;

  Wallet(this._balance);

  // Getter
  double get balance {
    return _balance;
  }

  // Setter
  set balance(double value) {
    if (value < 0) {
      print('ผิดพลาด: ยอดเงินติดลบไม่ได้');
      return;
    }

    _balance = value;
  }

  bool pay(double amount) {
    if (_balance >= amount) {
      _balance -= amount;
      print('ชำระเงินสำเร็จ');
      return true;
    }

    print('ยอดเงินไม่พอ');
    return false;
  }
}

// ===============================
// 2.5 แสดงสถานะ Order
// ===============================

void showStatus(OrderStatus status) {
  switch (status) {
    case OrderStatus.pending:
      print('สถานะ: รอชำระเงิน');
      break;

    case OrderStatus.paid:
      print('สถานะ: ชำระเงินแล้ว');
      break;

    case OrderStatus.cancelled:
      print('สถานะ: ยกเลิกคำสั่งซื้อ');
      break;
  }
}

// ===============================
// Main
// ===============================

void main() {
  // 2.3 Polymorphism
  List<MenuItem> order = [
    Drink('ลาเต้', 55, 1),
    Food('ข้าวผัด', 60, 'L'),
    Drink('อเมริกาโน่', 45, 0),
  ];

  double total = 0;

  for (final item in order) {
    item.show();
    total += item.price();
  }

  print('ยอดรวมทั้งสิ้น : $total บาท');

  print('---');

  // 2.4 Wallet
  final wallet = Wallet(300);

  // กรณีที่ 1: กำหนดค่าติดลบ
  wallet.balance = -100;

  // กรณีที่ 2: จ่ายเงินสำเร็จ
  if (wallet.pay(200)) {
    showStatus(OrderStatus.paid);
  }

  print('ยอดคงเหลือ : ${wallet.balance} บาท');

  // กรณีที่ 3: เงินไม่พอ
  if (!wallet.pay(500)) {
    showStatus(OrderStatus.pending);
  }

  print('ยอดคงเหลือ : ${wallet.balance} บาท');

  print('---');

  // 2.5 Static itemCount
  print('จำนวนรายการเมนูที่ถูกสร้าง: ${MenuItem.itemCount}');
}