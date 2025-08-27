import 'package:flutter/material.dart';

class OrderDetailOneScreen extends StatelessWidget {
  final String orderNo;
  final String statusLabel;
  final String dateLine; // e.g. "2 items • 20 July 2025 • 13:45"

  const OrderDetailOneScreen({
    super.key,
    this.orderNo = '000101',
    this.statusLabel = 'New Order',
    this.dateLine = '2 items • 20 July 2025 • 13:45',
  });

  @override
  Widget build(BuildContext context) {
    final items = <_OrderItem>[
      _OrderItem('Margeritta Pizza (Large)', ['Cheese', 'Chicken'], 1, 70),
      _OrderItem('Margeritta Pizza (Large)', ['Cheese', 'Chicken'], 1, 70),
    ];
    final subtotal = items.fold<double>(0, (s, e) => s + e.price * e.qty);
    final total = 150.0; // demo total

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          children: [
            // Top bar (custom)
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
                _pill(statusLabel, const Color(0xFFFBC02D), const Color(0xFFFFF59D)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 48, right: 8, bottom: 8),
              child: Text(
                dateLine,
                style: TextStyle(
                  color: Colors.black.withAlpha(140),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 6),
            _sectionTitle('Order summary'),

            // Items
            ...items.map((it) => _OrderRow(item: it)).toList(),
            const SizedBox(height: 8),
            Row(
              children: [
                const Spacer(),
                Text('Subtotal',
                    style: TextStyle(
                      color: Colors.black.withAlpha(160),
                      fontWeight: FontWeight.w600,
                    )),
                const SizedBox(width: 16),
                Text('\$${subtotal.toStringAsFixed(0)}',
                    style: const TextStyle(fontWeight: FontWeight.w700)),
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
              child: Row(
                children: [
                  const Text('Card', style: TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(width: 12),
                  const Text(
                    'ONLINE PAYMENT',
                    style: TextStyle(
                      color: Color(0xFF2E7D32),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '\$${total.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Accept button -> shows Accept sheet
            SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: () => _showConfirmSheet(context, isAccept: true),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  backgroundColor: Colors.transparent,
                  elevation: 2,
                  shadowColor: Colors.black26,
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFFFA726), Color(0xFFF57C00)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Text(
                      'Accept',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Decline -> shows Decline sheet
            Center(
              child: TextButton(
                onPressed: () => _showConfirmSheet(context, isAccept: false),
                child: Text(
                  'Decline',
                  style: TextStyle(
                    color: Colors.black.withAlpha(180),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ----------------------------- SHEETS -----------------------------

  Future<void> _showConfirmSheet(BuildContext context, {required bool isAccept}) {
    final title = isAccept ? 'Accept?' : 'Decline?';
    final msg = isAccept
        ? 'Are you sure you want to ACCEPT this order?'
        : 'Are you sure you want to DECLINE this order?';

    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: false,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (sheetCtx) {
        return SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // drag handle
                Container(
                  width: 44,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(30),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 14),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(height: 6),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    msg,
                    style: TextStyle(
                      color: Colors.black.withAlpha(140),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // Primary button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: isAccept
                      ? ElevatedButton(
                          onPressed: () {
                            Navigator.pop(sheetCtx); // close sheet
                            // Go to Status screen
                            Navigator.pushReplacementNamed(context, '/order-status');
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0xFFFFA726), Color(0xFFF57C00)],
                              ),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Center(
                              child: Text(
                                'Yes',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            Navigator.pop(sheetCtx); // close sheet
                            // TODO: handle decline action (stay on this screen or pop)
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE53935), // red
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 0,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text(
                            'Yes',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                ),

                const SizedBox(height: 10),

                // Secondary "No" button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(sheetCtx),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Color(0x22000000)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      foregroundColor: Colors.black87,
                    ),
                    child: const Text(
                      'No',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ----------------------------- Helpers -----------------------------

  Widget _sectionTitle(String t) => Container(
        margin: const EdgeInsets.only(top: 12),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFF4F6F8),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0x11000000)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            t,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
      );

  Widget _kvRow(String k, String v, {bool link = false}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
        child: Row(
          children: [
            SizedBox(
              width: 110,
              child: Text(
                k,
                style: TextStyle(
                  color: Colors.black.withAlpha(150),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  v,
                  style: TextStyle(
                    color: link ? const Color(0xFF1565C0) : Colors.black,
                    fontWeight: link ? FontWeight.w700 : FontWeight.w600,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
          ],
        ),
      );

  Widget _pill(String text, Color border, Color bg) {
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

class _OrderItem {
  final String name;
  final List<String> opts;
  final int qty;
  final double price;

  _OrderItem(this.name, this.opts, this.qty, this.price);
}

class _OrderRow extends StatelessWidget {
  final _OrderItem item;
  const _OrderRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      child: Row(
        children: [
          // Thumbnail
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

          // Name + options
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name,
                    style: const TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(
                  item.opts.join('\n'),
                  style: TextStyle(color: Colors.black.withAlpha(140)),
                ),
              ],
            ),
          ),

          // Qty x Price
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('X ${item.qty}', style: TextStyle(color: Colors.black.withAlpha(160))),
              const SizedBox(height: 6),
              Text('\$${item.price.toStringAsFixed(0)}',
                  style: const TextStyle(fontWeight: FontWeight.w700)),
            ],
          ),
        ],
      ),
    );
  }
}
