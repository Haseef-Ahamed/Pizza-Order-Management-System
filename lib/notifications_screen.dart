// lib/notifications_screen.dart
import 'package:flutter/material.dart';
// Note: No import for order_detail_one.dart needed here since we navigate by route name.
// Make sure main.dart has:
// routes: { '/order-detail-one': (_) => const OrderDetailOneScreen(), }

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  int _bottomIndex = 3; // Notifications selected/highlighted

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          children: [
            Text('Notifications',
                style: text.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 14),

            const _SectionHeader('Today'),
            const SizedBox(height: 10),
            ..._today().map((n) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _NotificationCard(
                    orderId: n.orderId,
                    itemsText: n.itemsText,
                    timeAgo: n.timeAgo,
                    onTap: () {
                      Navigator.pushNamed(context, '/order-detail-one');
                      // If you later want to pass data:
                      // Navigator.pushNamed(context, '/order-detail-one',
                      //   arguments: {'orderNo': n.orderId});
                    },
                  ),
                )),

            const SizedBox(height: 18),

            const _SectionHeader('Yesterday'),
            const SizedBox(height: 10),
            ..._yesterday().map((n) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _NotificationCard(
                    orderId: n.orderId,
                    itemsText: n.itemsText,
                    timeAgo: n.timeAgo,
                    onTap: () {
                      Navigator.pushNamed(context, '/order-detail-one');
                    },
                  ),
                )),
          ],
        ),
      ),

      // Bottom nav (Notifications highlighted)
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomIndex,
        onTap: (i) {
          if (i == 3) return; // already here
          if (i == 0) {
            // Home -> go back to dashboard
            Navigator.pop(context);
            return;
          }
          setState(() => _bottomIndex = i); // placeholders for other tabs
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFF57C00),
        unselectedItemColor: Colors.black.withAlpha(120),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history_rounded), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.query_stats_rounded), label: 'Analytics'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_none_rounded), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_rounded), label: 'Settings'),
        ],
      ),
    );
  }

  // ---- demo data ----
  List<_Notif> _today() => const [
        _Notif(orderId: '000101', itemsText: '3 items', timeAgo: '2h ago'),
        _Notif(orderId: '000102', itemsText: '2 items', timeAgo: '2h ago'),
        _Notif(orderId: '000103', itemsText: '4 items', timeAgo: '3h ago'),
        _Notif(orderId: '000104', itemsText: '1 item',  timeAgo: '4h ago'),
      ];

  List<_Notif> _yesterday() => const [
        _Notif(orderId: '000093', itemsText: '3 items', timeAgo: '22h ago'),
        _Notif(orderId: '000094', itemsText: '2 items', timeAgo: '23h ago'),
        _Notif(orderId: '000095', itemsText: '4 items', timeAgo: 'Yesterday'),
        _Notif(orderId: '000096', itemsText: '1 item',  timeAgo: 'Yesterday'),
      ];
}

/* ---------------------------- widgets ---------------------------- */

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: const Color(0xFFF57C00),
            fontWeight: FontWeight.w700,
          ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final String orderId;
  final String itemsText;
  final String timeAgo;
  final VoidCallback onTap;

  const _NotificationCard({
    required this.orderId,
    required this.itemsText,
    required this.timeAgo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(color: Color(0x11000000), blurRadius: 8, offset: Offset(0, 3)),
          ],
        ),
        child: Row(
          children: [
            // Left: title + subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ORDER - $orderId',
                      style: text.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.3,
                      )),
                  const SizedBox(height: 2),
                  Text(
                    itemsText,
                    style: text.bodyMedium?.copyWith(color: Colors.black.withAlpha(140)),
                  ),
                ],
              ),
            ),
            // Right: time
            Text(
              timeAgo,
              style: text.bodySmall?.copyWith(
                color: Colors.black.withAlpha(140),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ---------------------------- models ----------------------------- */

class _Notif {
  final String orderId;
  final String itemsText;
  final String timeAgo;
  const _Notif({
    required this.orderId,
    required this.itemsText,
    required this.timeAgo,
  });
}
