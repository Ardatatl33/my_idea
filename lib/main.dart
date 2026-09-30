import 'package:flutter/material.dart';

void main() {
  runApp(const DPlanApp());
}

class DPlanApp extends StatelessWidget {
  const DPlanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'D-Plan',
      theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Arial'),
      home: const HomePage(),
    );
  }
}

class DailyTask {
  DailyTask({required this.title, required this.isCompleted});

  final String title;
  bool isCompleted;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<DailyTask> tasks = [
    DailyTask(title: 'Sabah planını hazırla', isCompleted: true),
    DailyTask(title: 'E-postaları kontrol et', isCompleted: true),
    DailyTask(title: '30 dakika odaklan', isCompleted: true),
    DailyTask(title: 'Sunum taslağını hazırla', isCompleted: false),
    DailyTask(title: 'Günü değerlendir', isCompleted: false),
  ];

  int get totalTasks => tasks.length;
  int get completedTasks => tasks.where((task) => task.isCompleted).length;
  double get progress => completedTasks / totalTasks;
  int get percentage => (progress * 100).round();
  bool get allCompleted => completedTasks == totalTasks;

  String? get nextTaskTitle {
    final index = tasks.indexWhere((task) => !task.isCompleted);
    return index == -1 ? null : tasks[index].title;
  }

  void toggleTask(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF35131F), Color(0xFF101525), Color(0xFF210E18)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Üst başlık
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Günaydın, Arda',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Icon(
                            Icons.person_outline,
                            color: Color(0xFFE83E7D),
                            size: 32,
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // Bölüm başlığı
                      const Row(
                        children: [
                          Icon(
                            Icons.checklist_rounded,
                            color: Color(0xFF358BFF),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Bugünün Görevleri',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Text(
                            'Tümünü gör',
                            style: TextStyle(
                              color: Color(0xFF358BFF),
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      // İlerleme kartı
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFF22243D,
                          ).withValues(alpha: 0.85),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: const Color(0xFF5063C7),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 250),
                              child: Text(
                                allCompleted
                                    ? 'Bugünkü $totalTasks görevin tamamlandı!'
                                    : '$totalTasks görevden $completedTasks tanesi tamamlandı',
                                key: ValueKey(completedTasks),
                                style: const TextStyle(
                                  color: Color(0xFFD5D4DE),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                            const SizedBox(height: 8),

                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 250),
                              child: Text(
                                '%$percentage',
                                key: ValueKey(percentage),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 42,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),

                            const SizedBox(height: 12),

                            TweenAnimationBuilder<double>(
                              tween: Tween<double>(end: progress),
                              duration: const Duration(milliseconds: 450),
                              curve: Curves.easeOutCubic,
                              builder: (context, value, child) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: LinearProgressIndicator(
                                    value: value,
                                    minHeight: 11,
                                    backgroundColor: const Color(0xFF3C426D),
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                          Color(0xFF358BFF),
                                        ),
                                  ),
                                );
                              },
                            ),

                            const SizedBox(height: 20),

                            Row(
                              children: [
                                Icon(
                                  allCompleted
                                      ? Icons.check_circle_outline_rounded
                                      : Icons.arrow_circle_right_outlined,
                                  color: const Color(0xFF358BFF),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    allCompleted
                                        ? 'Harika! Bugünün planı tamamlandı.'
                                        : 'Sıradaki: $nextTaskTitle',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            const Divider(color: Color(0xFF454A68)),

                            const SizedBox(height: 6),

                            ...List.generate(tasks.length, (index) {
                              final task = tasks[index];

                              return Semantics(
                                button: true,
                                checked: task.isCompleted,
                                label: task.title,
                                child: InkWell(
                                  key: ValueKey('task-$index'),
                                  onTap: () => toggleTask(index),
                                  borderRadius: BorderRadius.circular(14),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                    ),
                                    child: Row(
                                      children: [
                                        AnimatedContainer(
                                          duration: const Duration(
                                            milliseconds: 220,
                                          ),
                                          width: 28,
                                          height: 28,
                                          decoration: BoxDecoration(
                                            color: task.isCompleted
                                                ? const Color(0xFF358BFF)
                                                : Colors.transparent,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: task.isCompleted
                                                  ? const Color(0xFF358BFF)
                                                  : const Color(0xFF7A7F9D),
                                              width: 2,
                                            ),
                                          ),
                                          child: task.isCompleted
                                              ? const Icon(
                                                  Icons.check_rounded,
                                                  color: Colors.white,
                                                  size: 18,
                                                )
                                              : null,
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: AnimatedDefaultTextStyle(
                                            duration: const Duration(
                                              milliseconds: 220,
                                            ),
                                            style: TextStyle(
                                              color: task.isCompleted
                                                  ? const Color(0xFF8F93AA)
                                                  : Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              decoration: task.isCompleted
                                                  ? TextDecoration.lineThrough
                                                  : TextDecoration.none,
                                            ),
                                            child: Text(task.title),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),

                            const SizedBox(height: 8),

                            const Center(
                              child: Text(
                                'Durumunu değiştirmek için bir göreve dokun',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFFD5D4DE),
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
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
}
