import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/helpers/currency_formatter.dart';
import '../../../../features/auth/presentation/providers/auth_provider.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);
    final greeting = _getGreeting();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: userAsync.when(
          data: (user) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(greeting, style: AppTextStyles.bodySmall),
              Text(
                user?.displayName ?? 'Sales Manager',
                style: AppTextStyles.titleMedium,
              ),
            ],
          ),
          loading: () => const SizedBox.shrink(),
          error: (_, __) => const Text('Dashboard'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: userAsync.when(
              data: (user) => GestureDetector(
                onTap: () {},
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.primary.withOpacity(0.15),
                  child: Text(
                    user?.displayName.isNotEmpty == true
                        ? user!.displayName[0].toUpperCase()
                        : '?',
                    style: AppTextStyles.labelMedium
                        .copyWith(color: AppColors.primary),
                  ),
                ),
              ),
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(currentUserProvider);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // KPI Cards Row
              Row(
                children: [
                  Expanded(
                    child: _KpiCard(
                      title: "Today's Sales",
                      value: CurrencyFormatter.formatCompact(12450),
                      change: '+12.5%',
                      isPositive: true,
                      icon: Icons.attach_money,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _KpiCard(
                      title: 'New Orders',
                      value: '24',
                      change: '+3',
                      isPositive: true,
                      icon: Icons.receipt_long_outlined,
                      color: AppColors.secondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _KpiCard(
                      title: 'Customers',
                      value: '156',
                      change: '+8',
                      isPositive: true,
                      icon: Icons.people_outline,
                      color: AppColors.warning,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _KpiCard(
                      title: 'Low Stock',
                      value: '7',
                      change: '-2',
                      isPositive: false,
                      icon: Icons.inventory_2_outlined,
                      color: AppColors.error,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Sales Chart
              Text('Sales Overview', style: AppTextStyles.titleMedium),
              const SizedBox(height: 4),
              Text(
                DateFormat('MMMM yyyy').format(DateTime.now()),
                style: AppTextStyles.bodySmall,
              ),
              const SizedBox(height: 16),
              const _SalesChart(),
              const SizedBox(height: 24),

              // Recent Orders
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Recent Orders', style: AppTextStyles.titleMedium),
                  TextButton(
                    onPressed: () {},
                    child: const Text('See all'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ...List.generate(
                3,
                (i) => _RecentOrderTile(index: i),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning,';
    if (hour < 17) return 'Good afternoon,';
    return 'Good evening,';
  }
}

class _KpiCard extends StatelessWidget {
  const _KpiCard({
    required this.title,
    required this.value,
    required this.change,
    required this.isPositive,
    required this.icon,
    required this.color,
  });

  final String title;
  final String value;
  final String change;
  final bool isPositive;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.grey200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 18),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: isPositive
                      ? AppColors.success.withOpacity(0.12)
                      : AppColors.error.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                      size: 10,
                      color:
                          isPositive ? AppColors.success : AppColors.error,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      change,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: isPositive ? AppColors.success : AppColors.error,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(value, style: AppTextStyles.titleLarge),
          const SizedBox(height: 2),
          Text(title, style: AppTextStyles.bodySmall),
        ],
      ),
    );
  }
}

class _SalesChart extends StatelessWidget {
  const _SalesChart();

  @override
  Widget build(BuildContext context) {
    final spots = [
      FlSpot(0, 3200),
      FlSpot(1, 4500),
      FlSpot(2, 3800),
      FlSpot(3, 6200),
      FlSpot(4, 5100),
      FlSpot(5, 7800),
      FlSpot(6, 6400),
    ];

    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.grey200),
      ),
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(
            show: true,
            horizontalInterval: 2000,
            drawVerticalLine: false,
            getDrawingHorizontalLine: _gridLine,
          ),
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                  final index = value.toInt();
                  if (index < 0 || index >= days.length) return const SizedBox();
                  return Text(days[index], style: AppTextStyles.labelSmall);
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: AppColors.primary,
              barWidth: 2.5,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.primary.withOpacity(0.2),
                    AppColors.primary.withOpacity(0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static FlLine _gridLine(double value) => const FlLine(
        color: AppColors.grey100,
        strokeWidth: 1,
      );
}

class _RecentOrderTile extends StatelessWidget {
  const _RecentOrderTile({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final orders = [
      ('ORD-2401', 'John Smith', '\$1,240', 'Delivered'),
      ('ORD-2400', 'Sarah Lee', '\$890', 'Processing'),
      ('ORD-2399', 'Mike Johnson', '\$2,100', 'Pending'),
    ];
    final order = orders[index];

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey200),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.grey100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.receipt_outlined,
                color: AppColors.grey400, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(order.$1,
                    style: Theme.of(context).textTheme.titleSmall),
                Text(order.$2,
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(order.$3,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: AppColors.primary)),
              Text(order.$4,
                  style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ],
      ),
    );
  }
}
