const double vatRate = 0.07;

double calcTotal({
  required int price,
  required int qty,
  double discount = 0,
}) {
  return (price * qty - discount) * (1 + vatRate);
}

void main() {
  // 1.1 ตัวแปรและค่าคงที่
  final String shopName = 'Dart Cafe';

  print('ร้าน: $shopName');
  print('อัตราภาษี (vatRate): $vatRate');

  print('---');

  // 1.2 List และ Map
  List<String> categories = [
    'เครื่องดื่ม',
    'ของคาว',
    'ของหวาน',
  ];

  Map<String, int> menu = {
    'ลาเต้': 55,
    'ข้าวผัด': 60,
    'เค้ก': 45,
    'กาแฟ': 40,
  };

  print('หมวดเมนู: $categories');
  print('จำนวนเมนูทั้งหมด: ${menu.length} รายการ');
  print('ราคาลาเต้: ${menu['ลาเต้']} บาท');

  print('---');

  // 1.3 for-in + if
  print('เมนูราคาตั้งแต่ 50 บาทขึ้นไป:');

  for (final entry in menu.entries) {
    if (entry.value >= 50) {
      print('${entry.key} : ${entry.value} บาท');
    }
  }

  print('---');

  // 1.4 Function
  final double total1 = calcTotal(
    price: 55,
    qty: 2,
  );

  final double total2 = calcTotal(
    price: 55,
    qty: 2,
    discount: 10,
  );

  print('ยอดสุทธิ (ไม่มีส่วนลด): $total1 บาท');
  print('ยอดสุทธิ (ส่วนลด 10 บาท): $total2 บาท');

  print('---');

  // 1.5 Null Safety
  String? coupon;

  print('ความยาวคูปอง: ${coupon?.length ?? 0}');

  coupon ??= 'NO-COUPON';

  print('คูปองหลังกำหนดค่า: $coupon');
}