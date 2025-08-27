import 'package:flutter/material.dart';

class OrderCompletedScreen extends StatelessWidget {
  final String orderNo;
  const OrderCompletedScreen({super.key, this.orderNo = '000101'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  onPressed: () => Navigator.pop(context),
                ),
                Expanded(
                  child: Text(
                    'ORDER - $orderNo',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
                _pill('Completed', const Color(0xFFF57C00), const Color(0xFFFFF3E0)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 48, right: 8, bottom: 8),
              child: Text(
                '2 items • 20 July 2025 • 13:45',
                style: TextStyle(fontWeight: FontWeight.w600, color: Color(0x99000000)),
              ),
            ),

            const SizedBox(height: 6),
            _sectionTitle('Order summary'),
            _rowItem(),
            _rowItem(),
            const SizedBox(height: 8),
            Row(
              children: const [
                Spacer(),
                Text('Subtotal', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0x99000000))),
                SizedBox(width: 16),
                Text('\$140', style: TextStyle(fontWeight: FontWeight.w700)),
              ],
            ),

            const SizedBox(height: 18),
            _sectionTitle('Customer details'),
            _kvRow('Name', 'John Doe'),
            _kvRow('Email', 'jesse@gmail.com', link: true),
            _kvRow('Phone no.', '+917 123 4567'),
            _kvRow('Address', '12, Sea street, Col-13', link: true),
            _kvRow('City', 'Colombo'),

            const SizedBox(height: 18),
            _sectionTitle('Payment'),
            _kvRow('Cash on Delivery', 'LKR 5000.00'),
          ],
        ),
      ),
    );
  }

  static Widget _rowItem() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3E0),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.local_pizza_rounded, color: Color(0xFFF57C00)),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Margeritta Pizza (Large)', style: TextStyle(fontWeight: FontWeight.w700)),
                  SizedBox(height: 2),
                  Text('Cheese\nChicken', style: TextStyle(color: Color(0x99000000))),
                ],
              ),
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('X 1', style: TextStyle(color: Color(0x99000000))),
                SizedBox(height: 6),
                Text('\$70', style: TextStyle(fontWeight: FontWeight.w700)),
              ],
            ),
          ],
        ),
      );

  static Widget _sectionTitle(String t) => Container(
        margin: const EdgeInsets.only(top: 12),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFF4F6F8),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0x11000000)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(t, style: const TextStyle(fontWeight: FontWeight.w800)),
        ),
      );

  static Widget _kvRow(String k, String v, {bool link = false}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
        child: Row(
          children: [
            SizedBox(
              width: 150,
              child: Text(k, style: const TextStyle(color: Color(0x99000000), fontWeight: FontWeight.w600)),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  v,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: link ? const Color(0xFF1565C0) : Colors.black,
                    fontWeight: link ? FontWeight.w700 : FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  static Widget _pill(String text, Color border, Color bg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: border, width: 1),
      ),
      child: Text(text, style: TextStyle(color: border, fontWeight: FontWeight.w800)),
    );
  }
}
