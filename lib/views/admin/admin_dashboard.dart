import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text('Tableau de bord'),
        backgroundColor: colorScheme.surface,
        scrolledUnderElevation: 0,
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildDashboardCard(
                  theme,
                  title: 'Livres',
                  subtitle: '124 total',
                  icon: Icons.menu_book_rounded,
                  color: Colors.orange,
                  onTap: () {},
                ),
                _buildDashboardCard(
                  theme,
                  title: 'Membres',
                  subtitle: '45 actifs',
                  icon: Icons.people_rounded,
                  color: Colors.blue,
                  onTap: () {},
                ),
                _buildDashboardCard(
                  theme,
                  title: 'Emprunts',
                  subtitle: '12 en cours',
                  icon: Icons.bookmark_rounded,
                  color: Colors.green,
                  onTap: () {},
                ),
                _buildDashboardCard(
                  theme,
                  title: 'Retards',
                  subtitle: '3 attention',
                  icon: Icons.warning_rounded,
                  color: Colors.red,
                  onTap: () {},
                ),
                _buildDashboardCard(
                  theme,
                  title: 'Événements',
                  subtitle: '2 à venir',
                  icon: Icons.event_rounded,
                  color: Colors.purple,
                  onTap: () {},
                ),
                _buildDashboardCard(
                  theme,
                  title: 'Signalements',
                  subtitle: 'Aucun',
                  icon: Icons.flag_rounded,
                  color: Colors.grey,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardCard(
    ThemeData theme, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerHighest,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subtitle,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
