import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Laporan Penjualan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const LaporanHome(),
    );
  }
}

class LaporanHome extends StatelessWidget {
  const LaporanHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Pilih Periode Laporan',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              _buildPeriodCard(
                context,
                'Harian',
                Icons.today,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LaporanPage(period: 'Harian'),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildPeriodCard(
                context,
                'Mingguan',
                Icons.calendar_view_week,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LaporanPage(period: 'Mingguan'),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildPeriodCard(
                context,
                'Bulanan',
                Icons.calendar_month,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LaporanPage(period: 'Bulanan'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPeriodCard(
      BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 40, color: Colors.blue),
            const SizedBox(width: 20),
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

class LaporanPage extends StatefulWidget {
  final String period;

  const LaporanPage({Key? key, required this.period}) : super(key: key);

  @override
  State<LaporanPage> createState() => _LaporanPageState();
}

class _LaporanPageState extends State<LaporanPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        selectedTab = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Laporan ${widget.period}'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Laporan',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TabBar(
                          controller: _tabController,
                          indicator: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.grey,
                          tabs: const [
                            Tab(text: 'bulanan'),
                            Tab(text: 'harian'),
                            Tab(text: 'mingguan'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildInfoCard('Penjualan Teratas', '201,0000'),
                      const SizedBox(height: 12),
                      _buildInfoCard('Transaksi', '20'),
                      const SizedBox(height: 12),
                      _buildInfoCard('Pelanggan', '56'),
                      const SizedBox(height: 12),
                      _buildInfoCard('Barang Terjual', '100'),
                      const SizedBox(height: 24),
                      Container(
                        height: 200,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: LineChart(
                          LineChartData(
                            gridData: FlGridData(show: false),
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 30,
                                  interval: 20,
                                ),
                              ),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 30,
                                  getTitlesWidget: (value, meta) {
                                    const titles = [
                                      'Pigment',
                                      'Bracelet',
                                      'Hairclip'
                                    ];
                                    if (value.toInt() >= 0 &&
                                        value.toInt() < titles.length) {
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          titles[value.toInt()],
                                          style: const TextStyle(fontSize: 10),
                                        ),
                                      );
                                    }
                                    return const SizedBox();
                                  },
                                ),
                              ),
                            ),
                            borderData: FlBorderData(show: false),
                            minX: 0,
                            maxX: 2,
                            minY: 0,
                            maxY: 100,
                            lineBarsData: [
                              LineChartBarData(
                                spots: [
                                  FlSpot(0, 60),
                                  FlSpot(1, 65),
                                  FlSpot(2, 90),
                                ],
                                isCurved: true,
                                color: Colors.blue,
                                barWidth: 3,
                                dotData: FlDotData(show: true),
                                belowBarData: BarAreaData(show: false),
                              ),
                              LineChartBarData(
                                spots: [
                                  FlSpot(0, 70),
                                  FlSpot(1, 40),
                                  FlSpot(2, 50),
                                ],
                                isCurved: true,
                                color: Colors.pink.shade200,
                                barWidth: 3,
                                dotData: FlDotData(show: true),
                                belowBarData: BarAreaData(show: false),
                              ),
                              LineChartBarData(
                                spots: [
                                  FlSpot(0, 45),
                                  FlSpot(1, 60),
                                  FlSpot(2, 35),
                                ],
                                isCurved: true,
                                color: Colors.grey,
                                barWidth: 3,
                                dotData: FlDotData(show: true),
                                belowBarData: BarAreaData(show: false),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Transaksi Terkini',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const Divider(),
                            _buildTransactionItem(
                              'Aretha',
                              ['1x Labubu Soymilk', '1x Photo Keychain'],
                              ['Rp. 245.000', 'Rp. 65.000'],
                              'Rp. 310.000',
                              '12.00',
                            ),
                            const Divider(),
                            _buildTransactionItem(
                              'Angie',
                              ['1x Hacipupu Aries', '1x Bracelet Blacklove'],
                              ['Rp. 200.000', 'Rp. 25.000'],
                              'Rp. 225.000',
                              '13.00',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink[100],
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Cetak Penjualan Teratas (PDF)'),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink[100],
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Cetak Laporan Transaksi (PDF)'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(String name, List<String> items,
      List<String> prices, String total, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(time),
            ],
          ),
          const SizedBox(height: 8),
          ...List.generate(items.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(items[index], style: const TextStyle(fontSize: 13)),
                  Text(prices[index], style: const TextStyle(fontSize: 13)),
                ],
              ),
            );
          }),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total :',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                total,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}