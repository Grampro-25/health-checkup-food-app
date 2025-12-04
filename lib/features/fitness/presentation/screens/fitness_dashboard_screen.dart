import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class FitnessDashboardScreen extends StatelessWidget {
  const FitnessDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Activity Summary Card
            _buildActivitySummaryCard(context),
            const SizedBox(height: 24),
            
            // Weekly Activity Chart
            Text(
              'Weekly Activity',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            _buildWeeklyChart(context),
            const SizedBox(height: 24),
            
            // Goals
            Text(
              'Your Goals',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            _buildGoalCard('Steps', 8542, 10000, Icons.directions_walk),
            const SizedBox(height: 12),
            _buildGoalCard('Calories Burned', 450, 600, Icons.local_fire_department),
            const SizedBox(height: 12),
            _buildGoalCard('Active Minutes', 35, 60, Icons.timer),
            const SizedBox(height: 24),
            
            // Workout Plans
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recommended Workouts',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildWorkoutCard(
              'Morning Yoga',
              '20 mins',
              'Beginner',
              Icons.self_improvement,
              const Color(0xFF9C27B0),
            ),
            const SizedBox(height: 12),
            _buildWorkoutCard(
              'HIIT Cardio',
              '30 mins',
              'Intermediate',
              Icons.flash_on,
              const Color(0xFFFF5722),
            ),
            const SizedBox(height: 12),
            _buildWorkoutCard(
              'Strength Training',
              '45 mins',
              'Advanced',
              Icons.fitness_center,
              const Color(0xFF2196F3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivitySummaryCard(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Today's Activity",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActivityStat('8,542', 'Steps', Icons.directions_walk),
                _buildActivityStat('450', 'Cal', Icons.local_fire_department),
                _buildActivityStat('35', 'Min', Icons.timer),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityStat(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 32),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildWeeklyChart(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 200,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 12000,
              barTouchData: BarTouchData(enabled: false),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                      return Text(
                        days[value.toInt()],
                        style: const TextStyle(fontSize: 12),
                      );
                    },
                  ),
                ),
                leftTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              borderData: FlBorderData(show: false),
              barGroups: [
                BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 8000, color: const Color(0xFF2196F3))]),
                BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 9500, color: const Color(0xFF2196F3))]),
                BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 7200, color: const Color(0xFF2196F3))]),
                BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 10200, color: const Color(0xFF2196F3))]),
                BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 8542, color: const Color(0xFF4CAF50))]),
                BarChartGroupData(x: 5, barRods: [BarChartRodData(toY: 6500, color: Colors.grey)]),
                BarChartGroupData(x: 6, barRods: [BarChartRodData(toY: 5000, color: Colors.grey)]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGoalCard(String label, int current, int target, IconData icon) {
    final progress = (current / target).clamp(0.0, 1.0);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: const Color(0xFF2196F3)),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Text(
                  '$current / $target',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 10,
                backgroundColor: Colors.grey.shade200,
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4CAF50)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutCard(
    String title,
    String duration,
    String level,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('$duration • $level'),
        trailing: const Icon(Icons.play_arrow),
        onTap: () {},
      ),
    );
  }
}
