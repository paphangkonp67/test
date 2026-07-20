// ===============================
// 3.1 Future
// ===============================

Future<Map<String, dynamic>> fetchOrder(int orderId) async {
  // จำลองการติดต่อ Server 2 วินาที
  await Future.delayed(
    Duration(seconds: 2),
  );

  // ตรวจสอบรหัส Order
  if (orderId <= 0) {
    throw Exception('รหัสคำสั่งซื้อไม่ถูกต้อง');
  }

  // คืนข้อมูล Order
  return {
    'id': orderId,
    'menu': 'ลาเต้',
    'total': 65.0,
  };
}

// ===============================
// 3.3 Stream
// ===============================

Stream<String> trackOrder() async* {
  // สถานะที่ 1
  await Future.delayed(
    Duration(seconds: 1),
  );

  yield 'รับออร์เดอร์แล้ว';

  // สถานะที่ 2
  await Future.delayed(
    Duration(seconds: 1),
  );

  yield 'กำลังจัดทำ';

  // สถานะที่ 3
  await Future.delayed(
    Duration(seconds: 1),
  );

  yield 'จัดส่งเรียบร้อย';
}

// ===============================
// Main
// ===============================

Future<void> main() async {
  print('เริ่มโหลดข้อมูล...');

  // ===============================
  // 3.2 กรณี Order ถูกต้อง
  // ===============================

  try {
    final order = await fetchOrder(7);

    print('ได้ข้อมูลออร์เดอร์: $order');
  } catch (e) {
    print('เกิดข้อผิดพลาด: $e');
  } finally {
    print('จบรายการ');
  }

  // ===============================
  // 3.2 กรณี Order ผิด
  // ===============================

  try {
    final order = await fetchOrder(0);

    print('ได้ข้อมูลออร์เดอร์: $order');
  } catch (e) {
    print('เกิดข้อผิดพลาด: $e');
  } finally {
    print('จบรายการ');
  }

  print('---');

  // ===============================
  // 3.3 Stream
  // ===============================

  await for (final status in trackOrder()) {
    print('สถานะ: $status');
  }

  print('ติดตามสถานะเสร็จสิ้น');
}