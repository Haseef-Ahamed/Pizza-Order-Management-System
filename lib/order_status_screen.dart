// lib/order_status_screen.dart
import 'package:flutter/material.dart';

enum OrderStatus { inProgress, ready, completed }

// simple holder (avoids Dart 3 records)
class PillColors {
  final Color border;
  final Color bg;
  const PillColors(this.border, this.bg);
}

class OrderStatusScreen extends StatefulWidget {
  final String orderNo;
  const OrderStatusScreen({super.key, this.orderNo = '000101'});

  @override
  State<OrderStatusScreen> createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> {
  OrderStatus _status = OrderStatus.inProgress;

  @override
  Widget build(BuildContext context) {
    final label = _labelOf(_status);
    final colors = _colorsOf(_status); // PillColors(border, bg)

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          children: [
            // Header
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  onPressed: () => Navigator.pop(context),
                ),
                Expanded(
                  child: Text(
                    'ORDER - ${widget.orderNo}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
                _pill(label, colors.border, colors.bg),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 48, right: 8, bottom: 8),
              child: Text(
                '2 items • 20 July 2025 • 13:45',
                style: TextStyle(
                  color: Color(0x99000000),
                  fontWeight: FontWeight.w600,
                ),
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
                Text('Subtotal',
                    style: TextStyle(
                      color: Color(0x99000000),
                      fontWeight: FontWeight.w600,
                    )),
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

            const SizedBox(height: 18),
            _sectionTitle('Update Status'),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('Status', style: TextStyle(fontWeight: FontWeight.w700)),
                const Spacer(),
                GestureDetector(
                  onTap: () => _showStatusPicker(context),
                  child: _pill(label, colors.border, colors.bg),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /* ----------------------- Bottom sheet picker ---------------------- */

  Future<void> _showStatusPicker(BuildContext context) async {
    OrderStatus selected = _status; // local selection

    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (sheetCtx) {
        return StatefulBuilder(
          builder: (ctx, setSheetState) {
            return SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Select',
                          style: TextStyle(fontWeight: FontWeight.w800)),
                    ),
                    const SizedBox(height: 8),

                    _radioRow(
                      'In progress',
                      OrderStatus.inProgress,
                      selected,
                      onChanged: (v) => setSheetState(() => selected = v!),
                    ),
                    _radioRow(
                      'Ready',
                      OrderStatus.ready,
                      selected,
                      onChanged: (v) => setSheetState(() => selected = v!),
                    ),
                    _radioRow(
                      'Completed',
                      OrderStatus.completed,
                      selected,
                      onChanged: (v) => setSheetState(() => selected = v!),
                    ),

                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(sheetCtx); // close sheet
                          if (selected == OrderStatus.completed) {
                            // only navigate when Completed
                            Navigator.pushReplacementNamed(
                                context, '/order-completed');
                          } else {
                            setState(() => _status = selected);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1C1C1C),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 0,
                        ),
                        child: const Text('Confirm',
                            style: TextStyle(fontWeight: FontWeight.w700)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(sheetCtx),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          side: const BorderSide(color: Color(0x22000000)),
                        ),
                        child: const Text('Close',
                            style: TextStyle(fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  /* ---------------------------- Helpers ---------------------------- */

  PillColors _colorsOf(OrderStatus s) {
    switch (s) {
      case OrderStatus.inProgress:
        return const PillColors(Color(0xFF1E88E5), Color(0xFFE3F2FD));
      case OrderStatus.ready:
        return const PillColors(Color(0xFF26A69A), Color(0xFFE0F2F1));
      case OrderStatus.completed:
        return const PillColors(Color(0xFFF57C00), Color(0xFFFFF3E0));
    }
  }

  String _labelOf(OrderStatus s) {
    switch (s) {
      case OrderStatus.inProgress:
        return 'In progress';
      case OrderStatus.ready:
        return 'Ready';
      case OrderStatus.completed:
        return 'Completed';
    }
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
              child:
                  const Icon(Icons.local_pizza_rounded, color: Color(0xFFF57C00)),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Margeritta Pizza (Large)',
                      style: TextStyle(fontWeight: FontWeight.w700)),
                  SizedBox(height: 2),
                  Text('Cheese\nChicken',
                      style: TextStyle(color: Color(0x99000000))),
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
          child:
              Text(t, style: const TextStyle(fontWeight: FontWeight.w800)),
        ),
      );

  static Widget _kvRow(String k, String v, {bool link = false}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
        child: Row(
          children: [
            SizedBox(
              width: 150,
              child: Text(k,
                  style: const TextStyle(
                      color: Color(0x99000000), fontWeight: FontWeight.w600)),
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
      child:
          Text(text, style: TextStyle(color: border, fontWeight: FontWeight.w800)),
    );
  }

  // ✅ Null-safety fix: groupValue is nullable and onChanged is required
  Widget _radioRow(
    String label,
    OrderStatus value,
    OrderStatus? groupValue, {
    required ValueChanged<OrderStatus?> onChanged,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
      dense: true,
      title: Text(label),
      trailing: Radio<OrderStatus>(
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
      onTap: () => onChanged(value),
    );
  }
}
