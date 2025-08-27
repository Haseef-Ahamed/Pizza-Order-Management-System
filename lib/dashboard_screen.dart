// lib/dashboard_screen.dart
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  final String userName;
  const DashboardScreen({super.key, this.userName = 'Shavon Fernando'});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;
  int _bottomIndex = 0; // Home selected

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dateStr = _formatDate(DateTime.now());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _Header(userName: widget.userName, date: dateStr),

            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Activity',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w800),
              ),
            ),

            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: _ActivityGrid(),
            ),

            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: _SegmentedTabs(controller: _tabs),
            ),

            const SizedBox(height: 6),

            // Tab contents (sample orders)
            SizedBox(
              height: 600,
              child: TabBarView(
                controller: _tabs,
                children: [
                  _OrdersList(
                    statusLabel: 'New Order',
                    statusBorder: const Color(0xFFFBC02D),
                    statusBg: const Color(0xFFFFF59D),
                    titlePrefix: 'ORDER - ',
                    onView: (id, status) {
                      Navigator.pushNamed(context, '/order-detail-one');
                      // To pass data later:
                      // Navigator.pushNamed(context, '/order-detail-one',
                      //   arguments: {'orderNo': id, 'status': status});
                    },
                  ),
                  _OrdersList(
                    statusLabel: 'In progress',
                    statusBorder: const Color(0xFF1E88E5),
                    statusBg: const Color(0xFFE3F2FD),
                    titlePrefix: 'ORDER - ',
                    onView: (id, status) {
                      Navigator.pushNamed(context, '/order-detail-one');
                    },
                  ),
                  _OrdersList(
                    statusLabel: 'Ready',
                    statusBorder: const Color(0xFF26A69A),
                    statusBg: const Color(0xFFE0F2F1),
                    titlePrefix: 'ORDER - ',
                    onView: (id, status) {
                      Navigator.pushNamed(context, '/order-detail-one');
                    },
                  ),
                  _OrdersList(
                    statusLabel: 'Completed',
                    statusBorder: const Color(0xFFF57C00),
                    statusBg: const Color(0xFFFFF3E0),
                    titlePrefix: 'ORDER - ',
                    onView: (id, status) {
                      Navigator.pushNamed(context, '/order-detail-one');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomIndex,
        onTap: (i) {
          if (i == 3) {
            Navigator.pushNamed(context, '/notifications');
            return; // keep Home highlighted when returning
          }
          setState(() => _bottomIndex = i);
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

  String _formatDate(DateTime d) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(d.day)}/${two(d.month)}/${d.year}';
  }
}

/* ============================== HEADER ============================== */

class _Header extends StatelessWidget {
  final String userName;
  final String date;
  const _Header({required this.userName, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFFCC80), Color(0xFFFFA726)],
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Good Evening,',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.black.withAlpha(170)),
              ),
              const SizedBox(height: 2),
              Text(
                userName,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
              ),
            ]),
          ),
          Text(
            date,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w600, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}

/* =========================== ACTIVITY GRID ========================== */

class _ActivityGrid extends StatelessWidget {
  const _ActivityGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.62,
      children: const [
        _ActivityTile(
          count: '05',
          label: 'New Orders',
          chipBg: Color(0xFFFFF59D),
          chipBorder: Color(0xFFFBC02D),
          icon: Icons.local_mall_outlined,
        ),
        _ActivityTile(
          count: '10',
          label: 'In progress',
          chipBg: Color(0xFFE3F2FD),
          chipBorder: Color(0xFF1E88E5),
          icon: Icons.hourglass_bottom_rounded,
        ),
        _ActivityTile(
          count: '12',
          label: 'Ready',
          chipBg: Color(0xFFE0F2F1),
          chipBorder: Color(0xFF26A69A),
          icon: Icons.verified_rounded,
        ),
        _ActivityTile(
          count: '20',
          label: 'Completed',
          chipBg: Color(0xFFFFF3E0),
          chipBorder: Color(0xFFF57C00),
          icon: Icons.badge_outlined,
        ),
      ],
    );
  }
}

class _ActivityTile extends StatelessWidget {
  final String count, label;
  final Color chipBg, chipBorder;
  final IconData icon;

  const _ActivityTile({
    required this.count,
    required this.label,
    required this.chipBg,
    required this.chipBorder,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Color(0x11000000), blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _pill(label, chipBorder, chipBg, icon: icon, dense: true),
          const Spacer(),
          Text(
            count,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
          ),
        ],
      ),
    );
  }
}

/* =========================== SEGMENTED TABS ========================= */

class _SegmentedTabs extends StatelessWidget {
  final TabController controller;
  const _SegmentedTabs({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0x0F000000),
        borderRadius: BorderRadius.circular(24),
      ),
      child: TabBar(
        controller: controller,
        isScrollable: true,
        indicator: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFA726), Color(0xFFF57C00)],
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.black87,
        dividerColor: Colors.transparent,
        tabs: const [
          Tab(text: 'New Orders'),
          Tab(text: 'In progress'),
          Tab(text: 'Ready'),
          Tab(text: 'Completed'),
        ],
      ),
    );
  }
}

/* ============================ ORDERS LIST =========================== */

class _OrdersList extends StatelessWidget {
  final String statusLabel;
  final Color statusBorder;
  final Color statusBg;
  final String titlePrefix;
  final void Function(String orderId, String statusLabel) onView;

  const _OrdersList({
    required this.statusLabel,
    required this.statusBorder,
    required this.statusBg,
    this.titlePrefix = 'ORDER - ',
    required this.onView,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
      itemCount: 2,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, i) {
        final id = '00010${i + 1}';
        return _OrderCard(
          title: '$titlePrefix$id',
          itemsCount: 3,
          dateTimeText: '13:45 PM , 20 July 2025',
          price: 78,
          statusLabel: statusLabel,
          statusBorder: statusBorder,
          statusBg: statusBg,
          onView: () => onView(id, statusLabel),
        );
      },
    );
  }
}

class _OrderCard extends StatelessWidget {
  final String title;
  final int itemsCount;
  final String dateTimeText;
  final double price;
  final String statusLabel;
  final Color statusBorder;
  final Color statusBg;
  final VoidCallback onView;

  const _OrderCard({
    required this.title,
    required this.itemsCount,
    required this.dateTimeText,
    required this.price,
    required this.statusLabel,
    required this.statusBorder,
    required this.statusBg,
    required this.onView,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Color(0x11000000), blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title + status pill
          Row(
            children: [
              Expanded(
                child: Text(
                  title.toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.4,
                      ),
                ),
              ),
              _pill(statusLabel, statusBorder, statusBg),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            '$itemsCount items',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.black.withAlpha(140)),
          ),
          const SizedBox(height: 2),
          Text(
            dateTimeText,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.black.withAlpha(140)),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                '\$${price.toStringAsFixed(0)}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
              ),
              const Spacer(),
              SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: onView, // <-- opens order detail via named route
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.transparent,
                    elevation: 2,
                    shadowColor: Colors.black26,
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFF4E4E4E), Color(0xFF1C1C1C)],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                      child: Text(
                        'View',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/* ============================== HELPERS ============================= */

Widget _pill(String text, Color border, Color bg, {IconData? icon, bool dense = false}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: dense ? 10 : 12, vertical: 6),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: border, width: 1),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 16, color: border),
          const SizedBox(width: 6),
        ],
        Text(
          text,
          style: TextStyle(
            color: border,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}
