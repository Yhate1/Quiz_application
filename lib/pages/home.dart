import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_2/pages/subjects.dart';
import 'dart:math' as math;

class GradeModel {
  final int id;
  final String name;
  final String subtitle;
  final String icon;
  final List<Color> gradientColors;
  final List<String> subjects;
  final int progress;
  final String description;

  const GradeModel({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.icon,
    required this.gradientColors,
    required this.subjects,
    required this.progress,
    required this.description,
  });

  static List<GradeModel> get grades => [
    GradeModel(
      id: 1, name: "Grade 1-2", subtitle: "Early Learners", icon: "🌱",
      gradientColors: [const Color(0xFF4ade80), const Color(0xFF10b981)],
      subjects: ["Numbers", "Literature", "Colors", "Shapes"],
      progress: 75, description: "Foundation building for young minds.",
    ),
    GradeModel(
      id: 2, name: "Grade 3-4", subtitle: "Elementary", icon: "🚀",
      gradientColors: [const Color(0xFF60a5fa), const Color(0xFF06b6d4)],
      subjects: ["Math", "Science", "Reading", "Art"],
      progress: 60, description: "Expanding knowledge with core quizzes.",
    ),
    GradeModel(
      id: 3, name: "Grade 5-6", subtitle: "Upper Elementary", icon: "⭐",
      gradientColors: [const Color(0xFFc084fc), const Color(0xFFec4899)],
      subjects: ["Math", "Science", "History", "English"],
      progress: 45, description: "Preparing for middle school assessments.",
    ),
    GradeModel(
      id: 4, name: "Grade 7-8", subtitle: "Middle School", icon: "🔬",
      gradientColors: [const Color(0xFFfb923c), const Color(0xFFef4444)],
      subjects: ["Algebra", "Biology", "Geography", "Literature"],
      progress: 30, description: "Deep dive into specialized topics.",
    ),
    GradeModel(
      id: 5, name: "Grade 9-10", subtitle: "High School", icon: "🎓",
      gradientColors: [const Color(0xFF818cf8), const Color(0xFF9333ea)],
      subjects: ["Physics", "Chemistry", "Geometry", "Coding"],
      progress: 20, description: "College prep with rigorous challenges.",
    ),
    GradeModel(
      id: 6, name: "Grade 11-12", subtitle: "Advanced", icon: "🏆",
      gradientColors: [const Color(0xFFfacc15), const Color(0xFFf97316)],
      subjects: ["Calculus", "Economics", "Statistics", "SAT Prep"],
      progress: 10, description: "Master level for university readiness.",
    ),
  ];
}

class GlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final Color? overlayColor;

  const GlassContainer({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.overlayColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            (overlayColor ?? const Color(0xFF141830)).withOpacity(0.9),
            (overlayColor ?? const Color(0xFF141830)).withOpacity(0.5),
          ],
        ),
        border: Border.all(color: Colors.white.withOpacity(0.12), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        child: Padding(padding: padding ?? EdgeInsets.zero, child: child),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _selectGrade(BuildContext context, GradeModel grade) {
    HapticFeedback.mediumImpact();
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => 
            Subject(grade: grade.name),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 0.15);
          const end = Offset.zero;
          const curve = Curves.easeOutCubic;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var fadeAnimation = animation.drive(Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve)));
          return FadeTransition(opacity: fadeAnimation, child: SlideTransition(position: animation.drive(tween), child: child));
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.height < 700;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      body: SafeArea(
        child: Stack(
          children: [
            ...List.generate(5, (i) {
              final shapes = ['📚', '🎯', '⭐', '🧠', '🏆'];
              return Positioned(
                left: [0.1, 0.85, 0.15, 0.75, 0.5][i] * screenSize.width,
                top: [0.08, 0.18, 0.65, 0.75, 0.4][i] * screenSize.height,
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 1),
                  duration: Duration(seconds: 3 + i),
                  builder: (context, value, _) => Transform.translate(
                    offset: Offset(0, math.sin(value * 2 * math.pi) * 10),
                    child: Opacity(opacity: 0.04, child: Text(shapes[i], style: const TextStyle(fontSize: 36))),
                  ),
                ),
              );
            }),

            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.all(isSmallScreen ? 12 : 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.82,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: GradeModel.grades.length,
                    itemBuilder: (context, index) {
                      final grade = GradeModel.grades[index];
                      return TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: 1),
                        duration: Duration(milliseconds: 350 + (index * 70)),
                        curve: Curves.elasticOut,
                        builder: (context, value, child) {
                          return Transform.scale(scale: value, child: child);
                        },
                        child: GestureDetector(
                          onTap: () => _selectGrade(context, grade),
                          onTapDown: (_) => HapticFeedback.selectionClick(),
                          child: GlassContainer(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 38, height: 38,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        gradient: LinearGradient(colors: grade.gradientColors),
                                        boxShadow: [
                                          BoxShadow(
                                            color: grade.gradientColors[0].withOpacity(0.25),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Center(child: Text(grade.icon, style: const TextStyle(fontSize: 18))),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text('${grade.progress}%', style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: Colors.white)),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(grade.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white), maxLines: 1, overflow: TextOverflow.ellipsis),
                                const SizedBox(height: 1),
                                Text(grade.subtitle, style: const TextStyle(fontSize: 10, color: Colors.white60), maxLines: 1, overflow: TextOverflow.ellipsis),
                                const SizedBox(height: 6),
                                Wrap(
                                  spacing: 4, runSpacing: 4,
                                  children: [
                                    ...grade.subjects.take(2).map((s) => Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.08), borderRadius: BorderRadius.circular(4)),
                                      child: Text(s, style: const TextStyle(fontSize: 8, color: Colors.white60, fontWeight: FontWeight.w500), maxLines: 1, overflow: TextOverflow.ellipsis),
                                    )),
                                    if (grade.subjects.length > 2)
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(color: Colors.white.withOpacity(0.08), borderRadius: BorderRadius.circular(4)),
                                        child: Text('+${grade.subjects.length - 2}', style: const TextStyle(fontSize: 8, color: Colors.white60, fontWeight: FontWeight.w500)),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: isSmallScreen ? 18 : 28),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}